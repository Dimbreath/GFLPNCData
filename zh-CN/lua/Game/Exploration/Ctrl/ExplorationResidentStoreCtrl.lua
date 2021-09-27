local ExplorationResidentStoreCtrl = class("ExplorationResidentStoreCtrl", ExplorationCtrlBase)
local ChipData = require("Game.PlayerData.Item.ChipData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_MessageCommon = CS.MessageCommon
ExplorationResidentStoreCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.__onMoneyChange = BindCallback(self, self.UpdateMoney)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  self.__OnExitRoomComplete = BindCallback(self, self.__OnRoomExitComplete)
  MsgCenter:AddListener(eMsgEventId.OnExitRoomComplete, self.__OnExitRoomComplete)
  self._OnStorePurchaseFunc = BindCallback(self, self._OnStorePurchase)
  self._OnStoreLockFunc = BindCallback(self, self._OnStoreLockComplete)
end

ExplorationResidentStoreCtrl.UpdateResidentStore = function(self, epResident)
  -- function num : 0_1 , upvalues : _ENV, ChipData
  self.storeDataList = {}
  if self.storeLevel ~= nil and self.storeLevel < epResident.lv then
    self._hasLevelUp = true
    self._oldLv = self.storeLevel
  end
  if self.storeExp ~= nil and self.storeExp ~= epResident.exp then
    self._lastAddExp = (math.max)(epResident.exp - self.storeExp, 0)
  end
  self.storeLevel = epResident.lv
  self.storeExp = epResident.exp
  self.formBattle = epResident.fromBattle
  if self.formBattle then
    self._isRefresh = true
  end
  for idx,elem in ipairs(epResident.data) do
    local chipData = (ChipData.NewChipForServer)(elem.id)
    local storeElem = {idx = idx - 1, id = chipData.dataId, sold = elem.saled, locked = elem.locked, chipData = chipData}
    ;
    (table.insert)(self.storeDataList, storeElem)
  end
  local window = UIManager:GetWindow(UIWindowTypeID.EpResidentStore)
  if window ~= nil then
    window:UpdEpResidentStore(self.storeDataList, self.storeLevel, self.storeExp, self._isRefresh)
    self._isRefresh = false
  end
  self._hasEpResidentStore = true
  self.dynPlayer = ExplorationManager:GetDynPlayer()
end

ExplorationResidentStoreCtrl.HasEpResidentStore = function(self)
  -- function num : 0_2
  return self._hasEpResidentStore
end

ExplorationResidentStoreCtrl.GetResidentStoreLastAddExp = function(self)
  -- function num : 0_3
  return self._lastAddExp or 0
end

ExplorationResidentStoreCtrl.OnResidentStoreRoomOpen = function(self, closeCallback)
  -- function num : 0_4 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.EpResidentStore, function(window)
    -- function num : 0_4_0 , upvalues : self, closeCallback
    if window == nil then
      return 
    end
    window:InitEpResidentStore(self)
    window:UpdEpResidentStore(self.storeDataList, self.storeLevel, self.storeExp, self._isRefresh, true)
    self._isRefresh = false
    if closeCallback ~= nil then
      window:SetEpResidentStoreCloseFunc(closeCallback)
    end
  end
)
end

ExplorationResidentStoreCtrl.UpdateMoney = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.EpResidentStore)
  if window ~= nil then
    window:UpdEpRTRefreshBtnState()
  end
end

ExplorationResidentStoreCtrl.__OnRoomExitComplete = function(self, roomType)
  -- function num : 0_6
  self:_TryShowLevelUp()
end

ExplorationResidentStoreCtrl._TryShowLevelUp = function(self)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  if not self._hasLevelUp then
    return 
  end
  self._hasLevelUp = false
  local cellingAdd = 0
  for lv = self._oldLv + 1, self.storeLevel do
    local shopCfg = (ConfigData.weekly_challenge_shop)[self.storeLevel]
    if shopCfg == nil then
      error("Cant get weekly_challenge_shop, level = " .. tostring(lv))
    else
      cellingAdd = cellingAdd + shopCfg.function_limit_bonus
    end
  end
  ;
  (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(6007), true)
  ;
  (cs_MessageCommon.ShowMessageTips)((string.format)(ConfigData:GetTipContent(6008), cellingAdd), true)
  ;
  (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(6009), true)
end

ExplorationResidentStoreCtrl.CheckEpResidentStore = function(self, closeCallback)
  -- function num : 0_8 , upvalues : _ENV
  local showStore = false
  local curRoomData = (self.epCtrl):GetCurrentRoomData()
  if curRoomData:GetIsInBigBossRoom() then
    return showStore
  end
  local isFirstRoom = not curRoomData:IsStartRoom() or ExplorationManager:GetCurLevelIndex() == 0
  if self:HasEpResidentStore() and (self.formBattle or (self.dynPlayer):GetOperatorDetailState() == proto_object_ExplorationCurGridState.ExplorationCurGridState_MonsterLvUpgrade or isFirstRoom) then
    local autoOpenStoreFunc = function()
    -- function num : 0_8_0 , upvalues : self, closeCallback
    self:OnResidentStoreRoomOpen(closeCallback)
  end

    do
      local tryOpenSelectDebuffSelect = function()
    -- function num : 0_8_1 , upvalues : self, _ENV, autoOpenStoreFunc
    if (self.dynPlayer):HasDebuffSelect() then
      UIManager:ShowWindowAsync(UIWindowTypeID.EpSelectDebuff, function(win)
      -- function num : 0_8_1_0 , upvalues : self, autoOpenStoreFunc
      if win == nil then
        return 
      end
      win:InitEpSelectDebuff(self.dynPlayer, autoOpenStoreFunc)
    end
)
    else
      autoOpenStoreFunc()
    end
  end

      local hasMonsterLvUp, oldLevel, newLevel = (self.dynPlayer):HasEpMonsterLvUp(true)
      if hasMonsterLvUp then
        UIManager:ShowWindowAsync(UIWindowTypeID.EpMonsterLevelUp, function(window)
    -- function num : 0_8_2 , upvalues : oldLevel, newLevel, tryOpenSelectDebuffSelect
    if window == nil then
      return 
    end
    window:InitEpMonsterLevelUp(oldLevel, newLevel, tryOpenSelectDebuffSelect)
  end
)
      else
        autoOpenStoreFunc()
      end
      showStore = true
    end
  end
  self.formBattle = false
  do return showStore end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

ExplorationResidentStoreCtrl.ReqResidentStorePurchase = function(self, index, callBack)
  -- function num : 0_9 , upvalues : cs_MessageCommon, _ENV
  local elemData = (self.storeDataList)[index]
  local chipData = elemData.chipData
  local chipCount = (self.dynPlayer):GetChipCount(chipData.dataId)
  if chipCount == 0 and (self.dynPlayer):IsChipFull() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(6006))
    return 
  end
  local elemData = (self.storeDataList)[index]
  local chipData = elemData.chipData
  self._purchaseCallback = callBack
  local cucurrency = (ExplorationManager:GetDynPlayer()):GetMoneyCount()
  if chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleId()) <= cucurrency then
    self._purchaseChipData = chipData
    ;
    (self.netWork):CS_EXPLORATION_RESIDENT_STORE_Purchase(elemData.idx, self._OnStorePurchaseFunc)
  else
    local currencyName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[ConstGlobalItem.EpMoney]).name)
    ;
    (cs_MessageCommon.ShowMessageTips)(currencyName .. ConfigData:GetTipContent(TipContent.exploration_Store_BuyItemInsufficient))
  end
end

ExplorationResidentStoreCtrl._OnStorePurchase = function(self)
  -- function num : 0_10 , upvalues : cs_MessageCommon, _ENV
  local chipData = self._purchaseChipData
  ;
  (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Stroe_BuySuccess) .. chipData:GetName())
  ;
  (ExplorationManager:GetEpDataCenter()):AddNewChip(chipData.dataId)
  if self._purchaseCallback ~= nil then
    (self._purchaseCallback)()
  end
end

ExplorationResidentStoreCtrl.ReqEpResidentStoreRefresh = function(self)
  -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon
  local allLock = true
  for k,elem in ipairs(self.storeDataList) do
    if not elem.locked then
      allLock = false
      break
    end
  end
  do
    if allLock then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(6005))
      return 
    end
    ;
    (self.netWork):CS_EXPLORATION_RESIDENT_STORE_Refresh()
    self._isRefresh = true
  end
end

ExplorationResidentStoreCtrl.ReqEpResidentStoreLock = function(self, index, callBack)
  -- function num : 0_12
  local elemData = (self.storeDataList)[index]
  self._lockElemData = elemData
  self._lockCallback = callBack
  ;
  (self.netWork):CS_EXPLORATION_RESIDENT_STORE_LockUnlock(elemData.idx, self._OnStoreLockFunc)
end

ExplorationResidentStoreCtrl._OnStoreLockComplete = function(self)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (self._lockElemData).locked = not (self._lockElemData).locked
  if self._lockCallback ~= nil then
    (self._lockCallback)((self._lockElemData).locked)
  end
end

ExplorationResidentStoreCtrl.ReqEpResidentStoreLvUp = function(self, callBack)
  -- function num : 0_14 , upvalues : _ENV, cs_MessageCommon
  if (ConfigData.weekly_challenge_shop).maxLevel <= self.storeLevel then
    return 
  end
  local nextLvCfg = (ConfigData.weekly_challenge_shop)[self.storeLevel + 1]
  if nextLvCfg == nil then
    error("Cant get weekly_challenge_shop, level = " .. tostring(self.storeLevel + 1))
    return 
  end
  local needMoney = (nextLvCfg.exp - self.storeExp) * (ConfigData.game_config).epResidentStoreBuyExpCost
  if (self.dynPlayer):GetMoneyCount() < needMoney then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(35))
    return 
  end
  self._ReqLvUpCallback = callBack
  if not self._OnStoreLvUpFunc then
    self._OnStoreLvUpFunc = BindCallback(self, self._OnStoreLvUp)
    ;
    (self.netWork):CS_EXPLORATION_RESIDENT_STORE_PurchaseExp(self._OnStoreLvUpFunc)
  end
end

ExplorationResidentStoreCtrl._OnStoreLvUp = function(self)
  -- function num : 0_15
  self:_TryShowLevelUp()
  if self._ReqLvUpCallback ~= nil then
    (self._ReqLvUpCallback)()
  end
end

ExplorationResidentStoreCtrl.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  MsgCenter:RemoveListener(eMsgEventId.OnExitRoomComplete, self.__OnExitRoomComplete)
end

return ExplorationResidentStoreCtrl

