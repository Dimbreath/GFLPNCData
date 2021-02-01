-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityInfo = class("ActivityInfo")
local ActivityEnum = require("Game.Activity.ActivityEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_playerData = (CS.PlayerDataCenter).Instance
local TaskData = require("Game.Task.Data.TaskData")
ActivityInfo.ctor = function(self)
  -- function num : 0_0
  self.taskDic = {}
end

ActivityInfo.CreateData = function(id)
  -- function num : 0_1 , upvalues : ActivityInfo, _ENV
  local res = (ActivityInfo.New)()
  res.id = id
  res.cfg = (ConfigData.rookie_star)[id]
  res.startTime = ((res.cfg).pre_para1)[1]
  res.endTime = ((res.cfg).pre_para2)[1]
  res:CollectTaskIds()
  res.curStageId = 1
  res:RefreshStage()
  return res
end

ActivityInfo.CollectTaskIds = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.taskDic = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.taskDic)[1] = {}
  local mainTaskId = (((self.cfg).phase)[1]).task
  local systemOpenCfg = (ConfigData.system_open)[(self.cfg).system_id]
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.taskDic)[1]).mainTaskId = mainTaskId
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.taskDic)[1]).childTaskIds = {}
  for i,v in ipairs(systemOpenCfg.trigger_para1) do
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R8 in 'UnsetPending'

    if v ~= mainTaskId then
      (((self.taskDic)[1]).childTaskIds)[v] = true
    end
  end
  for i = 2, #(self.cfg).phase do
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'

    (self.taskDic)[i] = {}
    local mainTaskId = (((self.cfg).phase)[i]).task
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.taskDic)[i]).mainTaskId = mainTaskId
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.taskDic)[i]).childTaskIds = {}
    local lastMainTaskId = (((self.cfg).phase)[i - 1]).task
    for k,v in ipairs(((ConfigData.task)[lastMainTaskId]).next_task) do
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R14 in 'UnsetPending'

      if v ~= mainTaskId then
        (((self.taskDic)[i]).childTaskIds)[v] = true
      end
    end
  end
end

ActivityInfo.RefreshStage = function(self)
  -- function num : 0_3 , upvalues : cs_playerData, ActivityEnum, _ENV, TaskEnum
  if self.curStageId == nil then
    return 
  end
  local dayCount = (cs_playerData.timestamp - self.startTime) / 86400
  for i = self.curStageId + 1, #(self.cfg).phase do
    local phase = ((self.cfg).phase)[i]
    if phase.type == (ActivityEnum.eActivityStageOpen).LastEnd then
      local lastPhase = ((self.cfg).phase)[phase.para]
      local lastMainTask = ((PlayerDataCenter.allTaskData).taskDatas)[lastPhase.task]
      if lastMainTask == nil or lastMainTask.state == (TaskEnum.eTaskState).Picked then
        self.curStageId = i
      else
        break
      end
    else
      do
        do
          if phase.para <= dayCount then
            self.curStageId = i
          end
          -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if self.curStageId == #(self.cfg).phase then
    local mainTask = ((PlayerDataCenter.allTaskData).taskDatas)[(((self.cfg).phase)[self.curStageId]).task]
    if mainTask == nil or mainTask.state == (TaskEnum.eTaskState).Picked then
      self.curStageId = nil
    end
    return 
  end
end

ActivityInfo.IsFinish = function(self)
  -- function num : 0_4
  do return self.curStageId == nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityInfo.IsOpen = function(self)
  -- function num : 0_5 , upvalues : ActivityEnum
  do return self:GetState() == (ActivityEnum.eActivityState).Open end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityInfo.ContainsTask = function(self, taskId, isAllStage)
  -- function num : 0_6
  if not isAllStage then
    isAllStage = false
  end
  if not isAllStage or not #(self.cfg).phase then
    local max = self.curStageId
  end
  for i = 1, max do
    local item = (self.taskDic)[i]
    if taskId == item.mainTaskId or (item.childTaskIds)[taskId] ~= nil then
      return true
    end
  end
  return false
end

ActivityInfo.GetState = function(self)
  -- function num : 0_7 , upvalues : cs_playerData, ActivityEnum
  local timestamp = cs_playerData.timestamp
  if self.startTime > 0 and timestamp < self.startTime then
    return (ActivityEnum.eActivityState).NotOpen
  end
  if self.endTime > 0 and self.endTime < timestamp then
    return (ActivityEnum.eActivityState).End
  end
  return (ActivityEnum.eActivityState).Open
end

ActivityInfo.GetTasks = function(self, stageId, isJustMainTask, ignoreNullData)
  -- function num : 0_8 , upvalues : _ENV, TaskData, TaskEnum
  CreatePickedTGask = function(id)
    -- function num : 0_8_0 , upvalues : _ENV, TaskData, TaskEnum
    local stcData = (ConfigData.task)[id]
    do
      if stcData ~= nil then
        local taskData = (TaskData.CreateTaskData)({}, stcData)
        taskData.state = (TaskEnum.eTaskState).Picked
        taskData.steps = {}
        -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (taskData.steps)[1] = {}
        -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((taskData.steps)[1]).schedule = (taskData.taskStepCfg).finish_value or 1
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((taskData.steps)[1]).aim = (taskData.taskStepCfg).finish_value or 1
        return taskData
      end
      return nil
    end
  end

  if not stageId then
    stageId = self.curStageId
  end
  if not isJustMainTask then
    isJustMainTask = false
  end
  if not ignoreNullData then
    ignoreNullData = false
  end
  if stageId == nil or #(self.cfg).phase < stageId then
    return 
  end
  local mainTaskId = ((self.taskDic)[stageId]).mainTaskId
  local mainTask = ((PlayerDataCenter.allTaskData).taskDatas)[mainTaskId]
  if mainTask == nil and not ignoreNullData then
    mainTask = CreatePickedTGask(mainTaskId)
  end
  if isJustMainTask then
    return mainTask
  end
  local childTasks = ((self.taskDic)[stageId]).childTaskIds
  local tasks = {}
  for k,_ in pairs(childTasks) do
    local task = ((PlayerDataCenter.allTaskData).taskDatas)[k]
    if task == nil and not ignoreNullData then
      task = CreatePickedTGask(k)
    end
    ;
    (table.insert)(tasks, task)
  end
  return mainTask, tasks
end

return ActivityInfo

