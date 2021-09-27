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
    -- function num : 0_1_0 , upvalues : self, _ENV, isFirstOpen
    if window == nil then
      return 
    end
    self.uiWindow = window
    ;
    (self.uiWindow):InitStoreRoom(self, self.storeDataList)
    ;
    ((ExplorationManager.epCtrl).campFetterCtrl):OnOpenStore()
    ;
    ((self.epCtrl).autoCtrl):OnEnterEpStoreRoom(self.storeDataList, self.currencyId, isFirstOpen)
    if isFirstOpen and not ((self.epCtrl).autoCtrl):IsAutoModeRunning() then
      GuideManager:TryTriggerGuide(eGuideCondition.InEpStoreRoom)
    end
  end
)
end

ExplorationStoreCtrl.SendStoreQuit = function(self)
  -- function num : 0_2
  (self.netWork):CS_EXPLORATION_STORE_Quit((self.roomData).position)
end

ExplorationStoreCtrl.GetEpStoreRefreshPrice = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if ((self.roomData).storeRoomData).extraFetterFreeRefreshTimes > 0 then
    return 0
  else
    local refreshTimes = ((self.roomData).storeRoomData).refreshTimes
    local shopRoomCfg = (ConfigData.exploration_shop)[((self.roomData).storeRoomData).storeId]
    local refreshCostNum = shopRoomCfg.init_fresh_price + shopRoomCfg.increase_fresh_price * refreshTimes
    return refreshCostNum
  end
end

ExplorationStoreCtrl.ReqEpStoreRefresh = function(self)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  local price = self:GetEpStoreRefreshPrice()
  local currMoney = (self.dynPlayer):GetItemCount(self.currencyId)
  if price > 0 and currMoney < price then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.exploration_Treasure_MoneyInsufficient))
    return 
  end
  self.waitRefersh = true
  ;
  (self.netWork):CS_EXPLORATION_STORE_Refresh((self.roomData).position, function()
    -- function num : 0_4_0 , upvalues : _ENV
    AudioManager:PlayAudioById(1039)
  end
)
end

ExplorationStoreCtrl.OnStoreQuit = function(self)
  -- function num : 0_5 , upvalues : _ENV, ExplorationEnum
  if self.uiWindow ~= nil then
    (self.uiWindow):Delete()
    self.uiWindow = nil
  end
  self.curBuyIndex = nil
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).StoreRoom)
end

ExplorationStoreCtrl.SendStorePurchase = function(self, index, price, completeAction)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon
  self.curBuyIndex = index
  local storeData = (self.storeDataList)[self.curBuyIndex]
  if storeData == nil then
    return 
  end
  local money = (self.dynPlayer):GetMoneyCount()
  local couldLoanMoney = ((self.epCtrl).campFetterCtrl):GetCouldLeonMoney()
  if price <= money + couldLoanMoney or price <= 0 then
    self.waitRefersh = true
    ;
    (self.netWork):CS_EXPLORATION_STORE_Purchase(index - 1, (self.roomData).position, function()
    -- function num : 0_6_0 , upvalues : storeData, _ENV, cs_MessageCommon, completeAction
    local name = nil
    if storeData.epBuffData ~= nil then
      name = (storeData.epBuffData):GetEpBuffName()
    else
      if storeData.chipData ~= nil then
        name = (LanguageUtil.GetLocaleText)((storeData.chipData):GetName())
        local chipId = (storeData.chipData).dataId
        ;
        (ExplorationManager:GetEpDataCenter()):AddNewChip(chipId)
      end
    end
    do
      ;
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Stroe_BuySuccess) .. name)
      if completeAction ~= nil then
        completeAction()
      end
    end
  end
)
  else
    local currencyName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[self.currencyId]).name)
    ;
    (cs_MessageCommon.ShowMessageTips)(currencyName .. ConfigData:GetTipContent(TipContent.exploration_Store_BuyItemInsufficient))
  end
end

ExplorationStoreCtrl.SendStoreSell = function(self, chipData, completeAction)
  -- function num : 0_7 , upvalues : cs_MessageCommon, _ENV
  (self.netWork):CS_EXPLORATION_STORE_Sold((self.roomData).position, chipData.dataId, function()
    -- function num : 0_7_0 , upvalues : self, cs_MessageCommon, _ENV, chipData, completeAction
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
  -- function num : 0_8
  if self.waitRefersh and self.currPosition == roomData.position then
    self.waitRefersh = false
    self:OnStoreRoomOpen(roomData)
  end
end

ExplorationStoreCtrl.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnStoreRoomUpdate, self.__onStoreRoomUpdate)
  self.uiWindow = nil
end

return ExplorationStoreCtrl

