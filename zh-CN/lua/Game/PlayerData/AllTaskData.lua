local AllTaskData = class("AllTaskData")
local TaskData = require("Game.Task.Data.TaskData")
local TaskEnum = require("Game.Task.TaskEnum")
local skipGuide = (GR.SkipGameGuide)()
local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
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
  self.weeklyChallengeDatas = {}
  self.completedMainTaskDic = {}
  self.achievementDatas = {}
  self.achievementTaskNum = 0
  for k,v in pairs(ConfigData.achievement) do
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

    (self.achievementDatas)[v.task_type] = {}
  end
  self.taskPeriodDatas = {}
  for typeId,stc in pairs(ConfigData.active) do
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R6 in 'UnsetPending'

    (self.taskPeriodDatas)[typeId] = {}
  end
  self.specialTaskDatas = {}
  self.guideTaskDatas = {}
  self.avgTaskDatas = {}
end

AllTaskData.InitAllTaskData = function(self, questGroup)
  -- function num : 0_1 , upvalues : _ENV, skipGuide, TaskData
  self.taskNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  if questGroup.received ~= nil then
    if skipGuide and (questGroup.received)[(ConfigData.buildinConfig).FirstGuideTaskId] ~= nil then
      (questGroup.received)[(ConfigData.buildinConfig).FirstGuideTaskId] = nil
    end
    for taskId,questMsg in pairs(questGroup.received) do
      local stcData = (ConfigData.task)[taskId]
      if stcData == nil then
        error("Cant\'t find taskCfg,id = " .. taskId)
      else
        local taskData = (TaskData.CreateTaskData)(questMsg, stcData)
        self:AddTaskData(taskData)
      end
    end
  end
  do
    self:UpdateAllTaskData()
  end
end

AllTaskData.InitCompletedMainTask = function(self, mainLineQuest)
  -- function num : 0_2
  self.completedMainTaskDic = mainLineQuest
end

AllTaskData.RecordCompletedMainTask = function(self, taskId)
  -- function num : 0_3 , upvalues : _ENV, CheckerTypeId
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.completedMainTaskDic)[taskId] = true
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.CompleteTask)
end

AllTaskData.AddTaskData = function(self, taskData)
  -- function num : 0_4 , upvalues : _ENV, TaskEnum
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self.taskDatas)[taskData.id] = taskData
  local stcData = taskData.stcData
  if stcData.isShow then
    if self:IsSectorType(stcData.type) then
      if (self.sectorTaskDatas)[stcData.type] == nil then
        error((string.format)("sectorCfg.achievement(%s) is nil", stcData.type))
        return 
      end
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.sectorTaskDatas)[stcData.type])[taskData.id] = taskData
    else
      if self:IsAchivType(stcData.type) then
        if (self.achievementDatas)[stcData.type] == nil then
          error((string.format)("achievementDatas(%s) is nil", stcData.type))
          return 
        end
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.achievementDatas)[stcData.type])[taskData.id] = taskData
        self.achievementTaskNum = self.achievementTaskNum + 1
      else
        if self:IsNormalType(stcData.type) then
          if (self.normalTaskDatas)[stcData.type] == nil then
            error((string.format)("normalTaskDatas(%s) is nil", stcData.type))
            return 
          end
          -- DECOMPILER ERROR at PC80: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((self.normalTaskDatas)[stcData.type])[taskData.id] = taskData
        else
          -- DECOMPILER ERROR at PC89: Confused about usage of register: R3 in 'UnsetPending'

          if self:IsWeeklyChallengeType(stcData.type) then
            (self.weeklyChallengeDatas)[taskData.id] = taskData
          end
        end
      end
    end
  end
  if #stcData.guide_id > 0 then
    (table.insert)(self.guideTaskDatas, taskData)
  end
  if stcData.type == (TaskEnum.eTaskType).AvgTask then
    (table.insert)(self.avgTaskDatas, taskData)
  else
    if stcData.type == (TaskEnum.eTaskType).SpecialTask then
      (table.insert)(self.specialTaskDatas, taskData)
    end
  end
end

AllTaskData.RemoveTaskData = function(self, taskData)
  -- function num : 0_5 , upvalues : _ENV, TaskEnum
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self.taskDatas)[taskData.id] = nil
  local stcData = taskData.stcData
  if #stcData.guide_id > 0 then
    (table.removebyvalue)(self.guideTaskDatas, taskData)
  end
  if stcData.type == (TaskEnum.eTaskType).AvgTask then
    (table.removebyvalue)(self.avgTaskDatas, taskData)
  else
    if stcData.type == (TaskEnum.eTaskType).SpecialTask then
      (table.removebyvalue)(self.specialTaskDatas, taskData)
    end
  end
  if stcData.isShow then
    if self:IsSectorType(stcData.type) then
      if (self.sectorTaskDatas)[stcData.type] == nil then
        error((string.format)("sectorCfg.achievement(%s) is nil", stcData.type))
        return 
      end
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.sectorTaskDatas)[stcData.type])[taskData.id] = nil
    else
      if self:IsAchivType(stcData.type) then
        if (self.achievementDatas)[stcData.type] == nil then
          error((string.format)("achievementDatas(%s) is nil", stcData.type))
          return 
        end
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.achievementDatas)[stcData.type])[taskData.id] = nil
        self.achievementTaskNum = self.achievementTaskNum - 1
      else
        if self:IsNormalType(stcData.type) then
          if (self.normalTaskDatas)[stcData.type] == nil then
            error((string.format)("normalTaskDatas(%s) is nil", stcData.type))
            return 
          end
          -- DECOMPILER ERROR at PC110: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((self.normalTaskDatas)[stcData.type])[taskData.id] = nil
        else
          -- DECOMPILER ERROR at PC119: Confused about usage of register: R3 in 'UnsetPending'

          if self:IsWeeklyChallengeType(stcData.type) then
            (self.weeklyChallengeDatas)[taskData.id] = nil
          end
        end
      end
    end
    MsgCenter:Broadcast(eMsgEventId.TaskDelete, taskData.id)
  end
end

AllTaskData.TryAutoCompleteHidenTask = function(self, taskData)
  -- function num : 0_6
  if (taskData.stcData).isShow == false and taskData:CheckComplete() then
    (self.taskNetworkCtrl):SendCommitQuest(taskData)
  end
end

AllTaskData.UpdateAllTaskData = function(self)
  -- function num : 0_7
  self:__ExpireData()
  self:InitNormalTaskRedDot()
  self:InitSectorTaskRedDot()
  self:InitAchivLevelRedDot()
  self:InitWeeklyChallengeTaskRedDot()
  self:InitGuideTaksData()
end

AllTaskData.InitGuideTaksData = function(self)
  -- function num : 0_8 , upvalues : _ENV
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
  -- function num : 0_9 , upvalues : _ENV, TaskEnum
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
        if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi) then
          taskUnitNode:SetRedDotCount(completeCount)
        else
          taskUnitNode:SetRedDotCount(0)
        end
      end
      do
        -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

AllTaskData.InitSectorTaskRedDot = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for _,id in ipairs((ConfigData.sector).id_sort_list) do
    local sectorCfg = (ConfigData.sector)[id]
    local sectorId = sectorCfg.id
    RedDotController:AddRedDotNodeWithPath(RedDotDynPath.SectorItemPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId)
    local taskNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.SectorItemTasksPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId, RedDotStaticTypeId.SectorTaskBtn, RedDotStaticTypeId.SectorTasks)
    local count = 0
    for k,v in pairs((self.sectorTaskDatas)[sectorCfg.achievement]) do
      if v:CheckComplete() then
        count = count + 1
      end
    end
    taskNode:SetRedDotCount(count)
  end
end

AllTaskData.InitAchivLevelRedDot = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local isAchiUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  if isAchiUnlock then
    local latestFinishAchi = nil
    for taskType,v in pairs(self.achievementDatas) do
      local pageNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.AchivTaskPagePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelPage, taskType)
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

AllTaskData.InitWeeklyChallengeTaskRedDot = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge)
  if not isUnlock then
    return 
  end
  local reddot = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.WeeklyChallengeTask)
  self:UpdateWeeklyChallengeRedDot()
end

AllTaskData.RefreshTaskDataArr = function(self, taskDataArr)
  -- function num : 0_13 , upvalues : _ENV
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
  -- function num : 0_14 , upvalues : _ENV
  self.__waitExpiredTimer = nil
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
    -- function num : 0_14_0
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
              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      self:RemoveTaskData(taskData)
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
    -- function num : 0_14_1
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
              self:RemoveTaskData(taskData)
              -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC115: LeaveBlock: unexpected jumping out IF_STMT

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
          if self.__waitExpiredTimerId ~= nil then
            TimerManager:StopTimer(self.__waitExpiredTimerId)
            self.__waitExpiredTimerId = nil
          end
          if waitDuration ~= nil then
            local delay = (math.ceil)(waitDuration)
            self.__waitExpiredTimerId = TimerManager:StartTimer(delay, self.__ExpireData, self, true, false, true)
          end
        end
      end
    end
  end
end

AllTaskData.IsSectorType = function(self, type)
  -- function num : 0_15 , upvalues : TaskEnum, _ENV
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
  -- function num : 0_16 , upvalues : TaskEnum
  do return (TaskEnum.eTaskType).MainTask <= type and type <= (TaskEnum.eTaskType).WeeklyTask end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AllTaskData.IsAchivType = function(self, type)
  -- function num : 0_17 , upvalues : TaskEnum
  local isAchivType = (TaskEnum.eTaskType).Achievement <= type and type < self.__achivTypeCeiling
  do return isAchivType end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AllTaskData.IsWeeklyChallengeType = function(self, type)
  -- function num : 0_18 , upvalues : TaskEnum
  do return type == (TaskEnum.eTaskType).WeeklyChallengeTask end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AllTaskData.AllTaskOnTaskUpdate = function(self, taskData)
  -- function num : 0_19 , upvalues : _ENV, NoticeData, JumpManager, TaskEnum
  local taskType = (taskData.stcData).type
  local isSector, sectorId = self:IsSectorType(taskType)
  if isSector then
    self:__UpdateSectorTaskRedDotCount(taskType, sectorId)
    if taskData:CheckComplete() and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorTask) then
      NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).SectorTask, nil, {(LanguageUtil.GetLocaleText)((taskData.stcData).name)}, nil))
    end
  else
    if self:IsAchivType(taskType) then
      self:__UpdateAchivTaskRedDotCount(taskType)
      if taskData:CheckComplete() then
        NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).AchievementAchieved, {jumpType = (JumpManager.eJumpTarget).Achieve4System, argList = nil}, {taskData:GetTaskFirstStepIntro()}, nil))
      end
    else
      if taskType == (TaskEnum.eTaskType).heroTrainTask then
        self:__UpdateHeroTaskRedDotCount(taskType)
      else
        if self:IsWeeklyChallengeType(type) then
          self:UpdateWeeklyChallengeRedDot()
        end
      end
    end
  end
end

AllTaskData.AllTaskOnTaskCommit = function(self, stcTask)
  -- function num : 0_20 , upvalues : TaskEnum
  local taskType = stcTask.type
  local isSector, sectorId = self:IsSectorType(taskType)
  if isSector then
    self:__UpdateSectorTaskRedDotCount(taskType, sectorId)
  else
    if self:IsAchivType(taskType) then
      self:__UpdateAchivTaskRedDotCount(taskType)
    else
      if taskType == (TaskEnum.eTaskType).heroTrainTask then
        self:__UpdateHeroTaskRedDotCount(taskType)
      else
        if self:IsWeeklyChallengeType(taskType) then
          self:UpdateWeeklyChallengeRedDot()
        end
      end
    end
  end
end

AllTaskData.__UpdateSectorTaskRedDotCount = function(self, taskType, sectorId)
  -- function num : 0_21 , upvalues : _ENV
  if sectorId == nil then
    return 
  end
  local OK, taskNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId, RedDotStaticTypeId.SectorTaskBtn, RedDotStaticTypeId.SectorTasks)
  if OK then
    local count = 0
    for k,v in pairs((self.sectorTaskDatas)[taskType]) do
      if v:CheckComplete() then
        count = count + 1
      end
    end
    taskNode:SetRedDotCount(count)
  end
end

AllTaskData.__UpdateAchivTaskRedDotCount = function(self, taskType)
  -- function num : 0_22 , upvalues : _ENV
  local isAchiUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  if isAchiUnlock then
    local latestFinishAchi = nil
    local ok, pageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelPage, taskType)
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

AllTaskData.__UpdateHeroTaskRedDotCount = function(self, taskType)
  -- function num : 0_23 , upvalues : _ENV
  local isTrainTaskUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TrainingPlan)
  if isTrainTaskUnlock then
    local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
    if not ok then
      return 
    end
    for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
      local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
      local heroTaskNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroTask, RedDotDynPath.HeroCardHeroTaskPath)
      if heroData:IsHaveCompletedHeroTask() then
        heroTaskNode:SetRedDotCount(1)
      else
        heroTaskNode:SetRedDotCount(0)
      end
    end
  end
end

AllTaskData.UpdateWeeklyChallengeRedDot = function(self)
  -- function num : 0_24 , upvalues : _ENV, TaskEnum
  local ok, reddot = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.WeeklyChallengeTask)
  if not ok then
    return 
  end
  local num = 0
  for _,data in pairs(self.weeklyChallengeDatas) do
    if data:CheckComplete() then
      num = num + 1
    end
  end
  for _,periodData in ipairs((self.taskPeriodDatas)[(TaskEnum.eTaskPeriodType).WeeklyChallengeTask]) do
    if periodData.stateType == (TaskEnum.eTaskState).Completed then
      num = num + 1
    end
  end
  reddot:SetRedDotCount(num)
end

AllTaskData.IsMainTaskComplete = function(self, taskId)
  -- function num : 0_25 , upvalues : _ENV, TaskEnum
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
  -- function num : 0_26 , upvalues : _ENV, TaskEnum
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
  -- function num : 0_27 , upvalues : _ENV, TaskEnum
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

