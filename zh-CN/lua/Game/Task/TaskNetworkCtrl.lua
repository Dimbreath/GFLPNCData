local TaskNetworkCtrl = class("TaskNetworkCtrl", NetworkCtrlBase)
local TaskData = require("Game.Task.Data.TaskData")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
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
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_RewardOnePicked, self, proto_csmsg.SC_QUESTPERIOD_RewardOnePicked, self.SC_QUESTPERIOD_RewardOnePicked)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_ClientAddSchedule, self, proto_csmsg.SC_QUEST_ClientAddSchedule, self.SC_QUEST_ClientAddSchedule)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_OneKeyPick, self, proto_csmsg.SC_QUEST_OneKeyPick, self.SC_QUEST_OneKeyPick)
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
  -- function num : 0_3 , upvalues : _ENV
  if msg.ret == proto_csmsg_ErrorCode.None then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  else
    ;
    (table.remove)(self.lastSendDataList, 1)
    local err = "TaskNetworkCtrl:OnRecvUpgradeSchedule error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

TaskNetworkCtrl.SendCommitQuest = function(self, taskData, callbak)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
  local tabMsg = {qusetId = taskData.id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_CommitQuest, proto_csmsg.CS_QUEST_CommitQuest, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_CommitQuest, callbak, proto_csmsg_MSG_ID.MSG_SC_QUEST_CommitQuest)
  local saveList = {}
  saveList.type = LastSendType.CommitQuest
  saveList.taskId = taskData.id
  saveList.taskStcData = taskData.stcData
  ;
  (table.insert)(self.lastSendDataList, saveList)
end

TaskNetworkCtrl.OnRecvCommitQuest = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  else
    ;
    (table.remove)(self.lastSendDataList, 1)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_CommitQuest)
    local err = "TaskNetworkCtrl:OnRecvCommitQuest error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

TaskNetworkCtrl.OnRecvSyncUpdateDiff = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, TaskEnum, TaskData, LastSendType
  local deleteGuideTaskList = nil
  for k,v in pairs(msg.delete) do
    local taskData = ((PlayerDataCenter.allTaskData).taskDatas)[k]
    if taskData ~= nil then
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
      ;
      (PlayerDataCenter.allTaskData):RemoveTaskData(taskData)
    end
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
            ;
            (PlayerDataCenter.allTaskData):AddTaskData(taskData)
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
              (PlayerDataCenter.activityStarUpData):UpdateTask(taskData)
              ;
              (PlayerDataCenter.allTaskData):AllTaskOnTaskUpdate(taskData)
              MsgCenter:Broadcast(eMsgEventId.TaskUpdate, taskData)
            end
            if (taskData.stcData).type == (TaskEnum.eTaskType).MainTask and taskData:CheckComplete() then
              (PlayerDataCenter.allTaskData):RecordCompletedMainTask(k)
            end
            ;
            (PlayerDataCenter.allTaskData):TryAutoCompleteHidenTask(taskData)
            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_STMT

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
        (PlayerDataCenter.sectorAchievementDatas):UpdateCompleteTaskData(sectorId, (lastData.taskStcData).id)
      end
      ;
      (PlayerDataCenter.activityStarUpData):UpdateStage((lastData.taskStcData).id)
      ;
      (PlayerDataCenter.allTaskData):AllTaskOnTaskCommit(lastData.taskStcData)
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
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    ;
    (ControllerManager:GetController(ControllerTypeId.Task, true)):RecvPeriodTaskDetail(msg)
    local window = UIManager:GetWindow(UIWindowTypeID.Home)
    if window ~= nil then
      (window.homeLeftNode):RefreshTaskBtn()
    end
    local navigationWin = UIManager:GetWindow(UIWindowTypeID.NavigationBar)
    if navigationWin ~= nil then
      navigationWin:UpdateNaviTaskQucikPreview()
    end
  else
    do
      local err = "TaskNetworkCtrl:OnQuestPeriodDetail error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_Detail)
    end
  end
end

TaskNetworkCtrl.SendQuestPeriodRewardPicked = function(self, index, showingActiveType, callback)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {cat = showingActiveType, idx = index}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardPicked, proto_csmsg.CS_QUESTPERIOD_RewardPicked, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardPicked, callback, proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_RewardPicked)
end

TaskNetworkCtrl.OnQuestPeriodRewardPicked = function(self, msg)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "TaskNetworkCtrl:OnQuestPeriodRewardPicked error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardPicked)
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

TaskNetworkCtrl.CS_QUESTPERIOD_RewardOnePicked = function(self, indexDic, cat, callback)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {quest = indexDic, cat = cat}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardOnePicked, proto_csmsg.CS_QUESTPERIOD_RewardOnePicked, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardOnePicked, callback, proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_RewardOnePicked)
end

TaskNetworkCtrl.SC_QUESTPERIOD_RewardOnePicked = function(self, msg)
  -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "TaskNetworkCtrl:SC_QUESTPERIOD_RewardOnePicked error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardOnePicked)
  end
end

TaskNetworkCtrl.CS_QUEST_ClientAddSchedule = function(self, action)
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_ClientAddSchedule, proto_csmsg.CS_QUEST_ClientAddSchedule, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_ClientAddSchedule, action, proto_csmsg_MSG_ID.MSG_SC_QUEST_ClientAddSchedule)
end

TaskNetworkCtrl.SC_QUEST_ClientAddSchedule = function(self, msg)
  -- function num : 0_14 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "TaskNetworkCtrl:SC_QUEST_ClientAddSchedule error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_ClientAddSchedule)
  end
end

TaskNetworkCtrl.CS_QUEST_OneKeyPick = function(self, ids, backAction)
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.ids = ids
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_OneKeyPick, proto_csmsg.CS_QUEST_OneKeyPick, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_OneKeyPick, backAction, proto_csmsg_MSG_ID.MSG_SC_QUEST_OneKeyPick)
end

TaskNetworkCtrl.SC_QUEST_OneKeyPick = function(self, msg)
  -- function num : 0_16 , upvalues : _ENV, cs_WaitNetworkResponse
  local items = {}
  for itemId,num in pairs(msg.rewards) do
    local itemCfg = (ConfigData.item)[itemId]
    if not itemCfg.is_shielded then
      (table.insert)(items, {id = itemId, warehouse_order = itemCfg.warehouse_order, count = num})
    end
  end
  ;
  (table.sort)(items, function(a, b)
    -- function num : 0_16_0
    if a.id >= b.id then
      do return a.warehouse_order ~= b.warehouse_order end
      do return a.warehouse_order < b.warehouse_order end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  local rewardIds = {}
  local rewardNums = {}
  for k,v in pairs(items) do
    (table.insert)(rewardIds, v.id)
    ;
    (table.insert)(rewardNums, v.count)
  end
  if #rewardIds > 0 then
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_16_1 , upvalues : rewardIds, rewardNums, self
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot, false, true)
  end
)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "TaskNetworkCtrl:SC_QUEST_OneKeyPick error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_OneKeyPick)
    end
    if msg.refreshPeriodQuest then
      self:SendQuestPeriodDetail()
    end
  end
end

TaskNetworkCtrl.Reset = function(self)
  -- function num : 0_17
  self.lastSendDataList = {}
end

return TaskNetworkCtrl

