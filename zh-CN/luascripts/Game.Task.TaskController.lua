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
  self.allDailyTaskList = {}
  self.AllWeeklyTaskList = {}
  self.refreshTime = {}
  self.__OnTaskUpdate = BindCallback(self, self.OnTaskUpdate)
  self.__OnTaskDelete = BindCallback(self, self.OnTaskDelete)
  self.__OnTaskCommit = BindCallback(self, self.OnTaskCommit)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  self.isDailyTaskUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyTask)
  self.checkExpiredTimer = TimerManager:GetTimer(3, (BindCallback(self, self.UpdateDailyAndWeeklyExpired)), nil, false, false)
  ;
  (self.checkExpiredTimer):Start()
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

TaskController.UpdateDailyAndWeeklyExpired = function(self)
  -- function num : 0_2 , upvalues : TaskEnum
  if self.refreshTime == nil then
    return 
  end
  local expiredTime = (self.refreshTime)[(TaskEnum.eTaskPeriodType).DailyTask]
  self:CheckExpiredAndUpdate(expiredTime)
end

TaskController.RecvPeriodTaskDetail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
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
  -- function num : 0_4 , upvalues : _ENV, TaskEnum
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
  do
    if self.refreshTime ~= nil then
      if msg.dailyFreshTm == nil or msg.dailyFreshTm <= 0 or msg.weeklyFreshTm == nil or msg.weeklyFreshTm <= 0 then
        warn("Daily or Weekly RefreshTime is null,please check proto！")
      end
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self.refreshTime)[(TaskEnum.eTaskPeriodType).DailyTask] = msg.dailyFreshTm
      -- DECOMPILER ERROR at PC91: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self.refreshTime)[(TaskEnum.eTaskPeriodType).WeeklyTask] = msg.weeklyFreshTm
    end
  end
end

TaskController.PeriodTaskRedDot = function(self)
  -- function num : 0_5 , upvalues : _ENV, TaskEnum
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
  -- function num : 0_6 , upvalues : _ENV, TaskEnum
  local taskType = nil
  for type,typeId in pairs(TaskEnum.eTaskPeriodType) do
    if activeType == typeId then
      taskType = (TaskEnum.eTaskType)[type]
    end
  end
  return taskType
end

TaskController.CheckExpiredAndUpdate = function(self, expiredTime)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  if expiredTime ~= nil and expiredTime > 0 and expiredTime < PlayerDataCenter.timestamp then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.ExpiredMention))
    ;
    (self.network):SendQuestPeriodDetail()
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_DUNGEON_STATIC_Detail()
    return true
  end
  return false
end

TaskController.ShowTaskUI = function(self, selectPageTypeId, openCallback)
  -- function num : 0_8 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Task, function(win)
    -- function num : 0_8_0 , upvalues : _ENV, openCallback, selectPageTypeId
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
  -- function num : 0_9 , upvalues : _ENV
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
  -- function num : 0_10 , upvalues : _ENV
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
  -- function num : 0_11 , upvalues : _ENV
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

TaskController.GetDatas4Task = function(self, typeId)
  -- function num : 0_12 , upvalues : TaskEnum, _ENV, TaskData
  local taskDatas = ((self.allTaskData).normalTaskDatas)[typeId]
  if typeId == (TaskEnum.eTaskType).DailyTask then
    local newTaskDatas = {}
    for id,value in pairs(taskDatas) do
      newTaskDatas[id] = value
    end
    for _,id in ipairs(self.allDailyTaskList) do
      if newTaskDatas[id] == nil then
        local stcData = (ConfigData.task)[id]
        local taskData = (TaskData.CreateTaskData)({}, stcData)
        taskData.isPicked = true
        newTaskDatas[id] = taskData
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
              local taskData = (TaskData.CreateTaskData)({}, stcData)
              taskData.isPicked = true
              newTaskDatas[id] = taskData
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
  -- function num : 0_13
  return ((self.allTaskData).taskPeriodDatas)[activeTypeId]
end

TaskController.SelectTask = function(self, typeId)
  -- function num : 0_14 , upvalues : TaskEnum
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
  -- function num : 0_15 , upvalues : TaskEnum
  if typeId == (TaskEnum.eTaskType).DailyTask or typeId == (TaskEnum.eTaskType).WeeklyTask then
    typeId = (TaskEnum.eTaskType).DailyTask
  end
  if self.beforTypeId ~= typeId then
    self.beforTypeId = typeId
    return true
  end
  return false
end

TaskController.SendCommitQuestReward = function(self, taskData)
  -- function num : 0_16 , upvalues : _ENV, cs_MessageCommon
  do
    if self.showingActiveType ~= nil and self.refreshTime ~= nil then
      local expiredTime = (self.refreshTime)[self.showingActiveType]
      if self:CheckExpiredAndUpdate(expiredTime) then
        return 
      end
    end
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
      ;
      (self.network):SendCommitQuest(taskData)
    end
  end
end

TaskController.OnTaskCommit = function(self, stcTask)
  -- function num : 0_17 , upvalues : _ENV, TaskEnum
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win == nil or stcTask == nil then
    return 
  end
  local isSector = (self.allTaskData):IsSectorType(stcTask.type)
  if isSector == true then
    return 
  end
  if self.showingPageType == stcTask.type then
    win:OnSelectPage(self.showingPageType)
  end
  if stcTask.type == (TaskEnum.eTaskType).MainTask or stcTask.type == (TaskEnum.eTaskType).SideTask then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_17_0 , upvalues : stcTask
    if window == nil then
      return 
    end
    window:InitRewardsItem(stcTask.rewardIds, stcTask.rewardNums)
  end
)
  else
    if stcTask.type == (TaskEnum.eTaskType).DailyTask or stcTask.type == (TaskEnum.eTaskType).WeeklyTask then
      (self.network):SendQuestPeriodDetail()
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_17_1 , upvalues : stcTask
    if window == nil then
      return 
    end
    window:InitRewardsItem(stcTask.rewardIds, stcTask.rewardNums)
  end
)
    else
      error("stcTask.type error:" .. stcTask.type)
    end
  end
end

TaskController.OnTaskUpdate = function(self, taskData)
  -- function num : 0_18 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win == nil then
    return 
  end
  local isSector = (self.allTaskData):IsSectorType((taskData.stcData).type)
  if isSector == true then
    return 
  end
  if self.showingPageType == (taskData.stcData).type then
    win:OnSelectPage(self.showingPageType)
  end
end

TaskController.OnTaskDelete = function(self, id)
  -- function num : 0_19 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  local stcTask = (ConfigData.task)[id]
  if win == nil or stcTask == nil then
    return 
  end
  local isSector = (self.allTaskData):IsSectorType(stcTask.type)
  if isSector == true then
    return 
  end
  if self.showingPageType == stcTask.type then
    win:OnSelectPage(self.showingPageType)
  end
end

TaskController.SendCommitTaskPeriod = function(self, index)
  -- function num : 0_20 , upvalues : _ENV
  if self.showingActiveType == nil then
    error()
    return 
  end
  do
    if self.refreshTime ~= nil then
      local expiredTime = (self.refreshTime)[self.showingActiveType]
      if self:CheckExpiredAndUpdate(expiredTime) then
        return 
      end
    end
    ;
    (self.network):SendQuestPeriodRewardPicked(index, self.showingActiveType, function()
    -- function num : 0_20_0 , upvalues : self, _ENV, index
    (self.network):SendQuestPeriodDetail()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_20_0_0 , upvalues : _ENV, self, index
      if window == nil then
        return 
      end
      local activeCfg = ((ConfigData.active)[self.showingActiveType])[index]
      window:InitRewardsItem(activeCfg.rewardIds, activeCfg.rewardNums)
    end
)
  end
)
  end
end

TaskController.OnDelete = function(self)
  -- function num : 0_21 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
  if self.checkExpiredTimer ~= nil and not (self.checkExpiredTimer):IsOver() then
    (self.checkExpiredTimer):Stop()
    self.checkExpiredTimer = nil
  end
end

return TaskController

