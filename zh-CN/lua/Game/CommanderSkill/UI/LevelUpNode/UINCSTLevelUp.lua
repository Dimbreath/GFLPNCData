local UINCSTLevelUp = class("UINCSTLevelUp", UIBaseNode)
local base = UIBaseNode
local UINAthMatUpItem = require("Game.Arithmetic.AthList.Area.MatUpgrade.UINAthMatUpItem")
local UINCSTLvUpSkillUnlockList = require("Game.CommanderSkill.UI.LevelUpNode.UINCSTLvUpSkillUnlockList")
local UINTweenUtil = require("Game.CommonUI.Tween.UINTweenUtil")
UINCSTLevelUp.ctor = function(self, cstMainRoot)
  -- function num : 0_0
  self.cstMainRoot = cstMainRoot
end

UINCSTLevelUp.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINAthMatUpItem, UINCSTLvUpSkillUnlockList
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Clear, self, self._OnClickClear)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self._OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnClickClose)
  ;
  ((self.ui).uINUpgradeItem):SetActive(false)
  self.expItemPool = (UIItemPool.New)(UINAthMatUpItem, (self.ui).uINUpgradeItem)
  self.__OnItemChange = BindCallback(self, self._OnItemChange)
  self.levelCfg = ConfigData.commander_skill_level
  self.maxLevel = #self.levelCfg
  self.upgradeBtnDefaultColor = ((self.ui).img_Upgrade).color
  self.skillUnlockList = (UINCSTLvUpSkillUnlockList.New)()
  ;
  (self.skillUnlockList):Init((self.ui).scrollRect)
end

UINCSTLevelUp.InitCSTLevelUp = function(self, cmdSkillCtrl, treeData, resLoader)
  -- function num : 0_2 , upvalues : _ENV
  (UIUtil.HideTopStatus)()
  AudioManager:PlayAudioById(1067)
  self.cmdSkillCtrl = cmdSkillCtrl
  self.expItemNums = {}
  self.newLevel = nil
  self.treeData = treeData
  self.resLoader = resLoader
  self.curExp = treeData.curExp
  self:_RefreshIsFullLvUI()
  self.isInit = true
  self:_RefreshLvUpItems()
  self:_CalAndRefreshExpBar()
  self:_Clear()
  self.isInit = false
end

UINCSTLevelUp._OnItemChange = function(self)
  -- function num : 0_3
  self:_KillLvUpSeq(true)
  self:_RefreshLvUpItems()
  self:_CalAndRefreshExpBar()
end

UINCSTLevelUp._RefreshLvUpItems = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self.expItemPool):HideAll()
  for _,id in ipairs(((ConfigData.item).growUpIds)[eItemActionType.CommanderSkillExp]) do
    if (PlayerDataCenter.itemDic)[id] ~= nil then
      local itemData = (PlayerDataCenter.itemDic)[id]
      do
        local item = (self.expItemPool):GetOne()
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (item.gameObject).name = tostring(id)
        item:InitExpItem(itemData, function(num)
    -- function num : 0_4_0 , upvalues : self, itemData
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    (self.expItemNums)[itemData] = num
    self:_CalAndRefreshExpBar()
  end
)
      end
    else
      do
        do
          local item = (self.expItemPool):GetOne()
          item:InitEmptyExpItem(id)
          -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UINCSTLevelUp._CalAndRefreshExpBar = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local level = (self.treeData).level or 1
  local curExp = self.curExp or 0
  local addExp = self:_CalAddExp() or 0
  local maxAddExp = -curExp
  for i = level, self.maxLevel - 1 do
    maxAddExp = maxAddExp + ((self.levelCfg)[i]).exp
  end
  self:_SetAddExpLimt(maxAddExp, addExp)
  ;
  ((self.ui).tex_AddExp):SetIndex(0, tostring(addExp))
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

  if maxAddExp == 0 or maxAddExp <= addExp then
    if not self._waitLvUpTween then
      ((self.ui).img_Bar).fillAmount = 1
      self:_UpdateLevel(self.maxLevel)
    end
    ;
    ((self.ui).tex_Exp):SetIndex(1)
    ;
    (((self.ui).tex_Exp).gameObject):SetActive(false)
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).btn_Upgrade).interactable = addExp > 0
    self:_RefreshConfirmBtnState(addExp > 0)
    return 
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINCSTLevelUp._CalAddExp = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local totalExp = 0
  for itemData,num in pairs(self.expItemNums) do
    totalExp = totalExp + itemData:GetActionArg(1) * num
  end
  return totalExp
end

UINCSTLevelUp._SetAddExpLimt = function(self, maxAddExp, addExp)
  -- function num : 0_7 , upvalues : _ENV
  for _,item in ipairs((self.expItemPool).listItem) do
    item:SetAddExpLimt(maxAddExp, addExp)
  end
end

UINCSTLevelUp._UpdateLevel = function(self, newlevel)
  -- function num : 0_8 , upvalues : _ENV
  local curLevel = (self.treeData).level
  if curLevel > 9 then
    ((self.ui).tex_CurLevel):SetIndex(1, tostring(curLevel))
  else
    ;
    ((self.ui).tex_CurLevel):SetIndex(0, tostring(curLevel))
  end
  local isMaxLevel = curLevel == self.maxLevel
  ;
  (((self.ui).tex_NextLevel).gameObject):SetActive(not isMaxLevel)
  ;
  ((self.ui).obj_Arrow):SetActive(not isMaxLevel)
  if isMaxLevel then
    return 
  end
  if newlevel > 9 then
    ((self.ui).tex_NextLevel):SetIndex(1, tostring(newlevel))
  else
    ((self.ui).tex_NextLevel):SetIndex(0, tostring(newlevel))
  end
  self:_RefreshUnlockSkill(newlevel)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINCSTLevelUp._RefreshConfirmBtnState = function(self, canUp)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).btn_Upgrade).interactable = canUp
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if not canUp or not self.upgradeBtnDefaultColor then
    ((self.ui).img_Upgrade).color = Color.gray
  end
end

UINCSTLevelUp._Clear = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.newLevel = nil
  for _,item in ipairs((self.expItemPool).listItem) do
    item:CleanAll()
  end
  self.expItemNums = {}
end

UINCSTLevelUp._RefreshUnlockSkill = function(self, newLevel)
  -- function num : 0_11 , upvalues : _ENV
  if self.newLevel == newLevel then
    return 
  end
  self.newLevel = newLevel
  local unlockSkillList = {}
  local levelSkillCfg = ((ConfigData.commander_skill_unlock).treeLevelSkillCfg)[(self.treeData).treeId]
  for treelevel = (self.treeData).level + 1, self.maxLevel do
    local skillDic = levelSkillCfg[treelevel]
    if skillDic ~= nil then
      for skillId,skillLevel in pairs(skillDic) do
        local skillData = ((self.treeData).commanderSkillDataDic)[skillId]
        if skillData.type == (skillData.skillType).active or skillData.type == (skillData.skillType).passive then
          (table.insert)(unlockSkillList, {skillId = skillId, skillLevel = skillLevel, treeLevel = treelevel})
        end
      end
    end
  end
  ;
  (table.sort)(unlockSkillList, function(a, b)
    -- function num : 0_11_0
    if a.skillId >= b.skillId then
      do return a.treeLevel ~= b.treeLevel end
      do return a.treeLevel < b.treeLevel end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  ;
  (self.skillUnlockList):InitCSTLvUpSkillUnlockList(self.resLoader, unlockSkillList, newLevel, self.treeData, self.isInit)
end

UINCSTLevelUp._PopUnlockSkillMessageTip = function(self, skillDataList)
  -- function num : 0_12 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(window)
    -- function num : 0_12_0 , upvalues : _ENV, skillDataList
    if window == nil then
      return 
    end
    for _,data in ipairs(skillDataList) do
      local msg = nil
      if data.level == 1 then
        msg = ConfigData:GetTipContent(TipContent.CST_unlockTip)
        msg = (string.format)(msg, (data.battleSkillCfg).Name)
      else
        msg = ConfigData:GetTipContent(TipContent.CST_unlockTipLevel)
        msg = (string.format)(msg, (data.battleSkillCfg).Name, data.level - 1)
      end
      window:ShowTips(msg)
    end
  end
)
end

UINCSTLevelUp._LevelSkillData = function(self, startLevel, endLevel)
  -- function num : 0_13 , upvalues : _ENV
  local skillDatas = {}
  for i = startLevel + 1, endLevel do
    local treeLevelSkillCfg = ((ConfigData.commander_skill_unlock).treeLevelSkillCfg)[(self.treeData).treeId]
    if treeLevelSkillCfg ~= nil and treeLevelSkillCfg[i] ~= nil then
      for skillId,_ in pairs(treeLevelSkillCfg[i]) do
        local skillData = ((self.treeData).commanderSkillDataDic)[skillId]
        if skillData.type ~= (skillData.skillType).master then
          (table.insert)(skillDatas, skillData)
        end
      end
    end
  end
  return skillDatas
end

UINCSTLevelUp._OnClickClear = function(self)
  -- function num : 0_14 , upvalues : _ENV
  AudioManager:PlayAudioById(1053)
  self:_Clear()
end

UINCSTLevelUp._OnClickClose = function(self)
  -- function num : 0_15 , upvalues : _ENV
  (UIUtil.ReShowTopStatus)()
  self:Hide()
  self:_KillLvUpSeq(true)
  AudioManager:PlayAudioById(1068)
end

UINCSTLevelUp.OnShow = function(self)
  -- function num : 0_16 , upvalues : _ENV
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemChange)
end

UINCSTLevelUp.OnHide = function(self)
  -- function num : 0_17 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemChange)
end

UINCSTLevelUp._RefreshIsFullLvUI = function(self)
  -- function num : 0_18
  local isFullLv = self:_IsFullLv()
  ;
  ((self.ui).obj_normal):SetActive(not isFullLv)
  ;
  ((self.ui).obj_fullLevel):SetActive(isFullLv)
end

UINCSTLevelUp._IsFullLv = function(self)
  -- function num : 0_19
  do return self.maxLevel <= (self.treeData).level or 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINCSTLevelUp.OnDelete = function(self)
  -- function num : 0_20 , upvalues : base
  (self.expItemPool):DeleteAll()
  ;
  (self.skillUnlockList):Delete()
  self:_KillLvUpSeq(false)
  ;
  (base.OnDelete)(self)
end

return UINCSTLevelUp

