local ExplorationPlayerCtrl = class("ExplorationPlayerCtrl", ExplorationCtrlBase)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_ColorUtility = (CS.UnityEngine).ColorUtility
ExplorationPlayerCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.dynPlayer = epCtrl.dynPlayer
  self.epNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.__onRoomSelected = BindCallback(self, self.OnMove)
  MsgCenter:AddListener(eMsgEventId.OnRoomSelected, self.__onRoomSelected)
  self.__onEpOperatorUpdate = BindCallback(self, self.UpdateEpOp)
  MsgCenter:AddListener(eMsgEventId.OnEpOpStore, self.__onEpOperatorUpdate)
  self.__onEpOperatorDiff = BindCallback(self, self.OnEpOperatorDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpOperatorDiff, self.__onEpOperatorDiff)
  self.__onEpFormDetailDiff = BindCallback(self, self.OnEpFormationDetailDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpFormationDetailDiff, self.__onEpFormDetailDiff)
  self.__onEpBackpackDiff = BindCallback(self, self.OnEpBackpackDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpBackpackDiff, self.__onEpBackpackDiff)
  self.__OnEpBuffDiff = BindCallback(self, self.OnEpBuffDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffDiff, self.__OnEpBuffDiff)
  self.__OnExitRoomComplete = BindCallback(self, self.__OnRoomExitComplete)
  MsgCenter:AddListener(eMsgEventId.OnExitRoomComplete, self.__OnExitRoomComplete)
  self.__OnChipDataDiff = BindCallback(self, self.OnChipDataDiff)
  MsgCenter:AddListener(eMsgEventId.OnChipDataDiff, self.__OnChipDataDiff)
  self.__OnEpServerGridDiff = BindCallback(self, self.OnEpServerGridDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpServerGridDiff, self.__OnEpServerGridDiff)
  self.__OnEpRewardBagDiff = BindCallback(self, self.OnEpRewardBagDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpRewardBagDiff, self.__OnEpRewardBagDiff)
  self.__OnEpCommonDataDiff = BindCallback(self, self.OnEpCommonDataDiff)
  MsgCenter:AddListener(eMsgEventId.OnEpCommonDataDiff, self.__OnEpCommonDataDiff)
end

ExplorationPlayerCtrl.__OnRoomExitComplete = function(self, roomType)
  -- function num : 0_1 , upvalues : ExplorationEnum, _ENV
  local inBattleRoomSelectChip = roomType == (ExplorationEnum.eExitRoomCompleteType).BattleToEp and (self.dynPlayer):GetOperatorDetailState() == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleALGWaiting
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  if not inBattleRoomSelectChip then
    (self.dynPlayer).playerClientState = (ExplorationEnum.ePlayerClientState).Exting
    ;
    (self.epCtrl):CheckAfterOutSide()
    ;
    (self.epCtrl):OnExitEpRoomBegin()
  end
  do
    if roomType ~= (ExplorationEnum.eExitRoomCompleteType).BattleToEp then
      local hasMonsterLvUp, oldLevel, newLevel = (self.dynPlayer):HasEpMonsterLvUp(true)
      do
        if hasMonsterLvUp then
          UIManager:ShowWindowAsync(UIWindowTypeID.EpMonsterLevelUp, function(window)
    -- function num : 0_1_0 , upvalues : oldLevel, newLevel, self, _ENV
    if window == nil then
      return 
    end
    window:InitEpMonsterLevelUp(oldLevel, newLevel, function()
      -- function num : 0_1_0_0 , upvalues : self, _ENV
      if (self.dynPlayer):HasDebuffSelect() then
        UIManager:ShowWindowAsync(UIWindowTypeID.EpSelectDebuff, function(win)
        -- function num : 0_1_0_0_0 , upvalues : self, _ENV
        if win == nil then
          return 
        end
        win:InitEpSelectDebuff(self.dynPlayer, autoOpenStoreFunc)
      end
)
      end
    end
)
  end
)
        end
      end
    end
    self:__TryShowNewReward()
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

ExplorationPlayerCtrl.__TryShowNewReward = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local lastRewardDataList = ((self.dynPlayer).dynRewardBag):TryGetLastEpRewardBagDataList()
  if lastRewardDataList == nil then
    return 
  end
  if #lastRewardDataList > 0 then
    local epWindow = UIManager:GetWindow(UIWindowTypeID.Exploration)
    if epWindow ~= nil then
      epWindow:StartFlyRewardBag()
    end
  end
end

ExplorationPlayerCtrl.AutoRoomSelect = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local opDetail = (self.dynPlayer):GetOperatorDetail()
  if opDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_HalfOver then
    local currentRoomData = self:GetCurrentRoomData()
    self:Move(currentRoomData, true)
  end
end

ExplorationPlayerCtrl.Move = function(self, roomData, auto)
  -- function num : 0_4 , upvalues : _ENV, ExplorationEnum
  local opDetail = (self.dynPlayer):GetOperatorDetail()
  if opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over and not auto then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.exploration_Player_CantSelectRoom))
    return 
  end
  if opDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    (self.dynPlayer):RecordLastMoney()
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.dynPlayer).playerClientState = (ExplorationEnum.ePlayerClientState).Entering
  ;
  (self.epNetwork):CS_EXPLORATION_Select(roomData.position)
end

ExplorationPlayerCtrl.OnMove = function(self)
  -- function num : 0_5
  local currentRoom = self:GetCurrentRoomData()
  ;
  (self.epCtrl):OnPlayerMoveStart(currentRoom)
end

ExplorationPlayerCtrl.CheckEpRoomAccess = function(self, roomData, isFreeSelect)
  -- function num : 0_6 , upvalues : _ENV
  local opDetail = (self.dynPlayer):GetOperatorDetail()
  if (opDetail.epFloorWalked)[roomData.position] then
    return false
  end
  local currentRoom = self:GetCurrentRoomData(true)
  if currentRoom == nil then
    return false
  end
  if currentRoom:IsCrossRoom() and currentRoom.x == roomData.x and currentRoom.y ~= roomData.y then
    return true
  end
  if isFreeSelect then
    local nextRooms = currentRoom:GetNextAllRoom()
    return (table.contain)(nextRooms, roomData)
  else
    do
      local nextRooms = currentRoom:GetNextRoom()
      do return (table.contain)(nextRooms, roomData) end
    end
  end
end

ExplorationPlayerCtrl.CheckIsEpRoomWatchingMap = function(self, roomData)
  -- function num : 0_7 , upvalues : _ENV
  local currentRoom = self:GetCurrentRoomData(true)
  if currentRoom == roomData then
    MsgCenter:Broadcast(eMsgEventId.OnShowingMapRoomClick)
    return true
  end
  return false
end

ExplorationPlayerCtrl.GetCurrentRoomData = function(self, withoutSpecialRoom)
  -- function num : 0_8
  local mapData = (self.epCtrl).mapData
  local opDetail = ((self.dynPlayer):GetOperatorDetail())
  local currentRoom = nil
  if not withoutSpecialRoom and opDetail.specialCat > 0 then
    currentRoom = mapData:GetEpSpecialRoomData()
  else
    currentRoom = mapData:GetRoomByCoord(opDetail.curPostion)
  end
  return currentRoom
end

ExplorationPlayerCtrl.UpdateEpOp = function(self, epOp)
  -- function num : 0_9
  (self.dynPlayer):UpdateOperatorDetail(epOp)
end

ExplorationPlayerCtrl.OnEpOperatorDiff = function(self, epOp)
  -- function num : 0_10 , upvalues : _ENV, ExplorationEnum
  MsgCenter:Broadcast(eMsgEventId.OnEpOpStateChanged, (self.dynPlayer):GetOperatorDetail())
  self:UpdEpRoomDataByEpOp((self.dynPlayer):GetOperatorDetail())
  if epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_DropAlg then
    (self.epCtrl):DiscardChip()
  else
    if epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted then
      local isInBattleSceen = ((self.epCtrl).sceneCtrl):InBattleScene()
      if not isInBattleSceen then
        local currentRoom = self:GetCurrentRoomData()
        if currentRoom.jumpCat ~= nil and currentRoom.jumpCat > 0 and (self.dynPlayer).playerClientState == (ExplorationEnum.ePlayerClientState).InRoom then
          ((self.epCtrl).eventCtrl):JumpEpEventRoomComplete()
          ;
          (self.epCtrl):OnPlayerMoveComplete(currentRoom)
        end
      end
    else
      do
        if epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridStateReplaceChip then
          (self.epCtrl):OpenChipReplace()
        else
          if epOp.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_QuestSelect then
            local isInBattleSceen = ((self.epCtrl).sceneCtrl):InBattleScene()
            if not isInBattleSceen then
              (self.epCtrl):OpenEpTask()
            end
          end
        end
      end
    end
  end
end

ExplorationPlayerCtrl.UpdEpRoomDataByEpOp = function(self, opDetail)
  -- function num : 0_11 , upvalues : _ENV
  local curRoomData = self:GetCurrentRoomData()
  curRoomData:SetEpRoomEpOpStateChanged(opDetail)
  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

  if opDetail.deco and self.dynPlayer ~= nil then
    if (opDetail.deco)[1] then
      (self.dynPlayer):UpdateEpSaveMoneyList(((opDetail.deco)[1]).arrParams)
    else
      ;
      (self.dynPlayer):UpdateEpSaveMoneyList()
    end
    if (opDetail.deco)[2] then
      (self.dynPlayer):UpdateEpBattleSkillLockDic(((opDetail.deco)[2]).mapParams)
    else
      ;
      (self.dynPlayer):UpdateEpBattleSkillLockDic()
    end
  end
  ;
  (self.dynPlayer):UpdateEpSaveMoneyList()
  ;
  (self.dynPlayer):UpdateEpBattleSkillLockDic()
  ;
  ((self.epCtrl).mapData):ClearPassedRoomData(opDetail, curRoomData)
  if opDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    local playerPower = (self.dynPlayer):GetCacheFightPower()
    self.nextRoomList = curRoomData:GetNextRoom()
    for k,tmpRoomData in pairs(self.nextRoomList) do
      if (self.epCtrl).mapCtrl ~= nil then
        ((self.epCtrl).mapCtrl):ShowFightingPower(tmpRoomData, playerPower)
      end
      local visible = tmpRoomData:GetVisible()
      if visible == false then
        tmpRoomData:SetVisible(true)
        if (self.epCtrl).mapCtrl ~= nil then
          ((self.epCtrl).mapCtrl):RefreshRoomVisible(tmpRoomData)
        end
      end
    end
    if (self.epCtrl).mapCtrl ~= nil then
      ((self.epCtrl).mapCtrl):RefreshNightBattleView(curRoomData)
      ;
      ((self.epCtrl).mapCtrl):UpdateViewRangeLine()
    end
    if opDetail.deco and (opDetail.deco)[1] then
      MsgCenter:Broadcast(eMsgEventId.EpSaveMoneyChange)
    end
  end
end

ExplorationPlayerCtrl.OnEpFormationDetailDiff = function(self, epForm)
  -- function num : 0_12
  (self.dynPlayer):UpdateFormationDetail(epForm)
end

ExplorationPlayerCtrl.OnEpBackpackDiff = function(self, epBackpack)
  -- function num : 0_13
  (self.dynPlayer):UpdateEpBackpack(epBackpack)
end

ExplorationPlayerCtrl.OnEpBuffDiff = function(self, epBuff)
  -- function num : 0_14
  (self.dynPlayer):UpdateEpBuff(epBuff)
end

ExplorationPlayerCtrl.OnChipDataDiff = function(self, diffData)
  -- function num : 0_15 , upvalues : _ENV
  local chipDiff = diffData[proto_csmsg_AlgModule.AlgModuleExploration]
  if chipDiff ~= nil then
    (self.dynPlayer):UpdateChipDiff(chipDiff)
  end
end

ExplorationPlayerCtrl.OnEpServerGridDiff = function(self, epBattleGrid)
  -- function num : 0_16
  (self.dynPlayer):UpdateAllDynServerGrid(epBattleGrid)
end

ExplorationPlayerCtrl.OnEpRewardBagDiff = function(self, epStmGoods)
  -- function num : 0_17
  ((self.dynPlayer).dynRewardBag):UpdateEpDynRewardBag(epStmGoods)
end

ExplorationPlayerCtrl.OnEpCommonDataDiff = function(self, epCommon)
  -- function num : 0_18
  (self.dynPlayer):UpdateEpCommonData(epCommon)
end

ExplorationPlayerCtrl.OnDelete = function(self)
  -- function num : 0_19 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnRoomSelected, self.__onRoomSelected)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStore, self.__onEpOperatorUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOperatorDiff, self.__onEpOperatorDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpFormationDetailDiff, self.__onEpFormDetailDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBackpackDiff, self.__onEpBackpackDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffDiff, self.__OnEpBuffDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnExitRoomComplete, self.__OnExitRoomComplete)
  MsgCenter:RemoveListener(eMsgEventId.OnChipDataDiff, self.__OnChipDataDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpServerGridDiff, self.__OnEpServerGridDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpRewardBagDiff, self.__OnEpRewardBagDiff)
  MsgCenter:RemoveListener(eMsgEventId.OnEpCommonDataDiff, self.__OnEpCommonDataDiff)
end

return ExplorationPlayerCtrl

