-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskController = class("TaskController", ControllerBase)
local TaskEnum = require("Game.Task.TaskEnum")
local cs_MessageCommon = CS.MessageCommon
local TaskData = require("Game.Task.Data.TaskData")
TaskController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.allTaskData = PlayerDataCenter.allTaskData
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Task)
  self.showingPageType = nil
  self.showingActiveType = nil
  self.isFrist = true
  self.isDailyCompleteToRefresh = false
  self.allDailyTaskList = {}
  self.AllWeeklyTaskList = {}
  self.__OnTaskUpdate = BindCallback(self, self.OnTaskUpdate)
  self.__OnTaskDelete = BindCallback(self, self.OnTaskDelete)
  self.__OnTaskCommit = BindCallback(self, self.OnTaskCommit)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  self.isDailyTaskUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyTask)
end

TaskController.SetDailyAndWeeklyLock = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.isDailyTaskUnlock = true
  self:PeriodTaskRedDot()
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win == nil then
    return 
  end
  win:RefreshPages()
end

TaskController.RecvPeriodTaskDetail = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV
  if self.isFrist then
    self:RefreshPeriodData(msg)
    self:PeriodTaskRedDot()
    self.isFrist = false
  else
    self:RefreshPeriodData(msg)
    self:PeriodTaskRedDot()
  end
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win == nil or self.showingPageType == nil then
    return 
  end
  win:OnSelectPage(self.showingPageType)
end

TaskController.RefreshPeriodData = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, TaskEnum
  self.allDailyTaskList = msg.daily
  self.AllWeeklyTaskList = msg.weekly
  for typeId,activeDatas in pairs(ConfigData.active) do
    local pointId = (activeDatas[1]).activeId
    local currPoint = PlayerDataCenter:GetItemCount(pointId)
    local neetPoint = 0
    local stateType = nil
    for _,stcData in ipairs(activeDatas) do
      local msgDatas = nil
      if typeId == (TaskEnum.eTaskPeriodType).DailyTask then
        msgDatas = msg.dailyRewards
      else
        msgDatas = msg.weeklyRewarsd
      end
      local isReceived = msgDatas[stcData.id]
      local periodData = {}
      neetPoint = stcData.activeNum
      if isReceived then
        currPoint = currPoint - neetPoint
        stateType = (TaskEnum.eTaskState).Picked
      else
        if neetPoint <= currPoint then
          currPoint = currPoint - neetPoint
          stateType = (TaskEnum.eTaskState).Completed
        else
          stateType = (TaskEnum.eTaskState).InProgress
        end
      end
      if stateType == nil then
        error("Can\'t confirm period task state")
        return 
      end
      periodData.stateType = stateType
      periodData.stcData = stcData
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R19 in 'UnsetPending'

      ;
      (((self.allTaskData).taskPeriodDatas)[typeId])[stcData.id] = periodData
    end
  end
end

TaskController.PeriodTaskRedDot = function(self)
  -- function num : 0_4 , upvalues : _ENV, TaskEnum
  if not self.isDailyTaskUnlock then
    return 
  end
  for actionTypeId,_ in pairs(ConfigData.active) do
    local datas = self:GetDatas4Peroid(actionTypeId)
    local completeNum = 0
    for key,value in pairs(datas) do
      if value.stateType == (TaskEnum.eTaskState).Completed then
        completeNum = completeNum + 1
      end
    end
    local ok, TaskWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
    if not ok then
      return 
    end
    local TaskType = self:__ActiveType2TaskType(actionTypeId)
    local taskPageNode = TaskWindowNode:GetChild(TaskType)
    local taskPeriodNode = taskPageNode:AddChildWithPath(actionTypeId, RedDotDynPath.TaskPeriodPath)
    taskPeriodNode:SetRedDotCount(completeNum)
  end
end

TaskController.__ActiveType2TaskType = function(self, activeType)
  -- function num : 0_5 , upvalues : _ENV, TaskEnum
  local taskType = nil
  for type,typeId in pairs(TaskEnum.eTaskPeriodType) do
    if activeType == typeId then
      taskType = (TaskEnum.eTaskType)[type]
    end
  end
  return taskType
end

TaskController.CheckExpiredAndUpdate = function(self)
  -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV
  (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.ExpiredMention))
  print(ConfigData:GetTipContent(TipContent.ExpiredMention))
  ;
  (self.network):SendQuestPeriodDetail()
end

TaskController.ShowTaskUI = function(self, selectPageTypeId, openCallback)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Task, function(win)
    -- function num : 0_7_0 , upvalues : _ENV, openCallback, selectPageTypeId
    if win == nil then
      error("can\'t open Task winodw")
      return 
    end
    if openCallback ~= nil then
      openCallback()
    end
    win:RefreshPages()
    if selectPageTypeId ~= nil then
      win:SelectPage(selectPageTypeId)
    end
  end
)
end

TaskController.CloseTaskUI = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win == nil then
    return 
  end
  win:Delete()
  self.showingPageType = nil
  self.showingActiveType = nil
  self.beforTypeId = nil
end

TaskController.GetPageGroupList = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local groupList = (ConfigData.game_config).taskTabSort
  if groupList == nil then
    error("can\'t read task groupList, use default list")
    groupList = {
{4, 5}
, 
{1}
, 
{2}
}
  end
  return groupList
end

TaskController.GetPageName = function(self, index, subIndex)
  -- function num : 0_10 , upvalues : _ENV
  local taskNames = (ConfigData.game_config).taskNames
  if taskNames == nil then
    error("can\'t read taskNames")
    return "", ""
  end
  local name, name_en = nil, nil
  if subIndex == nil then
    local str = (string.split)(ConfigData:GetTipContent((taskNames[index])[1]), "|")
    name = str[1]
    name_en = str[2]
  else
    do
      do
        local str = (string.split)(ConfigData:GetTipContent((taskNames[index])[subIndex]), "|")
        name = str[1]
        name_en = str[2]
        return name, name_en
      end
    end
  end
end

TaskController.GetIndexOfTaskType = function(self, taskTypeId)
  -- function num : 0_11 , upvalues : _ENV
  for index,subTagIds in ipairs(self:GetPageGroupList()) do
    if (table.contain)(subTagIds, taskTypeId) then
      return index
    end
  end
  return nil
end

TaskController.GetTaskTypeName = function(self, taskTypeId)
  -- function num : 0_12
  local index = self:GetIndexOfTaskType(taskTypeId)
  if index == nil then
    return "", ""
  end
  return self:GetPageName(index)
end

TaskController.GetDatas4Task = function(self, typeId)
  -- function num : 0_13 , upvalues : TaskEnum, _ENV, TaskData
  local taskDatas = ((self.allTaskData).normalTaskDatas)[typeId]
  if typeId == (TaskEnum.eTaskType).DailyTask then
    local newTaskDatas = {}
    for id,value in pairs(taskDatas) do
      newTaskDatas[id] = value
    end
    for _,id in ipairs(self.allDailyTaskList) do
      if newTaskDatas[id] == nil then
        local stcData = (ConfigData.task)[id]
        if stcData == nil then
          error("Cant get task cfg, id = " .. tostring(id))
        else
          local taskData = (TaskData.CreateTaskData)({}, stcData)
          taskData.isPicked = true
          newTaskDatas[id] = taskData
        end
      end
    end
    return newTaskDatas, self:GetDatas4Peroid((TaskEnum.eTaskPeriodType).DailyTask)
  else
    do
      do
        if typeId == (TaskEnum.eTaskType).WeeklyTask then
          local newTaskDatas = {}
          for id,value in pairs(taskDatas) do
            newTaskDatas[id] = value
          end
          for _,id in ipairs(self.AllWeeklyTaskList) do
            if newTaskDatas[id] == nil then
              local stcData = (ConfigData.task)[id]
              if stcData == nil then
                error("Cant get task cfg, id = " .. tostring(id))
              else
                local taskData = (TaskData.CreateTaskData)({}, stcData)
                taskData.isPicked = true
                newTaskDatas[id] = taskData
              end
            end
          end
          return newTaskDatas, self:GetDatas4Peroid((TaskEnum.eTaskPeriodType).WeeklyTask)
        end
        return taskDatas
      end
    end
  end
end

TaskController.GetDatas4Peroid = function(self, activeTypeId)
  -- function num : 0_14
  return ((self.allTaskData).taskPeriodDatas)[activeTypeId]
end

TaskController.SelectTask = function(self, typeId)
  -- function num : 0_15 , upvalues : TaskEnum
  self.showingPageType = typeId
  if typeId == (TaskEnum.eTaskType).DailyTask then
    self.showingActiveType = (TaskEnum.eTaskPeriodType).DailyTask
  else
    if typeId == (TaskEnum.eTaskType).WeeklyTask then
      self.showingActiveType = (TaskEnum.eTaskPeriodType).WeeklyTask
    else
      self.showingActiveType = nil
    end
  end
end

TaskController.IsChangeTaskType = function(self, typeId)
  -- function num : 0_16 , upvalues : TaskEnum
  if typeId == (TaskEnum.eTaskType).DailyTask or typeId == (TaskEnum.eTaskType).WeeklyTask then
    typeId = (TaskEnum.eTaskType).DailyTask
  end
  if self.beforTypeId ~= typeId then
    self.beforTypeId = typeId
    return true
  end
  return false
end

TaskController.IsPeriodTaskType = function(self, typeId)
  -- function num : 0_17 , upvalues : TaskEnum
  do return typeId == (TaskEnum.eTaskType).SideTask end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TaskController.SendCommitQuestReward = function(self, taskData)
  -- function num : 0_18 , upvalues : _ENV, cs_MessageCommon
  local containAth = false
  for k,itemId in ipairs((taskData.stcData).rewardIds) do
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
      containAth = true
      break
    end
  end
  do
    if containAth and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
      return 
    end
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    self.isDailyCompleteToRefresh = false
    ;
    (self.network):SendCommitQuest(taskData)
  end
end

TaskController.OnTaskCommit = function(self, stcTask)
  -- function num : 0_19 , upvalues : _ENV, TaskEnum
  local taskWindow = UIManager:GetWindow(UIWindowTypeID.Task)
  local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
  if (taskWindow == nil and homeWindow == nil) or stcTask == nil then
    return 
  end
  local isSector = (self.allTaskData):IsSectorType(stcTask.type)
  if isSector == true then
    return 
  end
  if self.showingPageType == stcTask.type and taskWindow ~= nil then
    taskWindow:OnSelectPage(self.showingPageType)
  end
  if stcTask.type ~= (TaskEnum.eTaskType).MainTask then
    if (stcTask.type == (TaskEnum.eTaskType).SideTask and stcTask.type == (TaskEnum.eTaskType).DailyTask) or stcTask.type == (TaskEnum.eTaskType).WeeklyTask then
      self.isDailyCompleteToRefresh = true
      ;
      (self.network):SendQuestPeriodDetail()
    else
      return 
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_19_0 , upvalues : stcTask, self, _ENV
    if window == nil then
      return 
    end
    window:InitRewardsItem(stcTask.rewardIds, stcTask.rewardNums, self._heroIdSnapShoot)
    local taskStepCfg = (ConfigData.taskStep)[stcTask.id]
    if taskStepCfg ~= nil then
      for stepIndex,stepCfg in ipairs(taskStepCfg) do
        local rewardTips = (string.format)(ConfigData:GetTipContent(360), self:GetTaskTypeName(stcTask.type), (LanguageUtil.GetLocaleText)(stepCfg.intro), stepCfg.finish_value, stepCfg.finish_value)
        window:InitRewardTips(rewardTips)
        do return  end
      end
    end
  end
)
end

TaskController.OnTaskUpdate = function(self, taskData)
  -- function num : 0_20 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win == nil then
    return 
  end
  local isSector = (self.allTaskData):IsSectorType((taskData.stcData).type)
  if isSector == true then
    return 
  end
  self.isDailyCompleteToRefresh = false
  if self.showingPageType == (taskData.stcData).type then
    win:OnSelectPage(self.showingPageType)
  end
end

TaskController.OnTaskDelete = function(self, id)
  -- function num : 0_21 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  local stcTask = (ConfigData.task)[id]
  if win == nil or stcTask == nil then
    return 
  end
  local isSector = (self.allTaskData):IsSectorType(stcTask.type)
  if isSector == true then
    return 
  end
  self.isDailyCompleteToRefresh = false
  if self.showingPageType == stcTask.type then
    win:OnSelectPage(self.showingPageType)
  end
end

TaskController.SendCommitTaskPeriod = function(self, index)
  -- function num : 0_22 , upvalues : _ENV
  if self.showingActiveType == nil then
    error()
    return 
  end
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  ;
  (self.network):SendQuestPeriodRewardPicked(index, self.showingActiveType, function()
    -- function num : 0_22_0 , upvalues : self, _ENV, index
    (self.network):SendQuestPeriodDetail()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_22_0_0 , upvalues : _ENV, self, index
      if window == nil then
        return 
      end
      local activeCfg = ((ConfigData.active)[self.showingActiveType])[index]
      window:InitRewardsItem(activeCfg.rewardIds, activeCfg.rewardNums, self._heroIdSnapShoot)
    end
)
  end
)
end

TaskController.IsDailyCompleteToRefresh = function(self)
  -- function num : 0_23
  if self.isDailyCompleteToRefresh then
    return not self.isFrist
  end
end

TaskController.OnDelete = function(self)
  -- function num : 0_24 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
end

return TaskController

