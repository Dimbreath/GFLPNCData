-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpStoreRoom = class("UIEpStoreRoom", UIBaseWindow)
local base = UIBaseWindow
local UIEpStoreRoomItem = require("Game.Exploration.UI.StoreRoom.UIEpStoreRoomItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
local StoreType = {eBuy = 1, eSell = 2}
UIEpStoreRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnStoreSkipClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnStoreBuyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnStoreMapClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Refresh, self, self.OnBtnEpStoreRefresh)
  self.__OnStoreItemClick = BindCallback(self, self.OnStoreItemClick)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).storeList).onInstantiateItem = BindCallback(self, self.__StoreListInitItem)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).storeList).onChangeItem = BindCallback(self, self.__StoreListItemChanged)
  self.storeItemDic = {}
  self.resloader = ((CS.ResLoader).Create)()
  self.chipDetailPanel = (UINChipDetailPanel.New)()
  ;
  (self.chipDetailPanel):Init((self.ui).chipItemDetail)
  ;
  (self.chipDetailPanel):SetBtnToParentHolder(((self.ui).btn_Buy).transform)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_BuyTypeItem, self, self.LoadStoreData)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SellTypeItem, self, self.LoadChipOwnData)
  self.onChipListUpdate = BindCallback(self, self.__onChipListUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
end

UIEpStoreRoom.OnShow = function(self)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.OnShow)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
end

UIEpStoreRoom.OnHide = function(self)
  -- function num : 0_2 , upvalues : base, _ENV
  (base.OnHide)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
end

UIEpStoreRoom.InitStoreRoom = function(self, storeCtrl, storeDataList)
  -- function num : 0_3 , upvalues : _ENV
  self.storeCtrl = storeCtrl
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  self.roomId = epTypeCfg.store_pool
  local needReFill = self.storeDataList == nil or #self.storeDataList ~= #storeDataList
  self.MoneyIconId = (ExplorationManager:GetDynPlayer()):GetMoneyIconId()
  self.discCountLimitTimes = (((self.storeCtrl).roomData).storeRoomData).discCountLimitTimes
  self.selectedIndex = 1
  self.storeDataList = storeDataList
  for k,storeData in ipairs(self.storeDataList) do
    if not storeData.saled then
      self.selectedIndex = k
      break
    end
  end
  if needReFill then
    self:LoadStoreData()
  else
    ((self.ui).storeList):RefreshCells()
  end
  self:RefreshSelectItemDetail()
  do
    if #self.storeDataList > 0 then
      local needScrollIndex = (math.max)(self.selectedIndex - 1, 0)
      ;
      ((self.ui).storeList):SrollToCell(needScrollIndex, 10000)
    end
    self.__mapActiveState = false
    self:SwitchRoomMapBtnState(self.__mapActiveState)
    if self.discCountLimitTimes <= 0 then
      self:SetDiscountUIActive(false)
    else
      ((self.ui).tex_Discount):SetIndex(0, tostring(self.discCountLimitTimes))
    end
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
  end
end

UIEpStoreRoom.LoadStoreData = function(self)
  -- function num : 0_4 , upvalues : StoreType, _ENV
  self:SwitchStoreTypeUI(StoreType.eBuy)
  self.selectedIndex = 1
  for k,storeData in ipairs(self.storeDataList) do
    if not storeData.saled then
      self.selectedIndex = k
      break
    end
  end
  do
    ;
    ((self.ui).storeList):ClearCells()
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).storeList).onInstantiateItem = BindCallback(self, self.__StoreListInitItem)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).storeList).onChangeItem = BindCallback(self, self.__StoreListItemChanged)
    self:__ReFillList(self.storeDataList)
    self:RefreshSelectItemDetail()
  end
end

UIEpStoreRoom.GetExitButton = function(self)
  -- function num : 0_5
  return (self.ui).btn_Skip
end

UIEpStoreRoom.LoadChipOwnData = function(self)
  -- function num : 0_6 , upvalues : StoreType, _ENV
  self:SwitchStoreTypeUI(StoreType.eSell)
  self.chipList = (ExplorationManager:GetDynPlayer()):GetChipList()
  self.selectedIndex = 1
  ;
  ((self.ui).storeList):ClearCells()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).storeList).onChangeItem = BindCallback(self, self.__ChipListItemChanged)
  self:__ReFillList(self.chipList)
  self:RefreshSelectItemDetailSoldOut()
end

UIEpStoreRoom.__onChipListUpdate = function(self, chipList)
  -- function num : 0_7 , upvalues : StoreType
  self.chipList = chipList
  if self.storeType == StoreType.eSell then
    self.selectedIndex = 1
    self:__ReFillList(self.chipList)
    self:RefreshSelectItemDetailSoldOut()
  end
end

UIEpStoreRoom.SwitchStoreTypeUI = function(self, storeType)
  -- function num : 0_8 , upvalues : StoreType, _ENV
  self.storeType = storeType
  if self.storeType == StoreType.eBuy then
    ((self.ui).buyTypeImg):SetIndex(0)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).buyTypeText).color = Color.black
    ;
    ((self.ui).sellTypeImg):SetIndex(1)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).sellTypeText).color = Color.white
  else
    if self.storeType == StoreType.eSell then
      ((self.ui).sellTypeImg):SetIndex(0)
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).sellTypeText).color = Color.black
      ;
      ((self.ui).buyTypeImg):SetIndex(1)
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).buyTypeText).color = Color.white
    end
  end
  ;
  (((self.ui).btn_Refresh).gameObject):SetActive(self.storeType == StoreType.eBuy)
  local showDiscount = self.storeType == StoreType.eBuy and self.discCountLimitTimes > 0
  self:SetDiscountUIActive(showDiscount)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIEpStoreRoom.SetDiscountUIActive = function(self, active)
  -- function num : 0_9
  (((((self.ui).tex_Discount).transform).parent).gameObject):SetActive(active)
end

UIEpStoreRoom.__ReFillList = function(self, dataList)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).storeList).totalCount = #dataList
  ;
  ((self.ui).storeList):RefillCells()
end

UIEpStoreRoom.__StoreListInitItem = function(self, go)
  -- function num : 0_11 , upvalues : UIEpStoreRoomItem
  local storeItem = (UIEpStoreRoomItem.New)()
  storeItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.storeItemDic)[go] = storeItem
end

UIEpStoreRoom.__StoreListItemChanged = function(self, go, index)
  -- function num : 0_12 , upvalues : _ENV, ChipEnum
  local storeItem = (self.storeItemDic)[go]
  if storeItem == nil then
    error("Can\'t find Item by gameObject")
    return 
  end
  index = index + 1
  local storeData = (self.storeDataList)[index]
  if storeData == nil then
    error("Can\'t find storeData by index, index = " .. tonumber(index))
  end
  storeItem:InitStoreRoomItem(self.roomId, storeData, self.MoneyIconId, self.__OnStoreItemClick, nil, (self.storeCtrl).dynPlayer)
  storeItem:SetStoreItemSelect(index == self.selectedIndex)
  local isHadChip = (((self.storeCtrl).dynPlayer).chipDic)[(storeData.chipData).dataId] ~= nil
  if not isHadChip or not (ChipEnum.eChipShowState).UpState then
    local chipShowState = (ChipEnum.eChipShowState).NewState
  end
  storeItem:SetNewTagActive(true, chipShowState)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UIEpStoreRoom.__ChipListItemChanged = function(self, go, index)
  -- function num : 0_13 , upvalues : _ENV
  local storeItem = (self.storeItemDic)[go]
  if storeItem == nil then
    error("Can\'t find Item by gameObject")
    return 
  end
  index = index + 1
  local chipData = (self.chipList)[index]
  chipData.idx = index
  if chipData == nil then
    error("Can\'t find chipData by index, index = " .. tonumber(index))
  end
  storeItem:InitStoreRoomItem(self.roomId, chipData, self.MoneyIconId, self.__OnStoreItemClick, true, (self.storeCtrl).dynPlayer)
  storeItem:SetStoreItemSelect(index == self.selectedIndex)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIEpStoreRoom.__GetStoreItemByIndex = function(self, index)
  -- function num : 0_14 , upvalues : _ENV
  local go = ((self.ui).storeList):GetCellByIndex(index - 1)
  do
    if not IsNull(go) then
      local storeItem = (self.storeItemDic)[go]
      return storeItem
    end
    return nil
  end
end

UIEpStoreRoom.OnStoreItemClick = function(self, storeItem)
  -- function num : 0_15 , upvalues : StoreType
  if storeItem == nil then
    return 
  end
  if self.selectedIndex == storeItem.index then
    return 
  end
  local lastStoreItem = self:__GetStoreItemByIndex(self.selectedIndex)
  if lastStoreItem ~= nil then
    lastStoreItem:SetStoreItemSelect(false)
  end
  self.selectedIndex = storeItem.index
  storeItem:SetStoreItemSelect(true)
  ;
  (storeItem.chipItem):RefreshLevelTween()
  if self.storeType == StoreType.eBuy then
    self:RefreshSelectItemDetail(storeItem.price)
  else
    if self.storeType == StoreType.eSell then
      self:RefreshSelectItemDetailSoldOut()
    end
  end
end

UIEpStoreRoom.RefreshSelectItemDetail = function(self, price)
  -- function num : 0_16 , upvalues : ChipEnum, _ENV
  local storeData = (self.storeDataList)[self.selectedIndex]
  if storeData == nil then
    (((self.ui).btn_Buy).gameObject):SetActive(false)
    ;
    (self.chipDetailPanel):Hide()
    return 
  end
  ;
  (((self.ui).btn_Buy).gameObject):SetActive(not storeData.saled)
  ;
  (self.chipDetailPanel):Show()
  ;
  (self.chipDetailPanel):InitEpChipDetail(self.selectedIndex, storeData.chipData, (self.storeCtrl).dynPlayer, self.resloader)
  ;
  (self.chipDetailPanel):ShowHeroHeadOrTacticActive(true)
  ;
  (self.chipDetailPanel):ShowEpChipDetailEff(5)
  local isHadChip = (((self.storeCtrl).dynPlayer).chipDic)[(storeData.chipData).dataId] ~= nil
  if not isHadChip or not (ChipEnum.eChipShowState).UpState then
    local chipShowState = (ChipEnum.eChipShowState).NewState
  end
  ;
  (self.chipDetailPanel):SetObjNewTagActive(true, chipShowState)
  self.currMoney = (ExplorationManager:GetDynPlayer()):GetMoneyCount()
  self.itemPrice = 0
  if price == nil then
    self.itemPrice = (math.ceil)((storeData.chipData):GetChipBuyPrice(ExplorationManager:GetEpModuleId()) * storeData.discount / 100)
  else
    self.itemPrice = price
  end
  ;
  ((self.ui).tex_buy):SetIndex(1)
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).tex_buy).text).color = Color.black
  ;
  ((self.ui).img_buy):SetIndex(0)
  local couldLoanMoney = ((ExplorationManager.epCtrl).campFetterCtrl):GetCouldLeonMoney()
  self.isLack = self.currMoney + couldLoanMoney < self.itemPrice and self.itemPrice > 0
  self:__SetLackState(self.isLack)
  ;
  ((self.ui).ani_Buy):SetActive(not self.isLack)
  local refreshCostNum = 0
  local isLack = false
  if (((self.storeCtrl).roomData).storeRoomData).extraFetterFreeRefreshTimes <= 0 then
    local refreshTimes = (((self.storeCtrl).roomData).storeRoomData).refreshTimes
    local shopRoomCfg = (ConfigData.exploration_shop)[self.roomId]
    if shopRoomCfg == nil then
      error("exploration shop is null,roomId:" .. tostring(self.roomId))
    end
    local currMoney = ((self.storeCtrl).dynPlayer):GetItemCount((self.storeCtrl).currencyId)
    refreshCostNum = shopRoomCfg.init_fresh_price + shopRoomCfg.increase_fresh_price * refreshTimes
    isLack = currMoney < refreshCostNum and refreshCostNum > 0
  end
  ;
  ((self.ui).obj_RefreshLack):SetActive(isLack)
  -- DECOMPILER ERROR at PC180: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_RefreshPay).text = tostring(refreshCostNum)
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

UIEpStoreRoom.RefreshSelectItemDetailSoldOut = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local chipData = (self.chipList)[self.selectedIndex]
  if chipData == nil then
    (((self.ui).btn_Buy).gameObject):SetActive(false)
    ;
    (self.chipDetailPanel):Hide()
    return 
  end
  ;
  (((self.ui).btn_Buy).gameObject):SetActive(true)
  ;
  (self.chipDetailPanel):Show()
  ;
  (self.chipDetailPanel):InitEpChipDetail(self.selectedIndex, chipData, (self.storeCtrl).dynPlayer, self.resloader, nil, true, eChipDetailPowerType.Subtract, true)
  ;
  (self.chipDetailPanel):ShowHeroHeadOrTacticActive(true)
  ;
  (self.chipDetailPanel):ShowEpChipDetailEff(5)
  ;
  (self.chipDetailPanel):SetObjNewTagActive(false)
  ;
  ((self.ui).tex_buy):SetIndex(2)
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).tex_buy).text).color = Color.white
  ;
  ((self.ui).img_buy):SetIndex(1)
  self:__SetLackState(false)
  ;
  ((self.ui).ani_Buy):SetActive(false)
end

UIEpStoreRoom.__SetLackState = function(self, isLack)
  -- function num : 0_18
  ((self.ui).obj_Lack):SetActive(isLack)
  if isLack then
    ((self.ui).tex_buy):SetIndex(0)
  end
end

UIEpStoreRoom.OnStoreBuyClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV, StoreType
  local storeItem = self:__GetStoreItemByIndex(self.selectedIndex)
  if storeItem == nil then
    return 
  end
  local chipData = storeItem.chipData
  local chipItem = storeItem:GetStoreChipItem()
  local uiPos = (self.transform):InverseTransformPoint((chipItem.transform).position)
  local localScale = (chipItem.transform).localScale
  local chipReturnMoney = (ExplorationManager:GetDynPlayer()):GetChipReturnMoney(chipData.dataId, chipData:GetCount())
  if self.storeType == StoreType.eBuy then
    (self.storeCtrl):SendStorePurchase(storeItem.index, storeItem.price, function()
    -- function num : 0_19_0 , upvalues : _ENV, chipData, uiPos, localScale, chipReturnMoney
    local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if dungeonStateWindow ~= nil then
      dungeonStateWindow:ShowGetChipAni(chipData, uiPos, localScale, chipReturnMoney)
    end
    ;
    (ExplorationManager:GetEpDataCenter()):AddNewChip(chipData.dataId)
  end
)
  else
    if self.storeType == StoreType.eSell then
      ((CS.MessageCommon).ShowMessageBox)((string.format)(ConfigData:GetTipContent(288), chipData:GetName(), tostring(storeItem.salePrice)), function()
    -- function num : 0_19_1 , upvalues : self, chipData, _ENV
    (self.storeCtrl):SendStoreSell(chipData, function()
      -- function num : 0_19_1_0 , upvalues : self, _ENV
      self.chipList = (ExplorationManager:GetDynPlayer()):GetChipList()
      self:__ReFillList(self.chipList)
    end
)
  end
, nil)
    end
  end
end

UIEpStoreRoom.OnBtnEpStoreRefresh = function(self)
  -- function num : 0_20
  if ((self.ui).obj_RefreshLack).activeSelf then
    return 
  end
  ;
  (self.storeCtrl):ReqEpStoreRefresh()
end

UIEpStoreRoom.OnStoreSkipClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(TipContent.exploration_Store_Exit), function()
    -- function num : 0_21_0 , upvalues : self
    (self.storeCtrl):SendStoreQuit()
  end
, nil)
end

UIEpStoreRoom.OnStoreMapClicked = function(self)
  -- function num : 0_22
  self.__mapActiveState = not self.__mapActiveState
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

UIEpStoreRoom.FromMapBackToUI = function(self)
  -- function num : 0_23
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

UIEpStoreRoom.SwitchRoomMapBtnState = function(self, openMap)
  -- function num : 0_24 , upvalues : _ENV
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

UIEpStoreRoom.OnChipDetailActiveChange = function(self, active)
  -- function num : 0_25
  if active then
    self:Hide()
  else
    self:Show()
  end
end

UIEpStoreRoom.OnDelete = function(self)
  -- function num : 0_26 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  if ExplorationManager.epCtrl ~= nil then
    (ExplorationManager.epCtrl).inTheTempRoom = nil
  end
  ;
  (self.chipDetailPanel):OnDelete()
  ;
  (base.OnDelete)(self)
end

return UIEpStoreRoom

