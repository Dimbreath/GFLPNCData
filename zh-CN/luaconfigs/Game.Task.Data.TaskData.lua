-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskData = class("TaskData")
local TaskEnum = require("Game.Task.TaskEnum")
TaskData.CreateTaskData = function(data, stcData)
  -- function num : 0_0 , upvalues : TaskData
  local taskData = (TaskData.New)()
  taskData:InitTaskData(data, stcData)
  return taskData
end

TaskData.CreatePickedTaskData = function(stcData)
  -- function num : 0_1 , upvalues : TaskData, TaskEnum
  local taskData = (TaskData.New)()
  taskData:InitTaskData(nil, stcData)
  taskData.state = (TaskEnum.eTaskState).Picked
  taskData.schedule = ((taskData.taskStepCfg)[1]).finish_value or 1
  taskData.aim = ((taskData.taskStepCfg)[1]).finish_value or 1
  taskData.acceptedTm = 0
  taskData.expiredTm = 0
  taskData.disappearTm = 0
  return taskData
end

TaskData.ctor = function(self)
  -- function num : 0_2
end

TaskData.InitTaskData = function(self, data, stcData)
  -- function num : 0_3 , upvalues : _ENV
  self.id = stcData.id
  self.stcData = stcData
  self.taskStepCfg = (ConfigData.taskStep)[self.id]
  if data ~= nil then
    self:UpdateTaskData(data)
  end
end

TaskData.UpdateTaskData = function(self, data)
  -- function num : 0_4
  self.state = data.state
  self.acceptedTm = data.acceptedTm
  self.expiredTm = data.expiredTm
  self.disappearTm = data.disappearTm
  self.stepIdx = data.stepIdx
  self.schedule = data.schedule
  self.aim = data.aim
end

TaskData.GetStepCfg = function(self)
  -- function num : 0_5
  return (self.taskStepCfg)[1]
end

TaskData.CheckComplete = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (self.stcData).open_condition ~= nil and (self.stcData).open_condition > 0 and not FunctionUnlockMgr:ValidateUnlock((self.stcData).open_condition) then
    return false
  end
  if self.schedule == nil or self.aim == nil then
    return false
  end
  do return self.aim <= self.schedule end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TaskData.GetTaskProcess = function(self)
  -- function num : 0_7
  return self.schedule, self.aim
end

TaskData.GetTaskFirstStepIntro = function(self)
  -- function num : 0_8 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)(((self.taskStepCfg)[1]).intro)
end

return TaskData

