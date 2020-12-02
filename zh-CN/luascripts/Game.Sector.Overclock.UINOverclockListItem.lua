-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOverclockListItem = class("UINOverclockListItem", UIBaseNode)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local base = UIBaseNode
local ChipData = require("Game.PlayerData.Item.ChipData")
local CS_MessageCommon = CS.MessageCommon
local eBuffLogic = {randomChip = 11, selectChip = 12}
UINOverclockListItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, false)
  self.overclockId = nil
  self.isUnlock = false
  self.isSelected = false
  self.build_id = nil
  self.Unlock_build_level = nil
  self.clickCallBack = nil
  self.costG = 0
  self.chipId = nil
  self.canSelectChip = false
  self.hasUnlockChip = false
  self.randomSelectChip = false
  self.freeNum = 0
  self.emptyChipSprite = ((self.ui).img_ChipSelect).sprite
  self.chipItem = (UINChipItem.New)()
  ;
  (self.chipItem):Init((self.ui).uINChipItem)
  ;
  (self.chipItem):Hide()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Select, self, self.OnSelectClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_img_ChipSelect, self, self.ShowChipSelectNode)
  ;
  (self.OverclockCtrl):SetChangeChipCallback(BindCallback(self, self.ChangeChipImage))
  ;
  (self.OverclockCtrl):SetNotSelectCallback(BindCallback(self, self.SetNotSelect))
  local itemCfg = (ConfigData.item)[ItemIdOfG]
  if itemCfg == nil then
    error("Can\'t find itemCfg by Id:" .. tostring(GameDefine.ItemIdOfG))
  end
  -- DECOMPILER ERROR at PC87: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Money).sprite = CRH:GetSprite(itemCfg.small_icon)
end

UINOverclockListItem.BindCallBacks = function(self, clickCallBack)
  -- function num : 0_1
  self.clickCallBack = clickCallBack
end

UINOverclockListItem.InitItem = function(self, unlockData)
  -- function num : 0_2
  self.overclockId = unlockData.overclockId
  self.build_id = unlockData.build_id
  self.Unlock_build_level = unlockData.build_level
  self.isUnlock = unlockData.isUnlock
  if self.isUnlock then
    ((self.ui).obj_lock):SetActive(false)
  else
    ;
    ((self.ui).obj_lock):SetActive(true)
    self:__RefreshUnlockInfo()
  end
  self:__RefreshInfo()
  local isSelected = ((self.OverclockCtrl).tempSelectedOverclockOptionList)[self.overclockId] ~= nil
  if isSelected then
    self:OnSelectClick()
  end
  if self.canSelectChip then
    self.chipId = (self.OverclockCtrl):GetChip2OverClockOption(self.overclockId)
    self:__RefreshShowChip()
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINOverclockListItem.OnSelectClick = function(self)
  -- function num : 0_3 , upvalues : CS_MessageCommon, _ENV
  if not self.isUnlock then
    return 
  else
    if self.canSelectChip and not self.hasUnlockChip then
      (CS_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Overclock_DonorHaveUnlockChip))
      return 
    end
  end
  self.isSelected = not self.isSelected
  if self.clickCallBack ~= nil and not (self.clickCallBack)(self.isSelected, self.costG) then
    self.isSelected = not self.isSelected
    return 
  end
  if self.isSelected then
    self:ShowChipSelectNode()
    ;
    ((self.ui).img_btn_Select):SetIndex(0)
    ;
    (self.OverclockCtrl):AddOverClockOption(self.overclockId)
    if self.randomSelectChip then
      local randomChipId = (self.OverclockCtrl):GetRandomChipId()
      if randomChipId == nil then
        self:SetNotSelect(self.overclockId)
        return 
      end
      ;
      (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId, randomChipId)
    end
  else
    do
      ;
      ((self.ui).img_btn_Select):SetIndex(1)
      ;
      (self.OverclockCtrl):RemoveOverClockOption(self.overclockId)
    end
  end
end

UINOverclockListItem.SetNotSelect = function(self, overclockId)
  -- function num : 0_4
  if overclockId ~= self.overclockId or self.isSelected == false then
    return 
  end
  self.isSelected = false
  if self.clickCallBack ~= nil and not (self.clickCallBack)(self.isSelected, self.costG) then
    self.isSelected = not self.isSelected
    return 
  end
  ;
  ((self.ui).img_btn_Select):SetIndex(1)
  ;
  (self.OverclockCtrl):RemoveOverClockOption(self.overclockId)
end

UINOverclockListItem.ShowChipSelectNode = function(self)
  -- function num : 0_5
  if self.canSelectChip and self.isSelected then
    (self.OverclockCtrl):ShowChipSelectNode(self.overclockId)
  end
end

UINOverclockListItem.__RefreshInfo = function(self)
  -- function num : 0_6 , upvalues : _ENV, eBuffLogic
  local overclockLevel = self:__GetOverclockLevel()
  local overclockCfg = (ConfigData.overclock)[self.overclockId]
  if overclockCfg == nil then
    error("not contain overclock id:" .. self.overclockId)
    return 
  end
  local overclockLevelCfg = overclockCfg[overclockLevel]
  if overclockLevelCfg == nil then
    error("not contain overclock id:" .. self.overclockId .. " Level:" .. overclockLevel)
    return 
  end
  local buffCfg = (ConfigData.exploration_buff)[overclockLevelCfg.buffid]
  if buffCfg == nil then
    error("not contain exploration_buff id:" .. overclockLevelCfg.buffid)
    return 
  end
  if buffCfg.logic == eBuffLogic.selectChip then
    self.hasUnlockChip = not (self.OverclockCtrl):IsAllChipsLocked()
    self.canSelectChip = true
  else
    if buffCfg.logic == eBuffLogic.randomChip then
      self.randomSelectChip = true
    end
  end
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(overclockLevelCfg.name)
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = (LanguageUtil.GetLocaleText)(overclockLevelCfg.describe)
  if self.isSelected then
    ((self.ui).img_btn_Select):SetIndex(0)
  else
    ;
    ((self.ui).img_btn_Select):SetIndex(1)
  end
  self.freeNum = (self.OverclockCtrl):GetDailyFreeNum(self.overclockId)
  if self.freeNum > 0 then
    ((self.ui).obj_free):SetActive(true)
    ;
    ((self.ui).obj_money):SetActive(false)
    self.costG = 0
    ;
    ((self.ui).tex_FreeNum):SetIndex(0, tostring(self.freeNum))
  else
    ;
    ((self.ui).obj_free):SetActive(false)
    ;
    ((self.ui).obj_money):SetActive(true)
    self.costG = 0
    ;
    ((self.ui).tex_Money):SetIndex(0, "Null")
    for index,costId in ipairs(overclockLevelCfg.consumeIds) do
      if costId == ItemIdOfG then
        self.costG = (overclockLevelCfg.consumeNums)[index]
        ;
        ((self.ui).tex_Money):SetIndex(0, tostring((overclockLevelCfg.consumeNums)[index]))
      end
    end
  end
  do
    ;
    (((self.ui).img_ChipSelect).gameObject):SetActive(self.canSelectChip)
    self:__RefreshShowChip()
  end
end

UINOverclockListItem.__RefreshShowChip = function(self)
  -- function num : 0_7 , upvalues : ChipData
  if not self.canSelectChip then
    return 
  end
  if self.chipId == nil then
    (self.chipItem):Hide()
    ;
    ((self.ui).img_ChipSelect):SetIndex(0)
  else
    local data = (ChipData.New)(self.chipId)
    ;
    (self.chipItem):InitChipItem(data)
    ;
    ((self.ui).img_ChipSelect):SetIndex(1)
  end
end

UINOverclockListItem.ChangeChipImage = function(self, overclockId, chipId)
  -- function num : 0_8
  if overclockId == self.overclockId then
    self.chipId = chipId
    self:__RefreshShowChip()
  end
end

UINOverclockListItem.__RefreshUnlockInfo = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local buildName = (LanguageUtil.GetLocaleText)(((ConfigData.building)[self.build_id]).name)
  local levelStr = tostring(self.Unlock_build_level)
  ;
  ((self.ui).tex_Condition):SetIndex(0, buildName, levelStr)
end

UINOverclockListItem.__GetOverclockLevel = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local BuildingData = ((PlayerDataCenter.AllBuildingData).oasisBuilt)[self.build_id]
  if BuildingData == nil then
    return 1
  else
    local buildLevel = BuildingData.level
    local buildingLevelCfg = ((ConfigData.buildingLevel)[self.build_id])[buildLevel]
    for index,logic in pairs(buildingLevelCfg.logic) do
      if logic == eLogicType.OverClock and (buildingLevelCfg.para1)[index] == self.overclockId then
        return (buildingLevelCfg.para2)[index]
      end
    end
    return 1
  end
end

UINOverclockListItem.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnDelete)(self)
end

return UINOverclockListItem

