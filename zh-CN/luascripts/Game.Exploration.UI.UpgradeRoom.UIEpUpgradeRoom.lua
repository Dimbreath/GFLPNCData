-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpUpgradeRoom = class("UIEpUpgradeRoom", UIBaseWindow)
local base = UIBaseWindow
local UIEpUpgradeRoomItem = require("Game.Exploration.UI.UpgradeRoom.UIEpUpgradeRoomItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
UIEpUpgradeRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnRoomSkipClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnMapClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Upgrade, self, self.OnUpgradeClicked)
  self.__OnChipItemClick = BindCallback(self, self.OnChipItemClick)
  self.chipItemDic = {}
  self.resloader = ((CS.ResLoader).Create)()
  self.chipDetailPanel = (UINChipDetailPanel.New)()
  ;
  (self.chipDetailPanel):Init((self.ui).chipItemDetail)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  self.onChipListUpdate = BindCallback(self, self.__onChipListUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  self.onMoneyUpdate = BindCallback(self, self.__onMoneyUpdate)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.onMoneyUpdate)
end

UIEpUpgradeRoom.InitUpgradeRoom = function(self, roomCtrl, upgradeCfg, refreshTime)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).lack):SetActive(false)
  self.roomCtrl = roomCtrl
  self.refreshTime = refreshTime
  self.chipDataList = ((self.roomCtrl).dynPlayer):GetChipList()
  self.cfg = upgradeCfg
  do
    if (self.cfg).currency ~= nil then
      local itemCfg = (ConfigData.item)[(self.cfg).currency]
      if itemCfg ~= nil then
        self.moneyIconId = itemCfg.icon
      end
    end
    self.maxRefreshTimes = 0
    if (self.cfg).refresh_times ~= nil then
      self.maxRefreshTimes = ((self.cfg).refresh_times)[#(self.cfg).refresh_times]
    end
    if self.maxRefreshTimes >= 0 then
      (((self.ui).refreshTimeText).gameObject):SetActive(true)
      ;
      ((self.ui).refreshTimeText):SetIndex(0, tostring(self.maxRefreshTimes - self.refreshTime))
    else
      ;
      (((self.ui).refreshTimeText).gameObject):SetActive(false)
    end
    self.roomId = upgradeCfg.id
    self:LoadChipData()
    local selectItem = self:__GetChipItemByIndex(self.selectedIndex)
    self:RefreshSelectItemDetail(selectItem)
    local needScrollIndex = (math.max)(self.selectedIndex - 1, 0)
    ;
    ((self.ui).chipList):SrollToCell(needScrollIndex, 10000)
    self.__mapActiveState = false
    self:SwitchRoomMapBtnState(self.__mapActiveState)
    self:CheckRefreshTimeAndExit()
  end
end

UIEpUpgradeRoom.LoadChipData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.selectedIndex == nil then
    self.selectedIndex = 1
  end
  ;
  ((self.ui).chipList):ClearCells()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onInstantiateItem = BindCallback(self, self.__ChipListInitItem)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onChangeItem = BindCallback(self, self.__ChipListUpdateItem)
  self:__ReFillList(self.chipDataList)
end

UIEpUpgradeRoom.__ChipListInitItem = function(self, go)
  -- function num : 0_3 , upvalues : UIEpUpgradeRoomItem
  local chipItem = (UIEpUpgradeRoomItem.New)()
  chipItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.chipItemDic)[go] = chipItem
end

UIEpUpgradeRoom.__ChipListUpdateItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local chipItem = (self.chipItemDic)[go]
  if chipItem == nil then
    error("Can\'t find Item by gameObject")
    return 
  end
  index = index + 1
  local chipData = (self.chipDataList)[index]
  chipData.idx = index
  if chipData == nil then
    error("Can\'t find chipData by index, index = " .. tonumber(index))
  end
  local upgradePrice = ConfigData:CalculateEpChipUpgradePrice(self.roomId, self.refreshTime)
  chipItem:InitUpgradeRoomItem(self.roomId, self.moneyIconId, upgradePrice, chipData, self.__OnChipItemClick)
  chipItem:SetChipItemSelect(index == self.selectedIndex)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIEpUpgradeRoom.__GetChipItemByIndex = function(self, index)
  -- function num : 0_5 , upvalues : _ENV
  local go = ((self.ui).chipList):GetCellByIndex(index - 1)
  do
    if not IsNull(go) then
      local chipItem = (self.chipItemDic)[go]
      return chipItem
    end
    return nil
  end
end

UIEpUpgradeRoom.__ReFillList = function(self, dataList)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).chipList).totalCount = #dataList
  ;
  ((self.ui).chipList):RefillCells()
end

UIEpUpgradeRoom.RefreshSelectItemDetail = function(self, selectItem)
  -- function num : 0_7 , upvalues : _ENV
  local chipData = (self.chipDataList)[self.selectedIndex]
  if chipData == nil then
    (((self.ui).btn_Upgrade).gameObject):SetActive(false)
    ;
    (self.chipDetailPanel):Hide()
    return 
  end
  ;
  (((self.ui).btn_Upgrade).gameObject):SetActive(true)
  ;
  (self.chipDetailPanel):Show()
  ;
  (self.chipDetailPanel):OnSelectChipChanged(true)
  local upgradedChipData = chipData
  local levelMax = chipData:GetChipMaxLevel() <= chipData:GetCount()
  ;
  ((self.ui).levelMax):SetActive(levelMax)
  ;
  ((self.ui).lack):SetActive(false)
  ;
  (self.chipDetailPanel):InitChipDetailPanel(self.selectedIndex, chipData, (self.roomCtrl).dynPlayer, self.resloader, nil, levelMax, eChipDetailPowerType.Add, true)
  ;
  (self.chipDetailPanel):ShowHeroHeadOrTacticActive(true)
  if not levelMax and selectItem ~= nil and selectItem.upgradePrice ~= nil then
    if self.currency == nil then
      self.currency = (ExplorationManager:GetDynPlayer()):GetItemCount((self.cfg).currency)
    end
    ;
    ((self.ui).lack):SetActive(self.currency < selectItem.upgradePrice)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UIEpUpgradeRoom.__onChipListUpdate = function(self, chipList)
  -- function num : 0_8
  self.chipDataList = chipList
  self:__ReFillList(self.chipDataList)
  local selectItem = self:__GetChipItemByIndex(self.selectedIndex)
  self:RefreshSelectItemDetail(selectItem)
end

UIEpUpgradeRoom.__onMoneyUpdate = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local currencyNum = (ExplorationManager:GetDynPlayer()):GetItemCount((self.cfg).currency)
  if self.currency ~= currencyNum and self.selectedIndex ~= nil then
    self.currency = currencyNum
    local selectItem = self:__GetChipItemByIndex(self.selectedIndex)
    self:RefreshSelectItemDetail(selectItem)
  end
end

UIEpUpgradeRoom.OnChipItemClick = function(self, chipItem)
  -- function num : 0_10
  if chipItem == nil then
    return 
  end
  if self.selectedIndex == chipItem.index then
    return 
  end
  local lastChipItem = self:__GetChipItemByIndex(self.selectedIndex)
  if lastChipItem ~= nil then
    lastChipItem:SetChipItemSelect(false)
  end
  self.selectedIndex = chipItem.index
  chipItem:SetChipItemSelect(true)
  self:RefreshSelectItemDetail(chipItem)
end

UIEpUpgradeRoom.OnUpgradeClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local chipItem = self:__GetChipItemByIndex(self.selectedIndex)
  if chipItem == nil then
    return 
  end
  local chipData = (self.chipDataList)[self.selectedIndex]
  if chipData == nil then
    return 
  end
  if chipData:GetChipMaxLevel() <= chipData:GetCount() then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Upgrade_UpgradeItemLevelMax))
    return 
  end
  if self.maxRefreshTimes <= self.refreshTime and self.maxRefreshTimes ~= -1 then
    ((CS.MessageCommon).ShowMessageTips)("升级次数" .. ConfigData:GetTipContent(TipContent.exploration_Upgrade_UpgradeItemInsufficient))
    return 
  end
  ;
  (self.roomCtrl):SendChipUpgrade(chipItem, (self.cfg).currency, BindCallback(self, self.PlaySuccessEfc, chipItem))
end

UIEpUpgradeRoom.PlaySuccessEfc = function(self, chipItem)
  -- function num : 0_12 , upvalues : _ENV
  local chipData = chipItem.chipData
  local uiPos = (self.transform):InverseTransformPoint((chipItem.transform).position)
  local localScale = (chipItem.transform).localScale
  local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateWindow ~= nil then
    dungeonStateWindow:ShowGetChipAni(chipData, uiPos, localScale)
  end
end

UIEpUpgradeRoom.OnRoomSkipClicked = function(self)
  -- function num : 0_13
  (self.roomCtrl):SendSpecifyExit()
end

UIEpUpgradeRoom.OnMapClicked = function(self)
  -- function num : 0_14
  self.__mapActiveState = not self.__mapActiveState
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

UIEpUpgradeRoom.FromMapBackToUI = function(self)
  -- function num : 0_15
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

UIEpUpgradeRoom.SwitchRoomMapBtnState = function(self, openMap)
  -- function num : 0_16 , upvalues : _ENV
  if openMap then
    ((self.ui).tex_MapBtnName):SetIndex(1)
  else
    ;
    ((self.ui).tex_MapBtnName):SetIndex(0)
  end
  ;
  ((self.ui).frameNode):SetActive(not openMap)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, openMap)
end

UIEpUpgradeRoom.OnChipDetailActiveChange = function(self, active)
  -- function num : 0_17
  if active then
    self:Hide()
  else
    self:Show()
  end
end

UIEpUpgradeRoom.CheckRefreshTimeEnough = function(self)
  -- function num : 0_18
  if self.maxRefreshTimes > -1 and self.maxRefreshTimes - self.refreshTime <= 0 then
    return false
  end
  return true
end

UIEpUpgradeRoom.CheckRefreshTimeAndExit = function(self)
  -- function num : 0_19
  if not self:CheckRefreshTimeEnough() then
    self:OnRoomSkipClicked()
  end
end

UIEpUpgradeRoom.OnDelete = function(self)
  -- function num : 0_20 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.onMoneyUpdate)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  ;
  (base.OnDelete)(self)
end

return UIEpUpgradeRoom

