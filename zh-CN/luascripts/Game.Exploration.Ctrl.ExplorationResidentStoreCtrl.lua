-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationResidentStoreCtrl = class("ExplorationResidentStoreCtrl", ExplorationCtrlBase)
local ChipData = require("Game.PlayerData.Item.ChipData")
local cs_MessageCommon = CS.MessageCommon
ExplorationResidentStoreCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.waitRefersh = false
  self.__onMoneyChange = BindCallback(self, self.UpdateMoney)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
end

ExplorationResidentStoreCtrl.UpdateResidentStore = function(self, storeData)
  -- function num : 0_1 , upvalues : _ENV, ChipData
  self.storeDataList = {}
  self.currencyId = storeData.currency
  if storeData.data ~= nil then
    for idx,elem in ipairs(storeData.data) do
      local storeElem = {idx = idx - 1, id = elem.id, discount = elem.discount, saled = elem.saled, chipData = (ChipData.New)(elem.id, 1)}
      ;
      (table.insert)(self.storeDataList, storeElem)
    end
  end
  do
    if self.waitRefersh then
      self:OnResidentStoreRoomOpen()
      self.waitRefersh = false
    end
  end
end

ExplorationResidentStoreCtrl.OnResidentStoreRoomOpen = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.dynPlayer = ExplorationManager:GetDynPlayer()
  self.uiWindow = UIManager:ShowWindow(UIWindowTypeID.OldStoreRoom)
  if self.uiWindow ~= nil then
    (self.uiWindow):InitStoreRoom(self, self.storeDataList)
    self:UpdateMoney()
  end
end

ExplorationResidentStoreCtrl.UpdateMoney = function(self)
  -- function num : 0_3
  if self.uiWindow ~= nil and self.dynPlayer ~= nil then
    self.currency = (self.dynPlayer):GetItemCount(self.currencyId)
    if self.currency == nil then
      self.currency = 0
    end
    ;
    (self.uiWindow):UpdateMoney(self.currencyId, self.currency)
  end
end

ExplorationResidentStoreCtrl.SendStoreQuit = function(self)
  -- function num : 0_4
  (self.uiWindow):CloseWindow()
  self.uiWindow = nil
end

ExplorationResidentStoreCtrl.SendStorePurchase = function(self, storeItem)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  self.currStoreItem = storeItem
  if storeItem.price <= self.currency then
    self.waitRefersh = true
    ;
    (self.netWork):CS_EXPLORATION_RESIDENT_STORE_Purchase(storeItem.idx, BindCallback(self, self.OnStorePurchase))
  else
    local currencyName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[self.currencyId]).name)
    ;
    (cs_MessageCommon.ShowMessageTips)(currencyName .. ConfigData:GetTipContent(TipContent.exploration_Store_BuyItemInsufficient))
  end
end

ExplorationResidentStoreCtrl.OnStorePurchase = function(self)
  -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV
  (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Stroe_BuySuccess) .. (LanguageUtil.GetLocaleText)((self.currStoreItem):GetStoreItemName()))
end

ExplorationResidentStoreCtrl.ShowChipItemDetail = function(self, chipItem)
  -- function num : 0_7 , upvalues : _ENV
  self.detailWindow = UIManager:ShowWindow(UIWindowTypeID.GlobalChipDetail)
  if self.detailWindow ~= nil then
    (self.detailWindow):InitChipItemDetail(chipItem.chipData)
  end
end

ExplorationResidentStoreCtrl.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  self.uiWindow = nil
end

return ExplorationResidentStoreCtrl

