-- params : ...
-- function num : 0 , upvalues : _ENV
local TimePassFunc = {[proto_object_CounterModule.CounterModuleNone] = function(data, moduleRefreshTables)
  -- function num : 0_0 , upvalues : _ENV
  warn("timePass : CounterModuleNone")
end
, [proto_object_CounterModule.CounterModuleDailyQuest] = function(data, moduleRefreshTables)
  -- function num : 0_1 , upvalues : _ENV
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] then
    local refreshTable = {isSendMsg = false}
  end
  if not refreshTable.isSendMsg then
    (ControllerManager:GetController(ControllerTypeId.Task)):CheckExpiredAndUpdate()
    refreshTable.isSendMsg = true
  end
  moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] = refreshTable
end
, [proto_object_CounterModule.CounterModuleWeeklyQuest] = function(data, moduleRefreshTables)
  -- function num : 0_2 , upvalues : _ENV
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] then
    local refreshTable = {isSendMsg = false}
  end
  if not refreshTable.isSendMsg then
    (ControllerManager:GetController(ControllerTypeId.Task)):CheckExpiredAndUpdate()
    refreshTable.isSendMsg = true
  end
  moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] = refreshTable
end
, [proto_object_CounterModule.CounterModuleDungeonModuleCount] = function(data, moduleRefreshTables)
  -- function num : 0_3 , upvalues : _ENV
  local moduleId = data.specifyId
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] then
    local refreshTable = {isSendMsg = false, isSendResDundeonNotice = false}
  end
  if not refreshTable.isSendMsg then
    (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_DUNGEON_STATIC_Detail()
    refreshTable.isSendMsg = true
  end
  if not refreshTable.isSendResDundeonNotice and (moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_GoldDungeron or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_ExpDungeon or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon) then
    refreshTable.isSendResDundeonNotice = true
    local HomeEnum = require("Game.Home.HomeEnum")
    MsgCenter:Broadcast(eMsgEventId.NewNotice, (HomeEnum.eNoticeType).ResDungeonRefresh, data.nextExpiredTm, {targetId = 1701})
  else
    do
      do
        if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_friendship then
          local HomeEnum = require("Game.Home.HomeEnum")
          MsgCenter:Broadcast(eMsgEventId.NewNotice, (HomeEnum.eNoticeType).FragDungeonRefresh, data.nextExpiredTm, nil)
        end
        moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] = refreshTable
      end
    end
  end
end
, [proto_object_CounterModule.CounterModuleExplorationOverclock] = function(data, moduleRefreshTables)
  -- function num : 0_4 , upvalues : _ENV
  local OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, true)
  local OverclockWin = UIManager:GetWindow(UIWindowTypeID.OverClock)
  OverclockCtrl.needRefresh = true
  if OverclockWin ~= nil and OverclockWin.active then
    OverclockCtrl:CleanData()
    OverclockCtrl:CloseOverclockUI()
    OverclockCtrl:RefreshData()
  end
end
, [proto_object_CounterModule.CounterModuleGlobalDailyFlush] = function(data, moduleRefreshTables)
  -- function num : 0_5 , upvalues : _ENV
  local moduleId = data.specifyId
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleGlobalDailyFlush] then
    local refreshTable = {isSendMsg = false}
  end
  if not moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] then
    local dungeonRefreshTable = {isSendMsg = false, isSendResDundeonNotice = false}
  end
  if not refreshTable.isSendMsg then
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_SystemOverDay()
    refreshTable.isSendMsg = true
  end
  if not dungeonRefreshTable.isSendMsg then
    (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_DUNGEON_STATIC_Detail()
    dungeonRefreshTable.isSendMsg = true
  end
  moduleRefreshTables[proto_object_CounterModule.CounterModuleGlobalDailyFlush] = refreshTable
  moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] = dungeonRefreshTable
end
, [proto_object_CounterModule.CounterModuleDailyChallenge] = function(data, moduleRefreshTables)
  -- function num : 0_6 , upvalues : _ENV
  local moduleId = data.specifyId
  ;
  (PlayerDataCenter.periodicChallengeData):SetIsDailyOutOfData(true)
  local HomeEnum = require("Game.Home.HomeEnum")
  MsgCenter:Broadcast(eMsgEventId.NewNotice, (HomeEnum.eNoticeType).dailyChallenge, data.nextExpiredTm)
  local isInChallengeEp = not ExplorationManager:IsInExploration() or ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  if isInChallengeEp then
    (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_DAILYCHALLENGE_Detail(function()
    -- function num : 0_6_0 , upvalues : _ENV
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
    -- function num : 0_6_1 , upvalues : _ENV
    MsgCenter:Broadcast(eMsgEventId.ChallengeOutOfData)
  end
)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end
}
return TimePassFunc

