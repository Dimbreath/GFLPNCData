-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskData = class("TaskData")
TaskData.CreateTaskData = function(data, stcData)
    -- function num : 0_0 , upvalues : TaskData
    local taskData = (TaskData.New)()
    taskData:InitTaskData(data, stcData)
    return taskData
end

TaskData.ctor = function(self)
    -- function num : 0_1
end

TaskData.InitTaskData = function(self, data, stcData)
    -- function num : 0_2 , upvalues : _ENV
    self.id = stcData.id
    self.stcData = stcData
    self.taskStepCfg = (ConfigData.taskStep)[self.id]
    self:UpdateTaskData(data)
end

TaskData.UpdateTaskData = function(self, data)
    -- function num : 0_3
    self.steps = data.steps
    self.state = data.state
    self.acceptedTm = data.acceptedTm
    self.expiredTm = data.expiredTm
    self.disappearTm = data.disappearTm
end

TaskData.CheckComplete = function(self)
    -- function num : 0_4 , upvalues : _ENV
    local completeTask = true
    for k, v in pairs(self.steps) do
        if v.schedule < v.aim then completeTask = false end
    end
    return completeTask
end

return TaskData

