local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
local TimePassFunc = {[proto_object_CounterModule.CounterModuleNone] = function(data, moduleRefreshTables)
  -- function num : 0_0 , upvalues : _ENV
  warn("timePass : CounterModuleNone")
end
, [proto_object_CounterModule.CounterModuleDailyQuest] = function(data, moduleRefreshTables)
  -- function num : 0_1 , upvalues : _ENV
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] then
    local refreshTable = {isSendMsg = false}
  end
  do
    if not refreshTable.isSendMsg then
      local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
      if taskCtrl ~= nil then
        taskCtrl:CheckExpiredAndUpdate()
        refreshTable.isSendMsg = true
      end
    end
    moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] = refreshTable
  end
end
, [proto_object_CounterModule.CounterModuleWeeklyQuest] = function(data, moduleRefreshTables)
  -- function num : 0_2 , upvalues : _ENV
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] then
    local refreshTable = {isSendMsg = false}
  end
  do
    if not refreshTable.isSendMsg then
      local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
      if taskCtrl ~= nil then
        taskCtrl:CheckExpiredAndUpdate()
        refreshTable.isSendMsg = true
      end
    end
    moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] = refreshTable
  end
end
, [proto_object_CounterModule.CounterModuleDungeonModuleCount] = function(data, moduleRefreshTables)
  -- function num : 0_3 , upvalues : _ENV, NoticeData, JumpManager
  local moduleId = data.specifyId
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] then
    local refreshTable = {isSendMsg = false, isSendResDundeonNotice = false}
  end
  if not refreshTable.isSendMsg then
    (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_DUNGEON_STATIC_Detail()
    refreshTable.isSendMsg = true
  end
  if not refreshTable.isSendResDundeonNotice and (moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_GoldDungeron or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_ExpDungeon or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon2 or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon3) then
    refreshTable.isSendResDundeonNotice = true
    NoticeManager:AddNotice((NoticeData.CreateNoticeData)(data.nextExpiredTm, (NoticeManager.eNoticeType).ResDungeonRefresh, {jumpType = (JumpManager.eJumpTarget).resourceDungeon, 
argList = {1701}
}, nil, nil))
  else
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_friendship then
      local heroId = (ConfigData.game_config).firtBoardHeroID
      NoticeManager:AddNotice((NoticeData.CreateNoticeData)(data.nextExpiredTm, (NoticeManager.eNoticeType).FragDungeonRefresh, {jumpType = (JumpManager.eJumpTarget).fragDungeon, 
argList = {heroId}
}, nil, nil))
    end
  end
  do
    moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] = refreshTable
  end
end
, [proto_object_CounterModule.CounterModuleGlobalDailyFlush] = function(data, moduleRefreshTables)
  -- function num : 0_4 , upvalues : _ENV
  local moduleId = data.specifyId
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleGlobalDailyFlush] then
    local refreshTable = {isSendMsg = false}
  end
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] then
    local dungeonRefreshTable = {isSendMsg = false, isSendResDundeonNotice = false}
  end
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] then
    local WCRefreshTable = {isSendMsg = false}
  end
  if not refreshTable.isSendMsg then
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_SystemOverDay()
    refreshTable.isSendMsg = true
  end
  if not dungeonRefreshTable.isSendMsg then
    (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_DUNGEON_STATIC_Detail()
    dungeonRefreshTable.isSendMsg = true
  end
  if not WCRefreshTable.isSendMsg and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge) then
    WCRefreshTable.isSendMsg = true
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_WEEKLYCHALLENGE_Detail(function()
    -- function num : 0_4_0
  end
)
  end
  moduleRefreshTables[proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] = WCRefreshTable
  moduleRefreshTables[proto_object_CounterModule.CounterModuleGlobalDailyFlush] = refreshTable
  moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] = dungeonRefreshTable
end
, [proto_object_CounterModule.CounterModuleDailyChallenge] = function(data, moduleRefreshTables)
  -- function num : 0_5 , upvalues : _ENV, NoticeData, JumpManager
  local moduleId = data.specifyId
  ;
  (PlayerDataCenter.periodicChallengeData):SetIsDailyOutOfData(true)
  NoticeManager:AddNotice((NoticeData.CreateNoticeData)(data.nextExpiredTm, (NoticeManager.eNoticeType).dailyChallenge, {jumpType = (JumpManager.eJumpTarget).Sector, argList = nil}, nil, nil))
  local isInChallengeEp = not ExplorationManager:IsInExploration() or ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  if isInChallengeEp then
    (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_DAILYCHALLENGE_Detail(function()
    -- function num : 0_5_0 , upvalues : _ENV
    ExplorationManager:ExitExploration()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    if (Time.unity_time).timeScale ~= 1 then
      (Time.unity_time).timeScale = 1
    end
  end
)
    return 
  end
  local hasHasUncompletedEp, stageId, moduleId = ExplorationManager:HasUncompletedEp()
  if hasHasUncompletedEp and moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
    ExplorationManager:RecordLastEpData({})
  end
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_DAILYCHALLENGE_Detail(function()
    -- function num : 0_5_1 , upvalues : _ENV
    MsgCenter:Broadcast(eMsgEventId.ChallengeOutOfData)
  end
)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end
, [proto_object_CounterModule.CounterModuleDailyBouns] = function(data, moduleRefreshTables)
  -- function num : 0_6
end
, [proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] = function(data, moduleRefreshTables)
  -- function num : 0_7 , upvalues : _ENV, NoticeData, JumpManager
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] then
    local WCRefreshTable = {isSendMsg = false}
  end
  ;
  (PlayerDataCenter.allWeeklyChallengeData):SetOutOfData()
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge) and (PlayerDataCenter.allWeeklyChallengeData):IsExistChallenge() then
    NoticeManager:AddNotice((NoticeData.CreateNoticeData)(data.nextExpiredTm, (NoticeManager.eNoticeType).weeklyChallenge, {jumpType = (JumpManager.eJumpTarget).Sector, argList = nil}, nil, nil))
  end
  local isInChallengeEp = not ExplorationManager:IsInExploration() or ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
  if isInChallengeEp then
    WCRefreshTable.isSendMsg = true
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_WEEKLYCHALLENGE_Detail(function()
    -- function num : 0_7_0 , upvalues : _ENV
    ExplorationManager:ExitExploration()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    if (Time.unity_time).timeScale ~= 1 then
      (Time.unity_time).timeScale = 1
    end
  end
)
    moduleRefreshTables[proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] = WCRefreshTable
    return 
  end
  local hasHasUncompletedEp, stageId, moduleId = ExplorationManager:HasUncompletedEp()
  if hasHasUncompletedEp and moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    ExplorationManager:RecordLastEpData({})
  end
  if not WCRefreshTable.isSendMsg then
    WCRefreshTable.isSendMsg = true
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_WEEKLYCHALLENGE_Detail(function()
    -- function num : 0_7_1 , upvalues : _ENV
    MsgCenter:Broadcast(eMsgEventId.ChallengeOutOfData)
  end
)
  end
  moduleRefreshTables[proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] = WCRefreshTable
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end
, [proto_object_CounterModule.CounterModuleRefreshableDungeon] = function(data, moduleRefreshTables)
  -- function num : 0_8 , upvalues : _ENV
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleRefreshableDungeon] then
    local refreshTable = {isSendMsg = false}
  end
  moduleRefreshTables[proto_object_CounterModule.CounterModuleRefreshableDungeon] = refreshTable
  if (BattleUtil.IsInDailyDungeon)() then
    refreshTable.isSendMsg = true
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_DUNGEON_Dync_Detail(function()
    -- function num : 0_8_0 , upvalues : _ENV
    local dungeonCtrl = BattleDungeonManager:GetDungeonCtrl()
    if dungeonCtrl ~= nil and dungeonCtrl:DungeonIsInWaitFirstLoadScene() then
      dungeonCtrl:SetDungeonAfterEnterSceneExit()
    else
      BattleDungeonManager:RetreatDungeonNoReq()
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

      if (Time.unity_time).timeScale ~= 1 then
        (Time.unity_time).timeScale = 1
      end
    end
  end
)
    return 
  end
  if not refreshTable.isSendMsg then
    refreshTable.isSendMsg = true
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_DUNGEON_Dync_Detail(function()
    -- function num : 0_8_1 , upvalues : _ENV
    MsgCenter:Broadcast(eMsgEventId.DailyDungeonOutOfData)
  end
)
  end
end
, [proto_object_CounterModule.CounterModuleWekklyChallengeQuest] = function(data, moduleRefreshTables)
  -- function num : 0_9 , upvalues : _ENV
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleWekklyChallengeQuest] then
    local refreshTable = {isSendMsg = false}
  end
  do
    if not refreshTable.isSendMsg then
      local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
      if taskCtrl ~= nil then
        taskCtrl:CheckExpiredAndUpdate()
        refreshTable.isSendMsg = true
      end
    end
    moduleRefreshTables[proto_object_CounterModule.CounterModuleWekklyChallengeQuest] = refreshTable
  end
end
, [proto_object_CounterModule.CounterModuleDormFixedRewardFresh] = function(data, moduleRefreshTables)
  -- function num : 0_10 , upvalues : _ENV
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleDormFixedRewardFresh] then
    local refreshTable = {isSendMsg = false}
  end
  if not refreshTable.isSendMsg then
    refreshTable.isSendMsg = true
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.TimingProduct)):CS_TimingProduct_Detail(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, function()
    -- function num : 0_10_0 , upvalues : _ENV
    MsgCenter:Broadcast(eMsgEventId.TimingProductOutOfDate)
  end
)
  end
  moduleRefreshTables[proto_object_CounterModule.CounterModuleDormFixedRewardFresh] = refreshTable
end
, [proto_object_CounterModule.CounterModuleMaintain] = function(data, moduleRefreshTables)
  -- function num : 0_11
  return 
end
}
return TimePassFunc

