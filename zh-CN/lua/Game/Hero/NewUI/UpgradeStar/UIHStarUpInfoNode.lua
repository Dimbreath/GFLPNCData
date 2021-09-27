local UIHStarUpInfoNode = class("UIHStarUpInfoNode", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local UINStarUpStarList = require("Game.Hero.NewUI.UpgradeStar.UINStarUpStarList")
local UIHPreviewItem = require("Game.Hero.NewUI.UpgradeStar.UIHPreviewItem")
local cs_MessageCommon = CS.MessageCommon
local eHeroStarUpEnum = require("Game.Hero.NewUI.UpgradeStar.eHeroStarUpEnum")
local previewType = eHeroStarUpEnum.previewType
local previewItemDatas = {
{name = ConfigData:GetTipContent(602), preType = previewType.normal}
, 
{name = ConfigData:GetTipContent(603), preType = previewType.normal}
, 
{name = ConfigData:GetTipContent(604), preType = previewType.normal}
}
UIHStarUpInfoNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINStarUpStarList, UINBaseItem, UIHPreviewItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.curStarList = (UINStarUpStarList.New)()
  ;
  (self.curStarList):Init((self.ui).obj_CurStarNode)
  self.preStarList = (UINStarUpStarList.New)()
  ;
  (self.preStarList):Init((self.ui).obj_NextStarNode)
  self.fragBaseItem = (UINBaseItem.New)()
  ;
  (self.fragBaseItem):Init((self.ui).obj_HeroFragBase)
  self.promoteItemPool = (UIItemPool.New)(UIHPreviewItem, (self.ui).obj_PreviewItem)
  ;
  ((self.ui).obj_PreviewItem):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Last, self, self.__OnClickBtnLast)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Next, self, self.__OnClickBtnNext)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_StarUp, self, self.__OnClickStarUp)
  self.__onPreviewItemClick = BindCallback(self, self.__PreviewItemClick)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
end

UIHStarUpInfoNode.RefreshStarUpInfoUI = function(self, heroData, preItemAction, btnStarUpAction)
  -- function num : 0_1
  if heroData == nil then
    return 
  end
  self.heroData = heroData
  self.isFullRank = (self.heroData):IsFullRank()
  self.curRank = heroData.rank
  if not self.isFullRank or not heroData.rank then
    self.previewRank = heroData.rank + 1
    self.needfragNum = (self.heroData):StarNeedFrag()
    self.preItemAction = preItemAction
    self.btnStarUpAction = btnStarUpAction
    self:__RefreshStarUI(self.curRank, self.curStarList)
    ;
    ((self.ui).obj_NextStarNode):SetActive(not self.isFullRank)
    ;
    ((self.ui).obj_TexPreview):SetActive(not self.isFullRank)
    ;
    ((self.ui).obj_notFullRank):SetActive(not self.isFullRank)
    ;
    ((self.ui).obj_TexFullRank):SetActive(self.isFullRank)
    self:RefreshCostNode()
    self:__RefreshPreviewLevel(self.previewRank)
    self:__PlayAllDOTween()
  end
end

UIHStarUpInfoNode.RefreshCostNode = function(self)
  -- function num : 0_2
  self.isFullRank = (self.heroData):IsFullRank()
  local currencyId, needCurrencyNum = (self.heroData):StarNeedCurrencyNum()
  local ableUp, fitFrag, fitCurrency, fitExtr = (self.heroData):AbleUpgradeStar()
  self:__SetFragItem()
  self:__SetRefreshCurrency(fitCurrency, currencyId, needCurrencyNum)
  self:__SetStarUpButton(ableUp)
end

UIHStarUpInfoNode.__SetRefreshCurrency = function(self, fitCurrency, currencyId, needCurrencyNum)
  -- function num : 0_3 , upvalues : _ENV
  if self.isFullRank or currencyId == nil then
    ((self.ui).obj_CurrencyCost):SetActive(false)
    return 
  else
    ;
    ((self.ui).obj_CurrencyCost):SetActive(true)
  end
  ;
  ((self.ui).obj_CurrencyCost):SetActive(true)
  local itemCfg = (ConfigData.item)[currencyId]
  if itemCfg == nil then
    error("itemCfg read error id=" .. currencyId)
    return 
  else
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_CurrencyItem).sprite = CRH:GetSprite(itemCfg.small_icon)
    local index = 0
    if fitCurrency then
      index = 1
    else
      index = 0
    end
    local hasCount = PlayerDataCenter:GetItemCount(itemCfg.id) or 0
    ;
    ((self.ui).tex_CurrencyCost):SetIndex(index, tostring(hasCount), tostring(needCurrencyNum))
  end
end

UIHStarUpInfoNode.__SetFragItem = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.needfragNum == 0 then
    ((self.ui).obj_HeroFrag):SetActive(false)
    return 
  end
  ;
  ((self.ui).obj_HeroFrag):SetActive(true)
  local itemCfg = (ConfigData.item)[(self.heroData).fragId]
  if itemCfg == nil then
    error("frag itemCfg error id=" .. (self.heroData).fragId)
  else
    ;
    (self.fragBaseItem):InitBaseItem(itemCfg)
  end
  local totalFragNum = (self.heroData):GetHeroFragCount()
  if self.needfragNum <= totalFragNum then
    ((self.ui).tex_HeroFrag):SetIndex(0, tostring(self.needfragNum), tostring(totalFragNum))
  else
    ;
    ((self.ui).tex_HeroFrag):SetIndex(2, tostring(self.needfragNum), tostring(totalFragNum))
  end
end

UIHStarUpInfoNode.__SetStarUpButton = function(self, ableUp)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if ableUp then
    ((self.ui).img_BtnStarUp).color = (self.ui).col_Orange
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_BtnStarUp).color = (self.ui).col_Gray
  end
end

UIHStarUpInfoNode.__RefreshPreviewLevel = function(self, previewRank)
  -- function num : 0_6
  if not self.isFullRank then
    self:__RefreshStarUI(previewRank, self.preStarList)
  end
  self:__RefreshSwitchBtnUI(previewRank)
  self:__RefreshPreviewItem(previewRank)
  local active = self.isFullRank or previewRank ~= self.curRank + 1
  ;
  ((self.ui).obj_InPreview):SetActive(active)
  ;
  (((self.ui).btn_StarUp).gameObject):SetActive(not active)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIHStarUpInfoNode.__RefreshStarUI = function(self, rank, UINStarUpStarList)
  -- function num : 0_7 , upvalues : _ENV
  local rankCfg = (ConfigData.hero_rank)[rank]
  if rankCfg == nil then
    error("Can\'t find rankCfg, id = " .. tostring(rank))
  end
  UINStarUpStarList:InitStarList(nil, rankCfg.star)
end

UIHStarUpInfoNode.__RefreshSwitchBtnUI = function(self, previewRank)
  -- function num : 0_8 , upvalues : _ENV
  local lastBtnActive = self.curRank + 1 < previewRank
  ;
  (((self.ui).btn_Last).gameObject):SetActive(lastBtnActive)
  local nextBtnActive = previewRank < (ConfigData.hero_rank).maxRank
  ;
  (((self.ui).btn_Next).gameObject):SetActive(nextBtnActive)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIHStarUpInfoNode.__IsAthSlotUpgrade = function(self, targetRank)
  -- function num : 0_9 , upvalues : _ENV
  local oldSlotInfo = (self.heroData):GetAthSlotList(false, targetRank - 1)
  local nowSlotInfo = (self.heroData):GetAthSlotList(false, targetRank)
  local oldNum, newNum = 0, 0
  for _,value in ipairs(oldSlotInfo) do
    oldNum = oldNum + value
  end
  for _,value in ipairs(nowSlotInfo) do
    newNum = newNum + value
  end
  do return oldNum < newNum end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIHStarUpInfoNode.__RefreshPreviewItem = function(self, previewRank)
  -- function num : 0_10 , upvalues : _ENV, previewItemDatas
  self.itemDataList = {}
  for index,data in ipairs(previewItemDatas) do
    if index == 3 and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm) and self:__IsAthSlotUpgrade(previewRank) then
      (table.insert)(self.itemDataList, data)
    end
    ;
    (table.insert)(self.itemDataList, data)
  end
  self:__GenSkillPreviewItemData(previewRank)
  local preRankCfg = self:__GetPreviewRankCfg(previewRank)
  if preRankCfg ~= nil then
    self:__GetSkinPreviewItemData(previewRank, preRankCfg)
    self:__GetRewardPreviewItemData(preRankCfg)
  end
  ;
  (self.promoteItemPool):HideAll()
  for index,data in ipairs(self.itemDataList) do
    local item = (self.promoteItemPool):GetOne()
    item:InitPreviewItem(index, data, self.__onPreviewItemClick)
  end
end

UIHStarUpInfoNode.__GenSkillPreviewItemData = function(self, previewRank)
  -- function num : 0_11 , upvalues : _ENV, previewType
  local preRankCfg = (ConfigData.hero_rank)[previewRank]
  local addSkillDataFunc = function(skillData, tipsId, preUSkilllevel, unlockAdvance, lastStartCdTime, preStartCdTime)
    -- function num : 0_11_0 , upvalues : _ENV, previewType
    local name = nil
    if preUSkilllevel then
      name = (string.format)(ConfigData:GetTipContent(tipsId), skillData:GetName(), tostring(preUSkilllevel))
    else
      if preStartCdTime ~= nil and lastStartCdTime ~= nil then
        name = (string.format)(ConfigData:GetTipContent(tipsId), skillData:GetName(), GetPreciseDecimalStr(lastStartCdTime, 1), GetPreciseDecimalStr(preStartCdTime, 1))
      else
        name = (string.format)(ConfigData:GetTipContent(tipsId), skillData:GetName())
      end
    end
    local preData = {}
    preData.name = name
    preData.preType = previewType.skill
    preData.preUSkilllevel = preUSkilllevel
    preData.unlockAdvance = unlockAdvance
    preData.data = skillData
    return preData
  end

  local preSkillDataActive, preSkillDataPassive, preSkillDataUlt = nil, nil, nil
  for _,skillData in ipairs((self.heroData).skillList) do
    -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

    if skillData:IsUniqueSkill() and ((self.heroData):GetUltimateSkillLevel() < preRankCfg.ultimateskill_level or (skillData.skillCfg).open_star == previewRank) then
      local tipsId = nil
      if (skillData.skillCfg).open_star == previewRank then
        tipsId = 606
      else
        tipsId = 607
      end
      local preUSkilllevel = preRankCfg.ultimateskill_level
      preSkillDataUlt = addSkillDataFunc(skillData, tipsId, preUSkilllevel)
    end
    do
      do
        -- DECOMPILER ERROR at PC53: Unhandled construct in 'MakeBoolean' P1

        if skillData:IsPassiveSkill() and ((skillData.skillCfg).open_star == previewRank or (skillData.skillCfg).advanced_open_star == previewRank) then
          local tipsId, unlockAdvance = nil, nil
          if (skillData.skillCfg).open_star == previewRank then
            tipsId = 605
            unlockAdvance = false
          else
            tipsId = 612
            unlockAdvance = true
          end
          preSkillDataPassive = addSkillDataFunc(skillData, tipsId, nil, unlockAdvance)
        end
        if skillData:IsNormalSkill() then
          do
            if (skillData.skillCfg).advanced_open_star == previewRank then
              local tipsId = 613
              preSkillDataActive = addSkillDataFunc(skillData, tipsId, nil, true)
            end
            local upStartSkillCd = skillData:GetStartSkillCdUp(previewRank)
            local lastStartSkillCd = skillData:GetStartSkillCDTime(previewRank - 1)
            do
              if upStartSkillCd > 0 then
                local tipsId = 614
                preSkillDataActive = addSkillDataFunc(skillData, tipsId, nil, false, lastStartSkillCd, upStartSkillCd)
              end
              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out DO_STMT

            end
          end
        end
      end
    end
  end
  if preSkillDataUlt ~= nil then
    (table.insert)(self.itemDataList, preSkillDataUlt)
  end
  if preSkillDataPassive ~= nil then
    (table.insert)(self.itemDataList, preSkillDataPassive)
  end
  if preSkillDataActive ~= nil then
    (table.insert)(self.itemDataList, preSkillDataActive)
  end
end

UIHStarUpInfoNode.__GetPreviewRankCfg = function(self, previewRank)
  -- function num : 0_12 , upvalues : _ENV
  local heroId = (self.heroData).dataId
  if heroId == nil or (ConfigData.hero_star)[heroId] == nil or ((ConfigData.hero_star)[heroId])[previewRank] == nil then
    error("can\'t get preRankCfg with heroId:" .. tostring(heroId) .. " rank:" .. tostring(previewRank))
    return 
  end
  return ((ConfigData.hero_star)[heroId])[previewRank]
end

UIHStarUpInfoNode.__GetSkinPreviewItemData = function(self, previewRank, preRankCfg)
  -- function num : 0_13 , upvalues : _ENV, previewType
  local skinId = nil
  for index,itemId in ipairs(preRankCfg.rank_itemIds) do
    local itemConfig = (ConfigData.item)[itemId]
    if itemConfig ~= nil and itemConfig.type == eItemType.Skin then
      skinId = itemId
      break
    end
  end
  do
    if skinId ~= nil and skinId ~= 0 and (PlayerDataCenter.skinData):IsUseful(skinId) then
      local preData = {}
      preData.name = ConfigData:GetTipContent(611)
      preData.preType = previewType.skin
      preData.newSkinId = skinId
      preData.previewRank = previewRank
      ;
      (table.insert)(self.itemDataList, preData)
    end
  end
end

UIHStarUpInfoNode.__GetRewardPreviewItemData = function(self, preRankCfg)
  -- function num : 0_14 , upvalues : _ENV, previewType
  for index,itemId in ipairs(preRankCfg.rank_rewardIds) do
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      warn("itemCfg is null ID:" .. tostring(itemId))
    else
      local preData = {}
      local count = (preRankCfg.rank_rewardNums)[index]
      preData.name = (string.format)(ConfigData:GetTipContent(615), (LanguageUtil.GetLocaleText)(itemCfg.name), tostring(count))
      preData.itemCfg = itemCfg
      preData.preType = previewType.reward
      ;
      (table.insert)(self.itemDataList, preData)
    end
  end
end

UIHStarUpInfoNode.__PlayAllDOTween = function(self)
  -- function num : 0_15
  for i = 1, #(self.ui).infoTweens do
    local tween = ((self.ui).infoTweens)[i]
    tween:DORestart(false)
  end
end

UIHStarUpInfoNode.__OnClickBtnLast = function(self)
  -- function num : 0_16
  self.previewRank = self.previewRank - 1
  self:__RefreshPreviewLevel(self.previewRank)
end

UIHStarUpInfoNode.__OnClickBtnNext = function(self)
  -- function num : 0_17 , upvalues : _ENV
  self.previewRank = self.previewRank + 1
  self:__RefreshPreviewLevel(self.previewRank)
  AudioManager:PlayAudioById(1110)
end

UIHStarUpInfoNode.__OnClickStarUp = function(self)
  -- function num : 0_18
  if self.btnStarUpAction ~= nil then
    (self.btnStarUpAction)()
  end
end

UIHStarUpInfoNode.__PreviewItemClick = function(self, index)
  -- function num : 0_19
  if #self.itemDataList <= 0 then
    return 
  end
  local data = (self.itemDataList)[index]
  if self.preItemAction ~= nil then
    (self.preItemAction)(data)
  end
end

UIHStarUpInfoNode.OnDelete = function(self)
  -- function num : 0_20 , upvalues : base
  for i = 1, #(self.ui).infoTweens do
    local tween = ((self.ui).infoTweens)[i]
    tween:DOKill()
  end
  ;
  (base.OnDelete)(self)
end

return UIHStarUpInfoNode

