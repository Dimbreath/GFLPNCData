local UINHeroSkillUpgradeInfo = class("UINHeroSkillUpgradeInfo", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local UINHeroSkillUpgradeCostItem = require("Game.Hero.NewUI.UpgradeSkill.UINHeroSkillUpgradeCostItem")
local UINSkillAllLevelDes = require("Game.Hero.NewUI.UpgradeSkill.UINSkillAllLevelDes")
UINHeroSkillUpgradeInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroSkillUpgradeCostItem, UINBaseSkillItem, UINSkillAllLevelDes
  self.couldConfirm = false
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnClickCancel)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CheckAll, self, self.ShowAllLevelInfo)
  self.CostItemPool = (UIItemPool.New)(UINHeroSkillUpgradeCostItem, (self.ui).obj_extrItem)
  ;
  ((self.ui).obj_extrItem):SetActive(false)
  self.nowSkillItem = (UINBaseSkillItem.New)()
  ;
  (self.nowSkillItem):Init((self.ui).now_uINSkillItem)
  self.nextSkillItem = (UINBaseSkillItem.New)()
  ;
  (self.nextSkillItem):Init((self.ui).next_uINSkillItem)
  self.AllLevelDes = (UINSkillAllLevelDes.New)()
  ;
  (self.AllLevelDes):Init((self.ui).obj_viewAllSkillNode)
  self.__HeroRefresh = BindCallback(self, self.HeroRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__HeroRefresh)
  self.__ItemRefresh = BindCallback(self, self.ItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
  self.StarList = {}
  ;
  (table.insert)(self.StarList, (self.ui).obj_star)
end

UINHeroSkillUpgradeInfo.InitInfoNode = function(self, skillData, resloader, closeInfoNodeCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.skillData = skillData
  self.resloader = resloader
  self.closeInfoNodeCallback = closeInfoNodeCallback
  ;
  (UIUtil.RefreshTopResId)({1003})
  self:Refresh(false)
end

UINHeroSkillUpgradeInfo.HeroRefresh = function(self)
  -- function num : 0_2
end

UINHeroSkillUpgradeInfo.ItemRefresh = function(self)
  -- function num : 0_3
  self:Refresh()
end

UINHeroSkillUpgradeInfo.Refresh = function(self, isUpgrade)
  -- function num : 0_4 , upvalues : _ENV
  if self.skillData == nil then
    return 
  end
  if (self.skillData):IsFullLevel() then
    (self.closeInfoNodeCallback)()
    return 
  end
  self.couldConfirm = true
  local bool, rare, star, isHaveEnoughItem, notLimit = (self.skillData):CanUpgrade()
  local isSkillUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
  ;
  ((self.ui).obj_lockedNode):SetActive(false)
  ;
  ((self.ui).obj_limitNode):SetActive(false)
  ;
  (((self.ui).btn_Confirm).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R8 in 'UnsetPending'

  if bool and isSkillUpUnlock then
    ((self.ui).img_btn_Confirm).color = (self.ui).color_Orange
  else
    self.couldConfirm = false
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).img_btn_Confirm).color = (self.ui).color_Gray
    if not isSkillUpUnlock then
      ((self.ui).obj_limitNode):SetActive(true)
      ;
      (((self.ui).btn_Confirm).gameObject):SetActive(false)
      ;
      ((self.ui).tex_LimitTips):SetIndex(1, FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp))
    else
      if not star then
        ((self.ui).obj_lockedNode):SetActive(true)
        ;
        (((self.ui).btn_Confirm).gameObject):SetActive(false)
        local starUnm = ((self.skillData):GetNextLevelRankCfg()).star
        self:RefreshUnlockStar(starUnm)
      else
        do
          if not notLimit then
            ((self.ui).obj_limitNode):SetActive(true)
            ;
            (((self.ui).btn_Confirm).gameObject):SetActive(false)
            local limitLevel = (self.skillData):GetLimitLevel()
            ;
            ((self.ui).tex_LimitTips):SetIndex(0, tostring(limitLevel))
          end
          do
            self:RefreshLevelInfo(isUpgrade)
            self:RefreshAllMaterial()
          end
        end
      end
    end
  end
end

UINHeroSkillUpgradeInfo.RefreshAllMaterial = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local skillLevelCfg = ((self.skillData):GetSkillLevelCfg())
  local currencyId, currencyNum = nil, nil
  ;
  (self.CostItemPool):HideAll()
  for index,itemId in ipairs(skillLevelCfg.itemIdList) do
    if index == 1 then
      currencyId = (skillLevelCfg.itemIdList)[1]
      currencyNum = (skillLevelCfg.countList)[1] or 0
    else
      local num = (skillLevelCfg.countList)[index]
      local item = (self.CostItemPool):GetOne(true)
      item:InitCostItem(itemId, num)
    end
  end
  local itemCfg = (ConfigData.item)[currencyId]
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

  if itemCfg ~= nil then
    ((self.ui).img_Item).sprite = CRH:GetSprite(itemCfg.small_icon)
  else
    error("can\'t read itemCfg with id:" .. tostring(currencyId))
  end
  local totalCurrencyNum = PlayerDataCenter:GetItemCount(currencyId)
  if totalCurrencyNum < currencyNum then
    ((self.ui).tex_Cost):SetIndex(1, tostring(currencyNum))
  else
    ;
    ((self.ui).tex_Cost):SetIndex(0, tostring(currencyNum))
  end
end

UINHeroSkillUpgradeInfo.RefreshLevelInfo = function(self, isUpgrade)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if (self.skillData).level <= 9 then
    ((self.ui).tex_curLv).text = "0" .. tostring((self.skillData).level)
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_curLv).text = tostring((self.skillData).level)
  end
  local nextLevel = (self.skillData).level + 1
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  if nextLevel <= 9 then
    ((self.ui).tex_NextLv).text = "0" .. tostring(nextLevel)
  else
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_NextLv).text = tostring(nextLevel)
  end
  if (self.skillData):GetMaxLevel() < nextLevel then
    error("skill is full level id:" .. tostring((self.skillData).dataId) .. " level:" .. tostring((self.skillData).level))
    return 
  end
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).now_tex_Lv).text = "LV" .. tostring((self.skillData).level)
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).now_tex_Name).text = (self.skillData):GetName()
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).now_tex_Descr).text = (self.skillData):Get2NewLevelDes((self.skillData).level, nextLevel)
  ;
  (self.nowSkillItem):InitBaseSkillItem(self.skillData, self.resloader)
  if isUpgrade then
    ((self.ui).tex_curLv):StartScrambleTypeWriter()
    ;
    ((self.ui).now_tex_Lv):StartScrambleTypeWriter()
  end
end

UINHeroSkillUpgradeInfo.RefreshUnlockStar = function(self, starNum)
  -- function num : 0_7 , upvalues : _ENV
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
      local imgItemInfo = (((self.ui).obj_star):Instantiate()):GetComponent(typeof(CS.UiImageItemInfo))
      ;
      (table.insert)(self.StarList, imgItemInfo)
      ;
      (imgItemInfo.gameObject):SetActive(true)
    end
  end
  if isHalf then
    ((self.StarList)[count]):SetIndex(1)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINHeroSkillUpgradeInfo.ShowAllLevelInfo = function(self)
  -- function num : 0_8
  (self.AllLevelDes):Show()
  ;
  (self.AllLevelDes):InitAllDes(self.skillData)
end

UINHeroSkillUpgradeInfo.OnClickConfirm = function(self)
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon
  local isSkillUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
  do
    if not isSkillUpUnlock then
      local unlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(unlockDes)
      return 
    end
    if not self.couldConfirm then
      return 
    end
    local bool, rare, star, isHaveEnoughItem = (self.skillData):CanUpgrade()
    if bool then
      if self.__refreshFunc == nil then
        self.__refreshFunc = BindCallback(self, self.Refresh, true)
      end
      ;
      (self.networkCtrl):SendHeroSkillUp(((self.skillData).heroData).dataId, (self.skillData).dataId, self.__refreshFunc)
      self.couldConfirm = false
    else
      if not isHaveEnoughItem then
        if (self.skillData):IsFullLevel() then
          return 
        end
        ;
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.hero_Skill_materialInsufficient))
      end
    end
  end
end

UINHeroSkillUpgradeInfo.SetBtnCancelAction = function(self, Action)
  -- function num : 0_10
  self.onCancelClickAction = Action
end

UINHeroSkillUpgradeInfo.OnClickCancel = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if self.onCancelClickAction ~= nil then
    (self.onCancelClickAction)()
  end
  ;
  (UIUtil.RefreshTopResId)(nil)
end

UINHeroSkillUpgradeInfo.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__HeroRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemRefresh)
  ;
  (base.OnDelete)(self)
end

return UINHeroSkillUpgradeInfo

