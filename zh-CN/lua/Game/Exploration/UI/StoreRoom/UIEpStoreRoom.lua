local UIEpStoreRoom = class("UIEpStoreRoom", UIBaseWindow)
local base = UIBaseWindow
local UINEpStoreRoomSellList = require("Game.Exploration.UI.StoreRoom.UINEpStoreRoomSellList")
local UINEpStoreRoomBuyList = require("Game.Exploration.UI.StoreRoom.UINEpStoreRoomBuyList")
local UIEpStoreRoomItem = require("Game.Exploration.UI.StoreRoom.UIEpStoreRoomItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
local UINEpBuffDetail = require("Game.Exploration.UI.StoreRoom.UINEpBuffDetail")
local cs_MessageCommon = CS.MessageCommon
local StoreType = {eBuy = 1, eSell = 2}
UIEpStoreRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel, UINEpBuffDetail, UINEpStoreRoomBuyList, UINEpStoreRoomSellList
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnStoreSkipClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnStoreBuyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnStoreMapClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Refresh, self, self.OnBtnEpStoreRefresh)
  self._onStoreBuyClicked = BindCallback(self, self.OnStoreBuyClicked)
  self.resloader = ((CS.ResLoader).Create)()
  self.chipDetailPanel = (UINChipDetailPanel.New)()
  ;
  (self.chipDetailPanel):Init((self.ui).chipItemDetail)
  self.epBuffDetail = (UINEpBuffDetail.New)()
  ;
  (self.epBuffDetail):Init((self.ui).uINEpBuffDetail)
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
  self:__ShowDetailSellOutUI(false)
  self.buyListNode = (UINEpStoreRoomBuyList.New)(self)
  ;
  (self.buyListNode):Init((self.ui).buyList)
  self.sellListNode = (UINEpStoreRoomSellList.New)(self)
  ;
  (self.sellListNode):Init((self.ui).sellList)
end

UIEpStoreRoom.OnShow = function(self)
  -- function num : 0_1 , upvalues : base
  (base.OnShow)(self)
end

UIEpStoreRoom.OnHide = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnHide)(self)
end

UIEpStoreRoom.InitStoreRoom = function(self, storeCtrl, storeDataList)
  -- function num : 0_3 , upvalues : _ENV
  self.storeCtrl = storeCtrl
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  self.roomId = epTypeCfg.store_pool
  local needReFill = self.storeDataList == nil or #self.storeDataList ~= #storeDataList
  self.MoneyIconId = (ExplorationManager:GetDynPlayer()):GetMoneyIconId()
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Money).sprite = CRH:GetSprite(self.MoneyIconId)
  self.discCountLimitTimes = (((self.storeCtrl).roomData).storeRoomData).discCountLimitTimes
  self.storeDataList = storeDataList
  self:LoadStoreData()
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
  if self.discCountLimitTimes <= 0 then
    self:SetDiscountUIActive(false)
  else
    ((self.ui).tex_Discount):SetIndex(0, tostring(self.discCountLimitTimes))
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIEpStoreRoom.LoadStoreData = function(self)
  -- function num : 0_4 , upvalues : StoreType
  self:SwitchStoreTypeUI(StoreType.eBuy)
  ;
  (self.buyListNode):InitEpStoreRoomBuyList(self.storeDataList)
end

UIEpStoreRoom.GetExitButton = function(self)
  -- function num : 0_5
  return (self.ui).btn_Skip
end

UIEpStoreRoom.LoadChipOwnData = function(self)
  -- function num : 0_6 , upvalues : StoreType, _ENV
  self:SwitchStoreTypeUI(StoreType.eSell)
  self.chipList = (ExplorationManager:GetDynPlayer()):GetChipList()
  ;
  (self.sellListNode):InitEpStoreRoomSell(self.chipList)
end

UIEpStoreRoom.__onChipListUpdate = function(self, chipList)
  -- function num : 0_7 , upvalues : StoreType
  self.chipList = chipList
  if self.storeType == StoreType.eSell then
    (self.sellListNode):InitEpStoreRoomSell(chipList)
  end
end

UIEpStoreRoom.SwitchStoreTypeUI = function(self, storeType)
  -- function num : 0_8 , upvalues : StoreType, _ENV
  self.storeType = storeType
  ;
  (self.epBuffDetail):Hide()
  if self.storeType == StoreType.eBuy then
    ((self.ui).buyTypeImg):SetIndex(0)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).buyTypeText).color = Color.black
    ;
    ((self.ui).sellTypeImg):SetIndex(1)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).sellTypeText).color = Color.white
    ;
    (self.buyListNode):Show()
    ;
    (self.sellListNode):Hide()
  else
    if self.storeType == StoreType.eSell then
      ((self.ui).sellTypeImg):SetIndex(0)
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).sellTypeText).color = Color.black
      ;
      ((self.ui).buyTypeImg):SetIndex(1)
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).buyTypeText).color = Color.white
      ;
      (self.buyListNode):Hide()
      ;
      (self.sellListNode):Show()
    end
  end
  ;
  (((self.ui).btn_Refresh).gameObject):SetActive(self.storeType == StoreType.eBuy)
  local showDiscount = self.storeType == StoreType.eBuy and self.discCountLimitTimes > 0
  self:SetDiscountUIActive(showDiscount)
  self:__ShowDetailSellOutUI(false)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIEpStoreRoom.SetDiscountUIActive = function(self, active)
  -- function num : 0_9
  (((((self.ui).tex_Discount).transform).parent).gameObject):SetActive(active)
end

UIEpStoreRoom.OnSelectStoreBuffItem = function(self, buffItem)
  -- function num : 0_10
  buffItem:SetStoreBuffItemSelect(true)
  self:RefreshBuySelectItemDetail((buffItem.epStoreItemData).idx, buffItem.price)
end

UIEpStoreRoom.OnSelectStoreChipItem = function(self, storeItem)
  -- function num : 0_11 , upvalues : StoreType
  storeItem:SetStoreItemSelect(true)
  ;
  (storeItem.chipItem):RefreshLevelTween()
  if self.storeType == StoreType.eBuy then
    self:RefreshBuySelectItemDetail((storeItem.epStoreItemData).idx, storeItem.price)
  else
    if self.storeType == StoreType.eSell then
      self:RefreshSelectItemDetailSoldOut(storeItem.index)
    end
  end
end

UIEpStoreRoom.RefreshBuySelectItemDetail = function(self, index, price)
  -- function num : 0_12 , upvalues : _ENV
  (self.chipDetailPanel):Hide()
  local storeData = (self.storeDataList)[index]
  if storeData == nil then
    (((self.ui).btn_Buy).gameObject):SetActive(false)
    return 
  end
  if storeData.chipData ~= nil then
    self:_RefreshBuyChipDetail(index, storeData.chipData, price, storeData.saled)
  else
    if storeData.epBuffData ~= nil then
      self:_RefreshBuyBuffDetail(storeData.epBuffData)
    end
  end
  ;
  (((self.ui).btn_Buy).gameObject):SetActive(not storeData.saled)
  self:__ShowDetailSellOutUI(storeData.saled)
  self.currMoney = (ExplorationManager:GetDynPlayer()):GetMoneyCount()
  self.itemPrice = price
  local couldLoanMoney = ((ExplorationManager.epCtrl).campFetterCtrl):GetCouldLeonMoney()
  self.isLack = self.currMoney + couldLoanMoney < self.itemPrice and self.itemPrice > 0
  self:__SetLackState(self.isLack)
  local refreshCostNum = (self.storeCtrl):GetEpStoreRefreshPrice()
  local isLack = false
  local currMoney = ((self.storeCtrl).dynPlayer):GetItemCount((self.storeCtrl).currencyId)
  if refreshCostNum > 0 and currMoney < refreshCostNum then
    isLack = true
  end
  ;
  ((self.ui).tex_Money):SetIndex(1, tostring(self.itemPrice))
  ;
  ((self.ui).obj_RefreshLack):SetActive(isLack)
  -- DECOMPILER ERROR at PC99: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_RefreshPay).text = tostring(refreshCostNum)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIEpStoreRoom._RefreshBuyChipDetail = function(self, index, chipData, price, saled)
  -- function num : 0_13 , upvalues : ChipEnum
  (self.epBuffDetail):Hide()
  ;
  (self.chipDetailPanel):Show()
  ;
  (self.chipDetailPanel):InitEpChipDetail(index, chipData, (self.storeCtrl).dynPlayer, self.resloader)
  ;
  (self.chipDetailPanel):ShowHeroHeadOrTacticActive(true)
  ;
  (self.chipDetailPanel):ShowEpChipDetailEff(5)
  local isHadChip = (((self.storeCtrl).dynPlayer).chipDic)[chipData.dataId] ~= nil
  if not isHadChip or not (ChipEnum.eChipShowState).UpState then
    local chipShowState = (ChipEnum.eChipShowState).NewState
  end
  ;
  (self.chipDetailPanel):SetObjNewTagActive(true, chipShowState)
  local detailButtonGroup = (self.chipDetailPanel):GetDetailButtonGroup()
  if saled then
    detailButtonGroup:SetDefaultState()
  else
    detailButtonGroup:InitBtnSelByCost(true, price, self._onStoreBuyClicked)
  end
  self:__SetSellOutParent((self.chipDetailPanel).transform)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UIEpStoreRoom._RefreshBuyBuffDetail = function(self, epBuffData)
  -- function num : 0_14
  (self.epBuffDetail):Show()
  ;
  (self.epBuffDetail):InitEpBuffDetail(epBuffData)
  self:__SetSellOutParent((self.epBuffDetail).transform)
end

UIEpStoreRoom.RefreshSelectItemDetailSoldOut = function(self, index)
  -- function num : 0_15 , upvalues : _ENV
  local chipData = (self.chipList)[index]
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
  (self.chipDetailPanel):InitEpChipDetail(index, chipData, (self.storeCtrl).dynPlayer, self.resloader, true, eChipDetailPowerType.Subtract, true)
  ;
  (self.chipDetailPanel):ShowHeroHeadOrTacticActive(true)
  ;
  (self.chipDetailPanel):ShowEpChipDetailEff(5)
  ;
  (self.chipDetailPanel):SetObjNewTagActive(false)
  local buyPrice = chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleId())
  local salePrice = ConfigData:CalculateEpChipSalePrice(self.roomId, chipData:GetCount(), buyPrice, (self.storeCtrl).dynPlayer)
  ;
  ((self.ui).tex_Money):SetIndex(0, tostring(salePrice))
  ;
  ((self.chipDetailPanel):GetDetailButtonGroup()):InitBtnSelByCost(false, salePrice, self._onStoreBuyClicked)
  self:__SetLackState(false)
end

UIEpStoreRoom.__SetLackState = function(self, isLack)
  -- function num : 0_16
  ;
  ((self.ui).tex_Buy):SetIndex(isLack and 1 or 0)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).btn_Buy).interactable = not isLack
end

UIEpStoreRoom.OnStoreBuyClicked = function(self)
  -- function num : 0_17 , upvalues : StoreType, _ENV, cs_MessageCommon
  if self.storeType == StoreType.eBuy then
    local selectIndex, price, chipItem = (self.buyListNode):GetEpStoreBuyData()
    do
      local storeItemData = (self.storeDataList)[selectIndex]
      if storeItemData == nil then
        return 
      end
      local buyCompleteFunc = nil
      if storeItemData.chipData ~= nil then
        if (storeItemData.chipData):IsConsumeSkillChip() and self:__IsFullActiveAlgCount() then
          local maxConsumeCount = (ConfigData.game_config).activeAlgNumMax
          do
            local msg = (string.format)(ConfigData:GetTipContent(6032), maxConsumeCount, maxConsumeCount)
            ;
            (cs_MessageCommon.ShowMessageTipsWithErrorSound)(msg)
            return 
          end
        end
        do
          do
            local uiPos = (self.transform):InverseTransformPoint((chipItem.transform).position)
            do
              local localScale = (chipItem.transform).localScale
              buyCompleteFunc = function()
    -- function num : 0_17_0 , upvalues : _ENV, storeItemData, uiPos, localScale
    local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if dungeonStateWindow ~= nil then
      local chipData = storeItemData.chipData
      dungeonStateWindow:ShowGetChipAni(chipData, uiPos, localScale)
    end
  end

              ;
              (self.storeCtrl):SendStorePurchase(selectIndex, price, buyCompleteFunc)
            end
            if self.storeType == StoreType.eSell then
              local storeItem = (self.sellListNode):GetCurEpStoreRoomSell()
              if storeItem == nil then
                return 
              end
              local chipData = storeItem.chipData
              ;
              ((CS.MessageCommon).ShowMessageBox)((string.format)(ConfigData:GetTipContent(288), chipData:GetName(), tostring(storeItem.salePrice)), function()
    -- function num : 0_17_1 , upvalues : self, chipData, _ENV
    (self.storeCtrl):SendStoreSell(chipData, function()
      -- function num : 0_17_1_0 , upvalues : self, _ENV
      self.chipList = (ExplorationManager:GetDynPlayer()):GetChipList()
      ;
      (self.sellListNode):InitEpStoreRoomSell(self.chipList)
    end
)
  end
, nil)
            end
          end
        end
      end
    end
  end
end

UIEpStoreRoom.OnBtnEpStoreRefresh = function(self)
  -- function num : 0_18
  if ((self.ui).obj_RefreshLack).activeSelf then
    return 
  end
  ;
  (self.storeCtrl):ReqEpStoreRefresh()
end

UIEpStoreRoom.OnStoreSkipClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(TipContent.exploration_Store_Exit), function()
    -- function num : 0_19_0 , upvalues : self
    (self.storeCtrl):SendStoreQuit()
  end
, nil)
end

UIEpStoreRoom.OnStoreMapClicked = function(self)
  -- function num : 0_20
  self.__mapActiveState = not self.__mapActiveState
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

UIEpStoreRoom.FromMapBackToUI = function(self)
  -- function num : 0_21
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

UIEpStoreRoom.SwitchRoomMapBtnState = function(self, openMap)
  -- function num : 0_22 , upvalues : _ENV
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
  -- function num : 0_23
  if active then
    self:Hide()
  else
    self:Show()
  end
end

UIEpStoreRoom.__ShowDetailSellOutUI = function(self, active)
  -- function num : 0_24 , upvalues : _ENV
  if active ~= true then
    ((self.ui).obj_IsSellout):SetActive(IsNull((self.ui).obj_IsSellout))
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UIEpStoreRoom.__SetSellOutParent = function(self, parent)
  -- function num : 0_25 , upvalues : _ENV
  if not IsNull((self.ui).obj_IsSellout) then
    local trans = ((self.ui).obj_IsSellout).transform
    trans:SetParent(parent)
    trans.localPosition = Vector3.zero
    trans.sizeDelta = Vector2.zero
    trans:SetAsLastSibling()
  end
end

UIEpStoreRoom.__IsFullActiveAlgCount = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local count = (ConfigData.game_config).activeAlgNumMax
  local dynPlayer = (BattleUtil.GetCurDynPlayer)()
  if dynPlayer == nil then
    return false
  end
  for _,chipData in pairs(dynPlayer:GetNormalChipDic()) do
    if chipData:IsConsumeSkillChip() then
      count = count - 1
      if count == 0 then
        return true
      end
    end
  end
  return false
end

UIEpStoreRoom.OnDelete = function(self)
  -- function num : 0_27 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  if ExplorationManager.epCtrl ~= nil then
    (ExplorationManager.epCtrl).inTheTempRoom = nil
  end
  ;
  (self.chipDetailPanel):Delete()
  ;
  (self.epBuffDetail):Delete()
  ;
  (self.buyListNode):Delete()
  ;
  (self.sellListNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UIEpStoreRoom

