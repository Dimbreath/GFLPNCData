-- params : ...
-- function num : 0 , upvalues : _ENV
local UIStarUpSuccess = class("UIStarUpSuccess", UIBaseWindow)
local base = UIBaseWindow
local UINStarUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local cs_ResLoader = CS.ResLoader
local cs_tweening = (CS.DG).Tweening
local nodeDataList = {
[1] = {key = false, height = 122.47}
, 
[2] = {key = false, height = 308.8929}
, 
[3] = {key = false, height = 260}
, 
[4] = {key = false, height = 216}
}
UIStarUpSuccess.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINStarUpAttrItem, cs_ResLoader
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.__OnClickBack)
  self.StarList = {}
  ;
  (table.insert)(self.StarList, (self.ui).img_Star)
  self.attrItemPool = (UIItemPool.New)(UINStarUpAttrItem, (self.ui).attriItem)
  ;
  ((self.ui).attriItem):SetActive(false)
  self.resloader = (cs_ResLoader.Create)()
end

UIStarUpSuccess.InitStarUpSuccess = function(self, starupDataDiff)
  -- function num : 0_1 , upvalues : _ENV, nodeDataList
  AudioManager:PlayAudioById(1109)
  ;
  ((self.ui).parSys_success):Play()
  self.heroData = PlayerDataCenter:GetHeroData(starupDataDiff.heroId)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (nodeDataList[1]).key = self:RefreshStarNum(starupDataDiff.curRank)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (nodeDataList[2]).key = self:RefreshAttrs(starupDataDiff.oldRank, starupDataDiff.curRank)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (nodeDataList[3]).key = self:RefreshAthSlot(starupDataDiff.oldAthslotList, starupDataDiff.curAthslotList)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (nodeDataList[4]).key = self:RefreshUltimateSkill(starupDataDiff.oldSkillLevelDic, starupDataDiff.skillLevelDic)
  self:__InitTheTween(nodeDataList)
  self.wait4Close = true
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).btn_background).interactable = false
  ;
  ((self.ui).obj_texContinue):SetActive(false)
  self.timer = (TimerManager:GetTimer(1, function()
    -- function num : 0_1_0 , upvalues : self
    self.timer = nil
    self.wait4Close = false
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((self.ui).btn_background).interactable = true
    ;
    ((self.ui).obj_texContinue):SetActive(true)
  end
, self, true, false, false)):Start()
end

UIStarUpSuccess.__InitTheTween = function(self, nodeDataList)
  -- function num : 0_2 , upvalues : cs_tweening, _ENV
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill()
  end
  self.tweenSeq = ((cs_tweening.DOTween).Sequence)()
  local count = 0
  local delay = 0
  for index,data in ipairs(nodeDataList) do
    if data.key then
      count = count + 1
      delay = count == 2 and 0.35 or 0
      self:__SetNodeShowTween(index, data.height, delay)
    end
  end
end

UIStarUpSuccess.__SetNodeShowTween = function(self, index, height, SetDelay)
  -- function num : 0_3 , upvalues : _ENV, cs_tweening
  local delay = SetDelay or 0
  local fade = ((self.ui).fadeList)[index]
  local layout = ((self.ui).layoutList)[index]
  layout.minHeight = 0
  ;
  (self.tweenSeq):Append((layout:DOMinSize((Vector2.New)(0, height), 0.15, true)):SetDelay(delay))
  if index == 1 then
    (self.tweenSeq):Join((fade:DOFade(0, 0.1)):SetLoops(6, (cs_tweening.LoopType).Yoyo))
  else
    fade.alpha = 0
    ;
    (self.tweenSeq):Join(fade:DOFade(1, 0.15))
  end
end

UIStarUpSuccess.RefreshStarNum = function(self, starNum)
  -- function num : 0_4 , upvalues : _ENV
  for _,starGo in ipairs(self.StarList) do
    (starGo.gameObject):SetActive(false)
  end
  local count = (math.ceil)(starNum / 2)
  local isHalf = starNum % 2 == 1
  for i = 1, count do
    if (self.StarList)[i] ~= nil then
      (((self.StarList)[i]).gameObject):SetActive(true)
      ;
      ((self.StarList)[i]):SetIndex(0)
    else
      local imgItemInfo = (((self.ui).img_Star):Instantiate()):GetComponent(typeof(CS.UiImageItemInfo))
      ;
      (table.insert)(self.StarList, imgItemInfo)
      ;
      (imgItemInfo.gameObject):SetActive(true)
    end
  end
  if isHalf then
    ((self.StarList)[count]):SetIndex(1)
  end
  do return true end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UIStarUpSuccess.RefreshAttrs = function(self, oldRank, newRank)
  -- function num : 0_5 , upvalues : _ENV
  (self.attrItemPool):HideAll()
  local changeList = (self.heroData):GetDifferAttrWhenRankUp(newRank, nil, oldRank, nil, nil, nil)
  if #changeList >= 10 then
    for index,data in ipairs(changeList) do
      if index <= 10 then
        do
          local item = (self.attrItemPool):GetOne()
          item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  else
    if #changeList < 10 then
      local showedIds = {}
      local num = #changeList
      for index,data in ipairs(changeList) do
        (table.insert)(showedIds, data.attrId)
      end
      for _,attrId in ipairs((ConfigData.attribute).baseAttrIds) do
        -- DECOMPILER ERROR at PC67: Unhandled construct in 'MakeBoolean' P1

        if ((ConfigData.attribute)[attrId]).merge_attribute == 0 and num < 10 then
          do
            if not (table.contain)(showedIds, attrId) then
              num = num + 1
              ;
              (table.insert)(changeList, {attrId = attrId, property = ((ConfigData.attribute)[attrId]).attribute_priority, oldAttr = (self.heroData):GetAttr(attrId, nil, true), newAttr = nil})
            end
            -- DECOMPILER ERROR at PC87: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC87: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      ;
      (table.sort)(changeList, function(a, b)
    -- function num : 0_5_0
    if a.attrId >= b.attrId then
      do return a.property ~= b.property end
      do return a.property < b.property end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
      for index,data in ipairs(changeList) do
        local item = (self.attrItemPool):GetOne()
        item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
      end
    end
  end
  do
    do return #changeList >= 1 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

UIStarUpSuccess.RefreshAthSlot = function(self, oldAthslotList, curAthslotList)
  -- function num : 0_6 , upvalues : _ENV
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm) then
    ((self.ui).athAreaNode):SetActive(false)
    return false
  end
  local totalAddNum = 0
  local increasedAthSlotIndex = nil
  local areaItemList = {}
  ;
  (table.insert)(areaItemList, {obj = (self.ui).areaItem, 
ui = {}
})
  for index,curNum in ipairs(curAthslotList) do
    do
      if index > 1 then
        local obj = ((self.ui).areaItem):Instantiate()
        ;
        (table.insert)(areaItemList, {obj = obj, 
ui = {}
})
      end
      local areaItem = areaItemList[index]
      ;
      (UIUtil.LuaUIBindingTable)(areaItem.obj, areaItem.ui)
      do
        local oldNum = oldAthslotList[index]
        for i = 1, oldNum do
          -- DECOMPILER ERROR at PC61: Confused about usage of register: R17 in 'UnsetPending'

          (((areaItem.ui).arry_AthSlot)[i]).color = (areaItem.ui).color_unlocked
        end
        for i = oldNum + 1, curNum do
          -- DECOMPILER ERROR at PC72: Confused about usage of register: R17 in 'UnsetPending'

          (((areaItem.ui).arry_AthSlot)[i]).color = (areaItem.ui).color_new
        end
        for i = curNum + 1, 8 do
          -- DECOMPILER ERROR at PC83: Confused about usage of register: R17 in 'UnsetPending'

          (((areaItem.ui).arry_AthSlot)[i]).color = (areaItem.ui).color_locked
        end
        if oldNum < curNum then
          increasedAthSlotIndex = index
          totalAddNum = totalAddNum + curNum - oldNum
        end
        -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  if totalAddNum == 0 then
    ((self.ui).athAreaNode):SetActive(false)
    return false
  end
  ;
  ((self.ui).athAreaNode):SetActive(true)
  -- DECOMPILER ERROR at PC113: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_AddAreaNum).text = "+" .. tostring(totalAddNum)
  do
    if increasedAthSlotIndex ~= nil then
      local athAreaCfg = (ConfigData.ath_area)[increasedAthSlotIndex]
      if athAreaCfg == nil then
        error("can\'t read athAreaCfg with slotId = " .. tostring(increasedAthSlotIndex))
      else
        ;
        ((self.ui).tex_AthAreaName):SetIndex(0, (LanguageUtil.GetLocaleText)(((ConfigData.ath_area)[increasedAthSlotIndex]).name2))
      end
    end
    return true
  end
end

UIStarUpSuccess.RefreshUltimateSkill = function(self, oldSkillLevelDic, skillLevelDic)
  -- function num : 0_7 , upvalues : _ENV, UINBaseSkillItem
  local diffSkillId, isUnlock = nil, nil
  for skillId,level in pairs(skillLevelDic) do
    if oldSkillLevelDic[skillId] > 0 then
      do
        isUnlock = oldSkillLevelDic[skillId] == level
        diffSkillId = skillId
        do break end
        -- DECOMPILER ERROR at PC15: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC15: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if diffSkillId == nil then
    ((self.ui).obj_skillNode):SetActive(false)
    return 
  end
  ;
  ((self.ui).obj_skillNode):SetActive(true)
  if self.skillItem == nil then
    self.skillItem = (UINBaseSkillItem.New)()
    ;
    (self.skillItem):Init((self.ui).skillItem)
  end
  local targetSkillData = nil
  for _,skillData in ipairs((self.heroData).skillList) do
    if skillData.dataId == diffSkillId then
      targetSkillData = skillData
      break
    end
  end
  if targetSkillData == nil then
    ((self.ui).obj_skillNode):SetActive(false)
    return 
  end
  if targetSkillData:IsUniqueSkill() then
    if isUnlock then
      ((self.ui).tex_SkillTitle):SetIndex(1)
    else
      ((self.ui).tex_SkillTitle):SetIndex(0)
    end
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = targetSkillData:GetName() .. " LV." .. tostring(targetSkillData.level)
  else
    if isUnlock then
      ((self.ui).tex_SkillTitle):SetIndex(3)
    else
      ((self.ui).tex_SkillTitle):SetIndex(2)
    end
    -- DECOMPILER ERROR at PC107: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = targetSkillData:GetName()
  end
  ;
  (self.skillItem):InitBaseSkillItem(targetSkillData, self.resloader)
  -- DECOMPILER ERROR at PC117: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Intro).text = targetSkillData:GetCurLevelDescribe()
  do return true end
  -- DECOMPILER ERROR: 14 unprocessed JMP targets
end

UIStarUpSuccess.SetStarUpSuccessCloseCallBack = function(self, callback)
  -- function num : 0_8
  self.__closeCallBack = callback
end

UIStarUpSuccess.__OnClickBack = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.wait4Close then
    return 
  end
  local getHeroWin = UIManager:GetWindow(UIWindowTypeID.GetHero)
  if getHeroWin ~= nil then
    getHeroWin:Delete()
  end
  self:Delete()
end

UIStarUpSuccess.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  ((self.ui).parSys_success):Stop()
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.__closeCallBack ~= nil then
    (self.__closeCallBack)()
  end
  if self.tweenSeq ~= nil then
    (self.tweenSeq):Kill()
    self.tweenSeq = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIStarUpSuccess

