-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityStarUpData = class("ActivityStarUpData")
local ActivityStarUpEnum = require("Game.ActivityStarUp.ActivityStarUpEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_playerData = (CS.PlayerDataCenter).Instance
local TaskData = require("Game.Task.Data.TaskData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
ActivityStarUpData.InitStarUp = function(self, rookieStarCfg)
  -- function num : 0_0
  self.id = rookieStarCfg.id
  self.cfg = rookieStarCfg
  self.startTime = ((self.cfg).pre_para1)[1]
  self:CollectTaskIds()
  self.curStageId = 1
  self:RefreshStage()
end

ActivityStarUpData.CollectTaskIds = function(self)
  -- function num : 0_1 , upvalues : _ENV
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

ActivityStarUpData.RefreshStage = function(self)
  -- function num : 0_2 , upvalues : cs_playerData, ActivityStarUpEnum, _ENV, TaskEnum, ActivityFrameEnum
  if self.curStageId == nil then
    return 
  end
  local dayCount = (cs_playerData.timestamp - self.startTime) / 86400
  for i = self.curStageId + 1, #(self.cfg).phase do
    local phase = ((self.cfg).phase)[i]
    if phase.type == (ActivityStarUpEnum.eActivityStageOpen).LastEnd then
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
  do
    if self.curStageId == #(self.cfg).phase then
      local mainTask = ((PlayerDataCenter.allTaskData).taskDatas)[(((self.cfg).phase)[self.curStageId]).task]
      if mainTask == nil or mainTask.state == (TaskEnum.eTaskState).Picked then
        self.curStageId = nil
      end
    end
    self:UpdateStarUpRedddot()
    if self.curStageId == nil then
      local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
      activityCtrl:HideActivityByExtraLogic((ActivityFrameEnum.eActivityType).StarUp, self.id)
    end
  end
end

ActivityStarUpData.IsFinish = function(self)
  -- function num : 0_3
  do return self.curStageId == nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityStarUpData.UpdateStarUpRedddot = function(self)
  -- function num : 0_4 , upvalues : _ENV, ActivityFrameEnum
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  if self.curStageId == nil then
    activityFrameCtrl:SetReddot((ActivityFrameEnum.eActivityType).StarUp, self.id, 0)
    return 
  end
  local isHasComplete = false
  local mainTask, tasks = self:GetTasks(self.curStageId, false, true)
  if mainTask ~= nil and mainTask:CheckComplete() then
    isHasComplete = true
  end
  if not isHasComplete then
    for i,v in ipairs(tasks) do
      if v:CheckComplete() then
        isHasComplete = true
        break
      end
    end
  end
  do
    activityFrameCtrl:SetReddot((ActivityFrameEnum.eActivityType).StarUp, self.id, isHasComplete and 1 or 0)
    return 
  end
end

ActivityStarUpData.ContainsTask = function(self, taskId, isAllStage)
  -- function num : 0_5
  if not isAllStage then
    isAllStage = false
  end
  if (not isAllStage and self.curStageId ~= nil) or not #(self.cfg).phase then
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

ActivityStarUpData.GetTasks = function(self, stageId, isJustMainTask, ignoreNullData)
  -- function num : 0_6 , upvalues : _ENV, TaskData
  CreatePickedTGask = function(id)
    -- function num : 0_6_0 , upvalues : _ENV, TaskData
    local stcData = (ConfigData.task)[id]
    do
      if stcData ~= nil then
        local taskData = (TaskData.CreatePickedTaskData)(stcData)
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

return ActivityStarUpData

