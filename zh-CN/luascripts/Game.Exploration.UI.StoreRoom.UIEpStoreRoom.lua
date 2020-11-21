-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpStoreRoom = class("UIEpStoreRoom", UIBaseWindow)
local base = UIBaseWindow
local UIEpStoreRoomItem = require(
                              "Game.Exploration.UI.StoreRoom.UIEpStoreRoomItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
local StoreType = {eBuy = 1, eSell = 2}
UIEpStoreRoom.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
    (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnStoreSkipClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnStoreBuyClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnStoreMapClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Refresh, self,
                               self.OnBtnEpStoreRefresh)
    self.__OnStoreItemClick = BindCallback(self, self.OnStoreItemClick) -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).storeList).onInstantiateItem =
        BindCallback(self, self.__StoreListInitItem) -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).storeList).onChangeItem =
        BindCallback(self, self.__StoreListItemChanged)
    self.storeItemDic = {}
    self.resloader = ((CS.ResLoader).Create)()
    self.chipDetailPanel = (UINChipDetailPanel.New)();
    (self.chipDetailPanel):Init((self.ui).chipItemDetail);
    (self.chipDetailPanel):SetChipEffectHeroNodeActive(true)
    self.__OnChipDetailActiveChange = BindCallback(self,
                                                   self.OnChipDetailActiveChange)
    MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange,
                          self.__OnChipDetailActiveChange)
    self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
    MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick,
                          self.__FromMapBackToUI);
    (UIUtil.AddButtonListener)((self.ui).btn_BuyTypeItem, self,
                               self.LoadStoreData);
    (UIUtil.AddButtonListener)((self.ui).btn_SellTypeItem, self,
                               self.LoadChipOwnData)
    self.onChipListUpdate = BindCallback(self, self.__onChipListUpdate)
    MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.onChipListUpdate)
end

UIEpStoreRoom.InitStoreRoom = function(self, storeCtrl, storeDataList)
    -- function num : 0_1 , upvalues : _ENV
    self.storeCtrl = storeCtrl
    self.roomId = (((self.storeCtrl).roomData).storeRoomData).storeId
    local needReFill = self.storeDataList == nil or #self.storeDataList ~=
                           #storeDataList
    self.MoneyIconId = (ExplorationManager:GetDynPlayer()):GetMoneyIconId()
    self.selectedIndex = 1
    self.storeDataList = storeDataList
    for k, storeData in ipairs(self.storeDataList) do
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
    local needScrollIndex = (math.max)(self.selectedIndex - 1, 0);
    ((self.ui).storeList):SrollToCell(needScrollIndex, 10000)
    self.__mapActiveState = false
    self:SwitchRoomMapBtnState(self.__mapActiveState)
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UIEpStoreRoom.LoadStoreData = function(self)
    -- function num : 0_2 , upvalues : StoreType, _ENV
    self:SwitchStoreTypeUI(StoreType.eBuy)
    self.selectedIndex = 1
    for k, storeData in ipairs(self.storeDataList) do
        if not storeData.saled then
            self.selectedIndex = k
            break
        end
    end
    do

        ((self.ui).storeList):ClearCells() -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).storeList).onInstantiateItem =
            BindCallback(self, self.__StoreListInitItem) -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).storeList).onChangeItem =
            BindCallback(self, self.__StoreListItemChanged)
        self:__ReFillList(self.storeDataList)
        self:RefreshSelectItemDetail()
    end
end

UIEpStoreRoom.LoadChipOwnData = function(self)
    -- function num : 0_3 , upvalues : StoreType, _ENV
    self:SwitchStoreTypeUI(StoreType.eSell)
    self.chipList = (ExplorationManager:GetDynPlayer()):GetChipList()
    self.selectedIndex = 1;
    ((self.ui).storeList):ClearCells() -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).storeList).onChangeItem =
        BindCallback(self, self.__ChipListItemChanged)
    self:__ReFillList(self.chipList)
    self:RefreshSelectItemDetailSoldOut()
end

UIEpStoreRoom.__onChipListUpdate = function(self, chipList)
    -- function num : 0_4 , upvalues : StoreType
    self.chipList = chipList
    if self.storeType == StoreType.eSell then
        self.selectedIndex = 1
        self:__ReFillList(self.chipList)
        self:RefreshSelectItemDetailSoldOut()
    end
end

UIEpStoreRoom.SwitchStoreTypeUI = function(self, storeType)
    -- function num : 0_5 , upvalues : StoreType, _ENV
    self.storeType = storeType
    if self.storeType == StoreType.eBuy then
        ((self.ui).buyTypeImg):SetIndex(0) -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).buyTypeText).color = Color.black;
        ((self.ui).sellTypeImg):SetIndex(1) -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).sellTypeText).color = Color.white
    else
        if self.storeType == StoreType.eSell then
            ((self.ui).sellTypeImg):SetIndex(0) -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'
            ;
            ((self.ui).sellTypeText).color = Color.black;
            ((self.ui).buyTypeImg):SetIndex(1) -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'
            ;
            ((self.ui).buyTypeText).color = Color.white
        end
    end
    (((self.ui).btn_Refresh).gameObject):SetActive(
        self.storeType == StoreType.eBuy)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIEpStoreRoom.__ReFillList = function(self, dataList)
    -- function num : 0_6
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).storeList).totalCount = #dataList;
    ((self.ui).storeList):RefillCells()
end

UIEpStoreRoom.__StoreListInitItem = function(self, go)
    -- function num : 0_7 , upvalues : UIEpStoreRoomItem
    local storeItem = (UIEpStoreRoomItem.New)()
    storeItem:Init(go) -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.storeItemDic)[go] = storeItem
end

UIEpStoreRoom.__StoreListItemChanged = function(self, go, index)
    -- function num : 0_8 , upvalues : _ENV
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
    storeItem:InitStoreRoomItem(self.roomId, storeData, self.MoneyIconId,
                                self.__OnStoreItemClick)
    storeItem:SetStoreItemSelect(index == self.selectedIndex)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIEpStoreRoom.__ChipListItemChanged = function(self, go, index)
    -- function num : 0_9 , upvalues : _ENV
    local chipItem = (self.storeItemDic)[go]
    if chipItem == nil then
        error("Can\'t find Item by gameObject")
        return
    end
    index = index + 1
    local chipData = (self.chipList)[index]
    chipData.idx = index
    if chipData == nil then
        error("Can\'t find chipData by index, index = " .. tonumber(index))
    end
    chipItem:InitStoreRoomItem(self.roomId, chipData, self.MoneyIconId,
                               self.__OnStoreItemClick, true)
    chipItem:SetStoreItemSelect(index == self.selectedIndex)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIEpStoreRoom.__GetStoreItemByIndex = function(self, index)
    -- function num : 0_10 , upvalues : _ENV
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
    -- function num : 0_11 , upvalues : StoreType
    if storeItem == nil then return end
    if self.selectedIndex == storeItem.index then return end
    local lastStoreItem = self:__GetStoreItemByIndex(self.selectedIndex)
    if lastStoreItem ~= nil then lastStoreItem:SetStoreItemSelect(false) end
    self.selectedIndex = storeItem.index
    storeItem:SetStoreItemSelect(true)
    if self.storeType == StoreType.eBuy then
        self:RefreshSelectItemDetail(storeItem.price)
    else
        if self.storeType == StoreType.eSell then
            self:RefreshSelectItemDetailSoldOut()
        end
    end
end

UIEpStoreRoom.RefreshSelectItemDetail = function(self, price)
    -- function num : 0_12 , upvalues : _ENV
    local storeData = (self.storeDataList)[self.selectedIndex]
    if storeData == nil then
        (((self.ui).btn_Buy).gameObject):SetActive(false);
        (self.chipDetailPanel):Hide()
        return
    end
    (((self.ui).btn_Buy).gameObject):SetActive(not storeData.saled);
    (self.chipDetailPanel):Show();
    (self.chipDetailPanel):InitChipDetailPanel(self.selectedIndex,
                                               storeData.chipData,
                                               (self.storeCtrl).dynPlayer,
                                               self.resloader)
    self.currMoney = (ExplorationManager:GetDynPlayer()):GetMoneyCount()
    self.itemPrice = 0 -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).ani_Img).color = (self.ui).buyImgColor
    if price == nil then
        self.itemPrice = (math.ceil)(((storeData.chipData).itemCfg).price *
                                         storeData.discount / 100)
    else
        self.itemPrice = price
    end
    ((self.ui).tex_buy):SetIndex(1) -- DECOMPILER ERROR at PC69: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (((self.ui).tex_buy).text).color = Color.black;
    ((self.ui).img_buy):SetIndex(0)
    self.isLack = self.currMoney < self.itemPrice
    self:__SetLackState(self.isLack)
    local refreshTimes =
        (((self.storeCtrl).roomData).storeRoomData).refreshTimes
    local shopRoomCfg = (ConfigData.exploration_shop)[self.roomId]
    if shopRoomCfg == nil then
        error("exploration shop is null,roomId:" .. tostring(self.roomId))
    end
    local currMoney = ((self.storeCtrl).dynPlayer):GetItemCount(
                          (self.storeCtrl).currencyId)
    local refreshCostNum = shopRoomCfg.init_fresh_price +
                               shopRoomCfg.increase_fresh_price * refreshTimes
    local isLack = currMoney < refreshCostNum;
    ((self.ui).obj_RefreshLack):SetActive(isLack) -- DECOMPILER ERROR at PC126: Confused about usage of register: R8 in 'UnsetPending'
    ;
    ((self.ui).tex_RefreshPay).text = tostring(refreshCostNum)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIEpStoreRoom.RefreshSelectItemDetailSoldOut =
    function(self)
        -- function num : 0_13 , upvalues : _ENV
        local chipData = (self.chipList)[self.selectedIndex]
        if chipData == nil then
            (((self.ui).btn_Buy).gameObject):SetActive(false);
            (self.chipDetailPanel):Hide()
            return
        end
        (((self.ui).btn_Buy).gameObject):SetActive(true) -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).ani_Img).color = (self.ui).sellImgColor;
        (self.chipDetailPanel):Show();
        (self.chipDetailPanel):InitChipDetailPanel(self.selectedIndex, chipData,
                                                   (self.storeCtrl).dynPlayer,
                                                   self.resloader, nil, true,
                                                   true);
        ((self.ui).tex_buy):SetIndex(2) -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'
        ;
        (((self.ui).tex_buy).text).color = Color.white;
        ((self.ui).img_buy):SetIndex(1)
        self:__SetLackState(false)
    end

UIEpStoreRoom.__SetLackState = function(self, isLack)
    -- function num : 0_14
    ((self.ui).obj_Lack):SetActive(isLack)
    if isLack then ((self.ui).tex_buy):SetIndex(0) end
    ((self.ui).ani_Buy):SetActive(not isLack);
    (((self.ui).ani_Img).gameObject):SetActive(not isLack)
end

UIEpStoreRoom.OnStoreBuyClicked = function(self)
    -- function num : 0_15 , upvalues : StoreType, _ENV
    local storeItem = self:__GetStoreItemByIndex(self.selectedIndex)
    if storeItem == nil then return end
    local chipData = storeItem.chipData
    local chipItem = storeItem:GetStoreChipItem()
    local uiPos = (self.transform):InverseTransformPoint(
                      (chipItem.transform).position)
    local localScale = (chipItem.transform).localScale
    if self.storeType == StoreType.eBuy then
        (self.storeCtrl):SendStorePurchase(storeItem.index, storeItem.price,
                                           function()
            -- function num : 0_15_0 , upvalues : _ENV, chipData, uiPos, localScale
            local dungeonStateWindow = UIManager:GetWindow(
                                           UIWindowTypeID.DungeonStateInfo)
            if dungeonStateWindow ~= nil then
                dungeonStateWindow:ShowGetChipAni(chipData, uiPos, localScale)
            end
        end)
    else
        if self.storeType == StoreType.eSell then
            (self.storeCtrl):SendStoreSell(chipData, function()
                -- function num : 0_15_1 , upvalues : self, _ENV
                self.chipList =
                    (ExplorationManager:GetDynPlayer()):GetChipList()
                self:__ReFillList(self.chipList)
            end)
        end
    end
end

UIEpStoreRoom.OnBtnEpStoreRefresh = function(self)
    -- function num : 0_16
    (self.storeCtrl):ReqEpStoreRefresh()
end

UIEpStoreRoom.OnStoreSkipClicked = function(self)
    -- function num : 0_17
    (self.storeCtrl):SendStoreQuit()
end

UIEpStoreRoom.OnStoreMapClicked = function(self)
    -- function num : 0_18
    self.__mapActiveState = not self.__mapActiveState
    self:SwitchRoomMapBtnState(self.__mapActiveState)
end

UIEpStoreRoom.FromMapBackToUI = function(self)
    -- function num : 0_19
    self.__mapActiveState = false
    self:SwitchRoomMapBtnState(self.__mapActiveState)
end

UIEpStoreRoom.SwitchRoomMapBtnState = function(self, openMap)
    -- function num : 0_20 , upvalues : _ENV
    if openMap then
        ((self.ui).tex_MapBtnName):SetIndex(1)
    else

        ((self.ui).tex_MapBtnName):SetIndex(0)
    end
    ((self.ui).frameNode):SetActive(not openMap)
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, openMap)
end

UIEpStoreRoom.OnChipDetailActiveChange =
    function(self, active)
        -- function num : 0_21
        if active then
            self:Hide()
        else
            self:Show()
        end
    end

UIEpStoreRoom.OnDelete = function(self)
    -- function num : 0_22 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange,
                             self.__OnChipDetailActiveChange)
    MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick,
                             self.__FromMapBackToUI)
    MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange,
                             self.onChipListUpdate)
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true);
    (base.OnDelete)(self)
end

return UIEpStoreRoom

