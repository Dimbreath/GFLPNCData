-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationTreasureCtrl = class("ExplorationTreasureCtrl", ExplorationCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local MAX_TREASURE_LOCK_NUM = 2
ExplorationTreasureCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.ItemRoom)
  self.treasureDataDic = {}
  self.lockNum = 0
  self.currPosition = nil
  self.epCtrl = epCtrl
  self.waitRefersh = false
  self.uiWindow = nil
  self.__OnTreasureRoomUpdate = BindCallback(self, self.__RefreshRoomData)
  MsgCenter:AddListener(eMsgEventId.OnTreasureRoomUpdate, self.__OnTreasureRoomUpdate)
end

ExplorationTreasureCtrl.OnTreasureRoomOpen = function(self, roomData, isFirstOpen)
  -- function num : 0_1 , upvalues : _ENV
  if not isFirstOpen then
    isFirstOpen = false
  end
  if roomData == nil then
    return 
  end
  self.dynPlayer = ExplorationManager:GetDynPlayer()
  self.roomData = roomData
  self.currPosition = roomData.position
  local treasureData = roomData.treasureData
  local roomCfg = self:__GetCfg(treasureData.boxId)
  if roomCfg == nil then
    error("Room cfg is nil,ID:" .. tostring(treasureData.boxId))
    return 
  end
  roomData.cfg = roomCfg
  for i,refreshTime in ipairs(roomCfg.times) do
    if treasureData.freshCnt <= refreshTime or refreshTime == -1 then
      roomData.refreshCostId = roomCfg.costId
      roomData.refreshCostNum = (roomCfg.costNums)[i]
      break
    end
  end
  do
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.treasureDataDic)[treasureData.boxId] = roomData
    UIManager:ShowWindowAsync(UIWindowTypeID.EpTreasureRoom, function(window)
    -- function num : 0_1_0 , upvalues : self, roomData, isFirstOpen
    if window == nil then
      return 
    end
    self.uiWindow = window
    ;
    (self.uiWindow):InitTreasureRoom(self, roomData)
    if isFirstOpen then
      ((self.epCtrl).autoCtrl):OnEnterEpTreasureRoom()
    end
  end
)
  end
end

ExplorationTreasureCtrl.__RefreshRoomData = function(self, roomData)
  -- function num : 0_2
  if self.waitRefersh and self.currPosition == roomData.position then
    self:OnTreasureRoomOpen(roomData)
    self.waitRefersh = false
  end
end

ExplorationTreasureCtrl.__GetCfg = function(self, boxId)
  -- function num : 0_3 , upvalues : _ENV
  self.cfgTable = {
[1] = {}
, [2] = ConfigData.treasure_logic2}
  local treasureCfg = (ConfigData.exploration_treasure)[boxId]
  return ((self.cfgTable)[treasureCfg.logic])[treasureCfg.treasure_id]
end

ExplorationTreasureCtrl.SendItemSelect = function(self, idx, action)
  -- function num : 0_4 , upvalues : _ENV, ExplorationEnum
  (self.netWork):CS_EXPLORATION_ITEM_Select(self.currPosition, idx, function()
    -- function num : 0_4_0 , upvalues : action, self, _ENV, ExplorationEnum
    if action ~= nil then
      action()
    end
    if self.uiWindow ~= nil then
      (self.uiWindow):Delete()
      self.uiWindow = nil
    end
    self.lockNum = 0
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).TreasureRoom)
  end
)
end

ExplorationTreasureCtrl.SendTreasureRoomQuit = function(self)
  -- function num : 0_5
  (self.netWork):CS_EXPLORATION_ITEM_Quit(self.currPosition)
end

ExplorationTreasureCtrl.OnTreasureRoomQuit = function(self)
  -- function num : 0_6 , upvalues : _ENV, ExplorationEnum
  if self.uiWindow ~= nil then
    (self.uiWindow):Delete()
    self.uiWindow = nil
  end
  self.lockNum = 0
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).TreasureRoom)
end

ExplorationTreasureCtrl.SendItemLockOrUnlock = function(self, chipItem)
  -- function num : 0_7 , upvalues : MAX_TREASURE_LOCK_NUM, cs_MessageCommon, _ENV
  if chipItem == nil then
    return 
  end
  self.curlockItem = chipItem
  self.curlockState = chipItem.lockState
  if not self.curlockState and self.lockNum == MAX_TREASURE_LOCK_NUM then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Treasure_AlertNotSelectAllReward))
    return 
  end
  local idx = chipItem.idx
  ;
  (self.netWork):CS_EXPLORATION_ITEM_LockUnlock(self.currPosition, idx)
end

ExplorationTreasureCtrl.OnItemLockOrUnlock = function(self)
  -- function num : 0_8
  if self.curlockState then
    self.lockNum = self.lockNum - 1
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.curlockItem).lockState = false
  else
    self.lockNum = self.lockNum + 1
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.curlockItem).lockState = true
  end
  ;
  (self.curlockItem):ChangelockUi()
end

ExplorationTreasureCtrl.SendRefreshTreasureRoom = function(self, boxId)
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon
  local roomData = (self.treasureDataDic)[boxId]
  if roomData == nil then
    error("ExplorationTreasureCtrl:SendRefreshTreasureRoom error: boxId is nil" .. tostring(boxId))
    return 
  end
  local refreshTime = ((roomData.cfg).times)[(roomData.treasureData).freshCnt + 1]
  if refreshTime ~= nil or refreshTime == -1 then
    if roomData.refreshCostNum <= (self.dynPlayer):GetMoneyCount() then
      (self.netWork):CS_EXPLORATION_ITEM_Fresh(self.currPosition)
    else
      ;
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Treasure_MoneyInsufficient))
    end
  else
    ;
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Treasure_RefreshNumInsufficient))
  end
end

ExplorationTreasureCtrl.OnRefreshTreasureRoom = function(self, active)
  -- function num : 0_10
  self.waitRefersh = active
end

ExplorationTreasureCtrl.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnTreasureRoomUpdate, self.__OnTreasureRoomUpdate)
  self.uiWindow = nil
end

return ExplorationTreasureCtrl

