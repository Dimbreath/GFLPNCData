-- params : ...
-- function num : 0 , upvalues : _ENV
local AllTaskData = class("AllTaskData")
local TaskData = require("Game.Task.Data.TaskData")
local TaskEnum = require("Game.Task.TaskEnum")
local skipGuide = (GR.SkipGameGuide)()
local HomeEnum = require("Game.Home.HomeEnum")
AllTaskData.ctor = function(self)
  -- function num : 0_0 , upvalues : TaskEnum, _ENV
  self.__sectorTaskTypeCeiling = (TaskEnum.eTaskType).SectorTask + 100
  self.__achivTypeCeiling = (TaskEnum.eTaskType).Achievement + 100
  self.taskDatas = {}
  self.waitExpiredDatas = {}
  self.waitDisappearDatas = {}
  self.__waitExpiredTimer = nil
  self.sectorTaskDatas = {}
  for _,id in ipairs((ConfigData.sector).id_sort_list) do
    local sectorCfg = (ConfigData.sector)[id]
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.sectorTaskDatas)[sectorCfg.achievement] = {}
  end
  self.normalTaskDatas = {}
  for k,stc in pairs(ConfigData.task) do
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

    if self:IsNormalType(stc.type) then
      (self.normalTaskDatas)[stc.type] = {}
    end
  end
  self.completedMainTaskDic = {}
  self.achievementDatas = {}
  self.achievementTaskNum = 0
  for k,v in pairs(ConfigData.achievement) do
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R6 in 'UnsetPending'

    (self.achievementDatas)[v.task_type] = {}
  end
  self.taskPeriodDatas = {}
  for typeId,stc in pairs(ConfigData.active) do
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R6 in 'UnsetPending'

    (self.taskPeriodDatas)[typeId] = {}
  end
  self.__OnTaskUpdate = BindCallback(self, self.OnTaskUpdate)
  self.__OnTaskCommit = BindCallback(self, self.OnTaskCommit)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
end

AllTaskData.InitAllTaskData = function(self, questGroup)
  -- function num : 0_1 , upvalues : _ENV, skipGuide, TaskData
  self.taskNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  if skipGuide and (questGroup.received)[30001] ~= nil then
    (questGroup.received)[30001] = nil
  end
  for k,v in pairs(questGroup.received) do
    local stcData = (ConfigData.task)[k]
    if stcData == nil then
      error("Cant\'t find taskCfg,id = " .. k)
    else
      local taskData = (TaskData.CreateTaskData)(v, stcData)
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.taskDatas)[k] = taskData
    end
  end
  self:UpdateAllTaskData()
end

AllTaskData.InitCompletedMainTask = function(self, mainLineQuest)
  -- function num : 0_2
  self.completedMainTaskDic = mainLineQuest
end

AllTaskData.RecordCompletedMainTask = function(self, taskId)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.completedMainTaskDic)[taskId] = true
end

AllTaskData.UpdateAllTaskData = function(self)
  -- function num : 0_4 , upvalues : _ENV, TaskEnum
  self:__ExpireData()
  for k,v in pairs(self.sectorTaskDatas) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R6 in 'UnsetPending'

    (self.sectorTaskDatas)[k] = {}
  end
  for k,v in pairs(self.normalTaskDatas) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

    (self.normalTaskDatas)[k] = {}
  end
  self.achievementTaskNum = 0
  for k,v in pairs(self.achievementDatas) do
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

    (self.achievementDatas)[k] = {}
  end
  self.guideTaskDatas = {}
  self.avgTaskDatas = {}
  self.specialTaskDatas = {}
  for k,v in pairs(self.taskDatas) do
    local stcData = v.stcData
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R7 in 'UnsetPending'

    if stcData.isShow then
      if self:IsSectorType(stcData.type) then
        ((self.sectorTaskDatas)[stcData.type])[k] = v
      else
        if self:IsAchivType(stcData.type) then
          (table.insert)((self.achievementDatas)[stcData.type], v)
          self.achievementTaskNum = self.achievementTaskNum + 1
        else
          -- DECOMPILER ERROR at PC78: Confused about usage of register: R7 in 'UnsetPending'

          if self:IsNormalType(stcData.type) then
            ((self.normalTaskDatas)[stcData.type])[k] = v
          end
        end
      end
    else
      if v:CheckComplete() then
        (self.taskNetworkCtrl):SendCommitQuest(v)
      end
    end
    if #stcData.guide_id > 0 then
      (table.insert)(self.guideTaskDatas, v)
    end
    if stcData.type == (TaskEnum.eTaskType).AvgTask then
      (table.insert)(self.avgTaskDatas, v)
    end
    if stcData.type == (TaskEnum.eTaskType).SpecialTask then
      (table.insert)(self.specialTaskDatas, v)
    end
  end
  self:InitNormalTaskRedDot()
  self:InitSectorTaskRedDot()
  self:InitAchivLevelRedDot()
  self:InitGuideTaksData()
end

AllTaskData.InitGuideTaksData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  if saveUserData ~= nil and saveUserData.guideData ~= nil and (table.count)((saveUserData.guideData).skipGuideTask) > 0 then
    local skipGuideTask = {}
    for taskId,_ in pairs((saveUserData.guideData).skipGuideTask) do
      if (self.taskDatas)[taskId] ~= nil then
        skipGuideTask[taskId] = true
      end
    end
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (saveUserData.guideData).skipGuideTask = skipGuideTask
  end
end

AllTaskData.InitNormalTaskRedDot = function(self)
  -- function num : 0_6 , upvalues : _ENV, TaskEnum
  local ok, TaskWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
  if not ok then
    return 
  end
  for TaskType,arr in pairs(self.normalTaskDatas) do
    do
      if (TaskEnum.eTaskType).DailyTask == TaskType or (TaskEnum.eTaskType).WeeklyTask == TaskType then
        local isDailyTaskUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyTask)
      end
      if isDailyTaskUnlock then
        local taskPageNode = TaskWindowNode:AddChildWithPath(TaskType, RedDotDynPath.TaskPagePath)
        local taskUnitNode = taskPageNode:AddChild(RedDotStaticTypeId.TaskUnit)
        local completeCount = self:RefreshTaskDataArr(arr)
        taskUnitNode:SetRedDotCount(completeCount)
      end
      do
        -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

AllTaskData.InitSectorTaskRedDot = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for _,id in ipairs((ConfigData.sector).id_sort_list) do
    local sectorCfg = (ConfigData.sector)[id]
    local sectorId = sectorCfg.id
    RedDotController:AddRedDotNodeWithPath(RedDotDynPath.SectorItemPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId)
  end
end

AllTaskData.InitAchivLevelRedDot = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local isAchiUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  if isAchiUnlock then
    local latestFinishAchi = nil
    for taskType,v in pairs(self.achievementDatas) do
      local pageNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.AchivTaskPagePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelPage, taskType)
      local count = 0
      for k,v in pairs(v) do
        if v:CheckComplete() then
          count = count + 1
          if latestFinishAchi == nil then
            latestFinishAchi = v
          end
        end
      end
      pageNode:SetRedDotCount(count)
    end
  end
end

AllTaskData.RefreshTaskDataArr = function(self, taskDataArr)
  -- function num : 0_9 , upvalues : _ENV
  local count = 0
  if taskDataArr == nil then
    return 
  end
  for _,taskData in pairs(taskDataArr) do
    if taskData:CheckComplete() then
      count = count + 1
    end
  end
  return count
end

AllTaskData.__ExpireData = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.waitExpiredDatas = {}
  self.waitDisappearDatas = {}
  for k,v in pairs(self.taskDatas) do
    local stcData = v.stcData
    if stcData.isShow then
      if v.expiredTm ~= 0 then
        (table.insert)(self.waitExpiredDatas, v)
      else
        if v.disappearTm ~= 0 then
          (table.insert)(self.waitDisappearDatas, v)
        end
      end
    end
  end
  local timeStamp = PlayerDataCenter.timestamp
  ;
  (table.sort)(self.waitExpiredDatas, function(a, b)
    -- function num : 0_10_0
    do return a.expiredTm < b.expiredTm end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  while 1 do
    while 1 do
      while 1 do
        if #self.waitExpiredDatas > 0 then
          local taskData = (self.waitExpiredDatas)[1]
          if taskData.expiredTm <= timeStamp then
            (table.remove)(self.waitExpiredDatas, 1)
            if (taskData.stcData).end_handle ~= nil and (taskData.stcData).end_handle > 0 then
              taskData.disappearTm = taskData.expiredTm + (taskData.stcData).end_handle
              taskData.expiredTm = 0
              ;
              (table.insert)(self.waitDisappearDatas, taskData)
              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      -- DECOMPILER ERROR at PC74: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self.taskDatas)[taskData.id] = nil
      MsgCenter:Broadcast(eMsgEventId.TaskDelete, taskData.id)
    end
    break
  end
  do
    local waitDuration = nil
    do
      if #self.waitExpiredDatas > 0 then
        local duration = ((self.waitExpiredDatas)[1]).expiredTm - timeStamp
        if waitDuration == nil or duration < waitDuration then
          waitDuration = duration
        end
      end
      ;
      (table.sort)(self.waitDisappearDatas, function(a, b)
    -- function num : 0_10_1
    do return a.disappearTm < b.disappearTm end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      while 1 do
        while 1 do
          if #self.waitDisappearDatas > 0 then
            local taskData = (self.waitDisappearDatas)[1]
            if taskData.disappearTm <= timeStamp then
              (table.remove)(self.waitDisappearDatas, 1)
              -- DECOMPILER ERROR at PC119: Confused about usage of register: R4 in 'UnsetPending'

              ;
              (self.taskDatas)[taskData.id] = nil
              MsgCenter:Broadcast(eMsgEventId.TaskDelete, taskData.id)
              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
        break
      end
      do
        do
          if #self.waitDisappearDatas > 0 then
            local duration = ((self.waitDisappearDatas)[1]).disappearTm - timeStamp
            if waitDuration == nil or duration < waitDuration then
              waitDuration = duration
            end
          end
          if self.__waitExpiredTimer ~= nil then
            (self.__waitExpiredTimer):Stop()
            self.__waitExpiredTimer = nil
          end
          if waitDuration ~= nil then
            local delay = (math.ceil)(waitDuration)
            self.__waitExpiredTimer = (TimerManager:GetTimer(delay, self.__ExpireData, self, true, false, true)):Start()
          end
        end
      end
    end
  end
end

AllTaskData.IsSectorType = function(self, type)
  -- function num : 0_11 , upvalues : TaskEnum, _ENV
  local isSectorType = (TaskEnum.eTaskType).SectorTask <= type and type < self.__sectorTaskTypeCeiling
  local sectorId = nil
  if isSectorType then
    for _,id in ipairs((ConfigData.sector).id_sort_list) do
      local sectorCfg = (ConfigData.sector)[id]
      if type == sectorCfg.achievement then
        sectorId = sectorCfg.id
        break
      end
    end
  end
  do return isSectorType, sectorId end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

AllTaskData.IsNormalType = function(self, type)
  -- function num : 0_12 , upvalues : TaskEnum
  do return (TaskEnum.eTaskType).MainTask <= type and type <= (TaskEnum.eTaskType).WeeklyTask end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AllTaskData.IsAchivType = function(self, type)
  -- function num : 0_13 , upvalues : TaskEnum
  local isAchivType = (TaskEnum.eTaskType).Achievement <= type and type < self.__achivTypeCeiling
  do return isAchivType end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AllTaskData.OnTaskUpdate = function(self, taskData)
  -- function num : 0_14 , upvalues : _ENV, HomeEnum
  local taskType = (taskData.stcData).type
  local isSector, sectorId = self:IsSectorType(taskType)
  if isSector then
    self:__UpdateSectorTaskRedDotCount(taskType, sectorId)
  else
    if self:IsAchivType(taskType) then
      self:__UpdateAchivTaskRedDotCount(taskType)
      if taskData:CheckComplete() then
        MsgCenter:Broadcast(eMsgEventId.NewNotice, (HomeEnum.eNoticeType).Achievement, PlayerDataCenter.timestamp, nil)
      end
    end
  end
end

AllTaskData.OnTaskCommit = function(self, stcTask)
  -- function num : 0_15
  local taskType = stcTask.type
  local isSector, sectorId = self:IsSectorType(taskType)
  if isSector then
    self:__UpdateSectorTaskRedDotCount(taskType, sectorId)
  else
    if self:IsAchivType(taskType) then
      self:__UpdateAchivTaskRedDotCount(taskType)
    end
  end
end

AllTaskData.__UpdateSectorTaskRedDotCount = function(self, taskType, sectorId)
  -- function num : 0_16
end

AllTaskData.__UpdateAchivTaskRedDotCount = function(self, taskType)
  -- function num : 0_17 , upvalues : _ENV
  local isAchiUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  if isAchiUnlock then
    local latestFinishAchi = nil
    local ok, pageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelPage, taskType)
    if ok then
      local count = 0
      for k,v in pairs((self.achievementDatas)[taskType]) do
        if v:CheckComplete() then
          count = count + 1
          if latestFinishAchi == nil then
            latestFinishAchi = v
          end
        end
      end
      pageNode:SetRedDotCount(count)
    end
  end
end

AllTaskData.IsMainTaskComplete = function(self, taskId)
  -- function num : 0_18 , upvalues : _ENV, TaskEnum
  local taskCfg = (ConfigData.task)[taskId]
  if taskCfg == nil then
    error("Can\'t find task，taskId = " .. taskId)
    return true
  end
  if taskCfg.type ~= (TaskEnum.eTaskType).MainTask then
    error("The task is not mainTask，taskId = " .. taskId)
    return true
  end
  do return (self.completedMainTaskDic)[taskId] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AllTaskData.GetTaskData4Home = function(self)
  -- function num : 0_19 , upvalues : _ENV, TaskEnum
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
  if node:GetRedDotCount() > 0 then
    local taskData, isComplete = self:__GetMainTask4Home()
    if isComplete then
      return taskData, true, false
    end
    for _,taskType in pairs(TaskEnum.HomeTaskRewardOthers) do
      for _,tmpTaskData in pairs((self.normalTaskDatas)[taskType]) do
        local tmpComplete = tmpTaskData:CheckComplete()
        if tmpComplete then
          return tmpTaskData, true, false
        end
      end
    end
    for typeId,datas in pairs(self.taskPeriodDatas) do
      for _,peroidData in pairs(datas) do
        if peroidData.stateType == (TaskEnum.eTaskState).Completed then
          return peroidData, true, true
        end
      end
    end
  end
  do
    return self:__GetMainTask4Home(), false
  end
end

AllTaskData.__GetMainTask4Home = function(self)
  -- function num : 0_20 , upvalues : _ENV, TaskEnum
  local taskData = nil
  local isComplete = false
  for _,tmpTaskData in pairs((self.normalTaskDatas)[(TaskEnum.eTaskType).MainTask]) do
    local tmpComplete = tmpTaskData:CheckComplete()
    if tmpComplete and not isComplete then
      taskData = tmpTaskData
      isComplete = true
    else
      if isComplete == tmpComplete and (taskData == nil or tmpTaskData.id < taskData.id) then
        taskData = tmpTaskData
        isComplete = tmpComplete
      end
    end
  end
  return taskData, isComplete
end

return AllTaskData

