-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskNetworkCtrl = class("TaskNetworkCtrl", NetworkCtrlBase)
local TaskData = require("Game.Task.Data.TaskData")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local SectorData = require("Game.Sector.Data.SectorData")
local LastSendType = {UpgradeSchedule = 1, CommitQuest = 2}
TaskNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.lastSendDataList = {}
end

TaskNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_UpgradeSchedule, self, proto_csmsg.SC_QUEST_UpgradeSchedule, self.OnRecvUpgradeSchedule)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_CommitQuest, self, proto_csmsg.SC_QUEST_CommitQuest, self.OnRecvCommitQuest)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_SyncUpdateDiff, self, proto_csmsg.SC_QUEST_SyncUpdateDiff, self.OnRecvSyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_Detail, self, proto_csmsg.SC_QUESTPERIOD_Detail, self.OnQuestPeriodDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_RewardPicked, self, proto_csmsg.SC_QUESTPERIOD_RewardPicked, self.OnQuestPeriodRewardPicked)
end

TaskNetworkCtrl.SendUpgradeSchedule = function(self, qusetId, questStep)
  -- function num : 0_2 , upvalues : _ENV, LastSendType
  local tabMsg = {qusetId = qusetId, questStep = questStep}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_UpgradeSchedule, proto_csmsg.CS_QUEST_UpgradeSchedule, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.UpgradeSchedule
  saveList.qusetId = qusetId
  ;
  (table.insert)(self.lastSendDataList, saveList)
end

TaskNetworkCtrl.OnRecvUpgradeSchedule = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "TaskNetworkCtrl:OnRecvUpgradeSchedule error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
end

TaskNetworkCtrl.SendCommitQuest = function(self, taskData)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
  local tabMsg = {qusetId = taskData.id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_CommitQuest, proto_csmsg.CS_QUEST_CommitQuest, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_CommitQuest, proto_csmsg_MSG_ID.MSG_SC_QUEST_CommitQuest)
  local saveList = {}
  saveList.type = LastSendType.CommitQuest
  saveList.taskId = taskData.id
  saveList.taskStcData = taskData.stcData
  ;
  (table.insert)(self.lastSendDataList, saveList)
end

TaskNetworkCtrl.OnRecvCommitQuest = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_CommitQuest)
    local err = "TaskNetworkCtrl:OnRecvCommitQuest error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
end

TaskNetworkCtrl.OnRecvSyncUpdateDiff = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, TaskEnum, TaskData, LastSendType, SectorData
  local deleteGuideTaskList = nil
  for k,v in pairs(msg.delete) do
    local taskData = ((PlayerDataCenter.allTaskData).taskDatas)[k]
    if taskData ~= nil then
      if (taskData.stcData).isShow then
        MsgCenter:Broadcast(eMsgEventId.TaskDelete, k)
      end
      if (v == proto_object_QuestDeleteReason.QuestDeleteReasonCompleted or v == proto_object_QuestDeleteReason.QuestDeleteReasonCompletedShowOver) and (taskData.stcData).type == (TaskEnum.eTaskType).MainTask then
        (PlayerDataCenter.allTaskData):RecordCompletedMainTask(k)
      end
      if #(taskData.stcData).guide_id > 0 then
        (table.removebyvalue)((PlayerDataCenter.allTaskData).guideTaskDatas, taskData)
        if not deleteGuideTaskList then
          deleteGuideTaskList = {}
        end
        ;
        (table.insert)(deleteGuideTaskList, taskData)
      end
    end
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((PlayerDataCenter.allTaskData).taskDatas)[k] = nil
  end
  local newGuideTaskCount = 0
  local newTaskDataList = nil
  for k,v in pairs(msg.update) do
    local taskData = ((PlayerDataCenter.allTaskData).taskDatas)[k]
    local isNewTask = false
    if taskData == nil then
      local stcData = (ConfigData.task)[k]
      if stcData == nil then
        error("Cant\'t find taskCfg,id = " .. k)
      else
        do
          do
            taskData = (TaskData.CreateTaskData)(v, stcData)
            -- DECOMPILER ERROR at PC99: Confused about usage of register: R13 in 'UnsetPending'

            ;
            ((PlayerDataCenter.allTaskData).taskDatas)[k] = taskData
            if #stcData.guide_id > 0 then
              newGuideTaskCount = newGuideTaskCount + 1
            end
            isNewTask = true
            taskData:UpdateTaskData(v)
            if isNewTask then
              if newTaskDataList == nil then
                newTaskDataList = {}
              end
              ;
              (table.insert)(newTaskDataList, taskData)
            end
            if (taskData.stcData).isShow then
              MsgCenter:Broadcast(eMsgEventId.TaskUpdate, taskData)
            end
            if (taskData.stcData).type == (TaskEnum.eTaskType).MainTask and taskData:CheckComplete() then
              (PlayerDataCenter.allTaskData):RecordCompletedMainTask(k)
            end
            -- DECOMPILER ERROR at PC146: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC146: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC146: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC146: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC146: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  ;
  (PlayerDataCenter.allTaskData):UpdateAllTaskData()
  if #self.lastSendDataList ~= 0 then
    local lastData = (table.remove)(self.lastSendDataList, 1)
  end
  do
    if (lastData.type ~= LastSendType.UpgradeSchedule or lastData.type == LastSendType.CommitQuest) and (lastData.taskStcData).isShow then
      local isSectorType, sectorId = (PlayerDataCenter.allTaskData):IsSectorType((lastData.taskStcData).type)
      if isSectorType then
        (SectorData.UpdateCompleteTaskData)(sectorId, (lastData.taskStcData).id)
      end
      MsgCenter:Broadcast(eMsgEventId.TaskCommitComplete, lastData.taskStcData)
    end
    if newTaskDataList ~= nil then
      (table.sort)(newTaskDataList, function(a, b)
    -- function num : 0_6_0
    do return (a.stcData).id < (b.stcData).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      MsgCenter:Broadcast(eMsgEventId.TaskReceived, newTaskDataList)
    end
    MsgCenter:Broadcast(eMsgEventId.TaskSyncFinish)
    if deleteGuideTaskList ~= nil and #deleteGuideTaskList > 0 then
      GuideManager:OnGuideTaskDelete(deleteGuideTaskList)
    end
    if newTaskDataList ~= nil and (GuideManager.firstBattleGuideCtrl):TryStartFirstBattleGuide(newTaskDataList) then
      return 
    end
    if newGuideTaskCount > 0 then
      GuideManager:TryTriggerGuide(nil, newTaskDataList)
    end
  end
end

TaskNetworkCtrl.SendQuestPeriodDetail = function(self)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_Detail, proto_csmsg.CS_QUESTPERIOD_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_Detail, proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_Detail)
end

TaskNetworkCtrl.OnQuestPeriodDetail = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    (ControllerManager:GetController(ControllerTypeId.Task, true)):RecvPeriodTaskDetail(msg)
  else
    local err = "TaskNetworkCtrl:OnQuestPeriodDetail error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_Detail)
  end
end

TaskNetworkCtrl.SendQuestPeriodRewardPicked = function(self, index, showingActiveType, callback)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {cat = showingActiveType, idx = index}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardPicked, proto_csmsg.CS_QUESTPERIOD_RewardPicked, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardPicked, callback, proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_RewardPicked)
end

TaskNetworkCtrl.OnQuestPeriodRewardPicked = function(self, msg)
  -- function num : 0_10 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "TaskNetworkCtrl:OnQuestPeriodRewardPicked error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardPicked)
  end
end

TaskNetworkCtrl.Reset = function(self)
  -- function num : 0_11
  self.lastSendDataList = {}
end

return TaskNetworkCtrl

