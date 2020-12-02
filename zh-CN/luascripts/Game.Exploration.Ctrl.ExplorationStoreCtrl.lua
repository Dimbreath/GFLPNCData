-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationStoreCtrl = class("ExplorationStoreCtrl", ExplorationCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
ExplorationStoreCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.StoreRoom)
  self.epCtrl = epCtrl
  self.waitRefersh = false
  self.__onStoreRoomUpdate = BindCallback(self, self.__OnStoreRoomUpdate)
  MsgCenter:AddListener(eMsgEventId.OnStoreRoomUpdate, self.__onStoreRoomUpdate)
end

ExplorationStoreCtrl.OnStoreRoomOpen = function(self, roomData, isFirstOpen)
  -- function num : 0_1 , upvalues : _ENV
  if roomData == nil then
    return 
  end
  self.roomData = roomData
  self.currPosition = roomData.position
  self.storeDataList = (roomData.storeRoomData).data
  self.currencyId = (roomData.storeRoomData).currencyId
  self.dynPlayer = ExplorationManager:GetDynPlayer()
  UIManager:ShowWindowAsync(UIWindowTypeID.EpStoreRoom, function(window)
    -- function num : 0_1_0 , upvalues : self, isFirstOpen
    if window == nil then
      return 
    end
    self.uiWindow = window
    ;
    (self.uiWindow):InitStoreRoom(self, self.storeDataList)
    if isFirstOpen then
      ((self.epCtrl).autoCtrl):OnEnterEpStoreRoom()
    end
  end
)
end

ExplorationStoreCtrl.SendStoreQuit = function(self)
  -- function num : 0_2
  (self.netWork):CS_EXPLORATION_STORE_Quit((self.roomData).position)
end

ExplorationStoreCtrl.ReqEpStoreRefresh = function(self)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon
  local refreshTimes = ((self.roomData).storeRoomData).refreshTimes
  local shopRoomCfg = (ConfigData.exploration_shop)[((self.roomData).storeRoomData).storeId]
  local currMoney = (self.dynPlayer):GetItemCount(self.currencyId)
  local refreshCostNum = shopRoomCfg.init_fresh_price + shopRoomCfg.increase_fresh_price * refreshTimes
  if currMoney < refreshCostNum then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Treasure_MoneyInsufficient))
    return 
  end
  self.waitRefersh = true
  ;
  (self.netWork):CS_EXPLORATION_STORE_Refresh((self.roomData).position, function()
    -- function num : 0_3_0 , upvalues : _ENV
    AudioManager:PlayAudioById(1039)
  end
)
end

ExplorationStoreCtrl.OnStoreQuit = function(self)
  -- function num : 0_4 , upvalues : _ENV, ExplorationEnum
  if self.uiWindow ~= nil then
    (self.uiWindow):Delete()
    self.uiWindow = nil
  end
  self.curBuyIndex = nil
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).StoreRoom)
end

ExplorationStoreCtrl.SendStorePurchase = function(self, index, price, completeAction)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  self.curBuyIndex = index
  local storeData = (self.storeDataList)[self.curBuyIndex]
  if storeData == nil then
    return 
  end
  local isChip = ConfigData:GetItemType(storeData.id) == eItemType.GlobalChip
  local money = (self.dynPlayer):GetItemCount(self.currencyId)
  if price <= money then
    self.waitRefersh = true
    ;
    (self.netWork):CS_EXPLORATION_STORE_Purchase(index - 1, (self.roomData).position, isChip, function()
    -- function num : 0_5_0 , upvalues : cs_MessageCommon, _ENV, storeData, completeAction
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Stroe_BuySuccess) .. (LanguageUtil.GetLocaleText)((storeData.chipData):GetName()))
    if completeAction ~= nil then
      completeAction()
    end
  end
)
  else
    local currencyName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[self.currencyId]).name)
    ;
    (cs_MessageCommon.ShowMessageTips)(currencyName .. ConfigData:GetTipContent(TipContent.exploration_Store_BuyItemInsufficient))
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ExplorationStoreCtrl.SendStoreSell = function(self, chipData, completeAction)
  -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV
  (self.netWork):CS_EXPLORATION_STORE_Sold((self.roomData).position, chipData.dataId, true, function()
    -- function num : 0_6_0 , upvalues : self, cs_MessageCommon, _ENV, chipData, completeAction
    self.waitRefersh = true
    ;
    (cs_MessageCommon.ShowMessageTips)((LanguageUtil.GetLocaleText)(chipData:GetName()) .. ConfigData:GetTipContent(TipContent.exploration_Store_SellSuc))
    if completeAction ~= nil then
      completeAction()
    end
  end
)
end

ExplorationStoreCtrl.__OnStoreRoomUpdate = function(self, roomData)
  -- function num : 0_7
  if self.waitRefersh and self.currPosition == roomData.position then
    self:OnStoreRoomOpen(roomData)
    self.waitRefersh = false
  end
end

ExplorationStoreCtrl.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnStoreRoomUpdate, self.__onStoreRoomUpdate)
  self.uiWindow = nil
end

return ExplorationStoreCtrl

