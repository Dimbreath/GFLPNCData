-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTaskListItem = class("UINTaskListItem", UIBaseWindow)
local base = UIBaseWindow
local TaskEnum = require("Game.Task.TaskEnum")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")
local enableTaskLog = (GR.EnableTaskLog)()
UINTaskListItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  self.taskState = nil
  self.state = nil
  self.taskCfg = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ItemClick, self, self.OnClickBtn)
  self.poolRewardItem = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
  ;
  ((self.ui).rewardItem):SetActive(false)
end

UINTaskListItem.InitTaskItem = function(self, taskData)
  -- function num : 0_1 , upvalues : TaskEnum
  self.taskData = taskData
  if taskData.isPicked then
    self.state = (TaskEnum.eTaskState).Picked
  else
    if taskData:CheckComplete() then
      self.state = (TaskEnum.eTaskState).Completed
    else
      self.state = (TaskEnum.eTaskState).InProgress
    end
  end
  self.taskCfg = taskData.stcData
  self:RefreshUI()
  self:RefreshRewards(self.state == (TaskEnum.eTaskState).Picked)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINTaskListItem.RefreshUI = function(self)
  -- function num : 0_2 , upvalues : TaskEnum, _ENV
  ((self.ui).img_state):SetIndex(self.state - 1)
  ;
  ((self.ui).tex_State):SetIndex(self.state - 1)
  ;
  ((self.ui).obj_stepArrow):SetActive(self.state == (TaskEnum.eTaskState).Completed)
  if self.state == (TaskEnum.eTaskState).InProgress then
    ((self.ui).obj_isOver):SetActive(false)
  elseif self.state == (TaskEnum.eTaskState).Completed then
    ((self.ui).obj_isOver):SetActive(false)
  elseif self.state == (TaskEnum.eTaskState).Picked then
    ((self.ui).obj_isOver):SetActive(true)
  else
    error("can\'t figure the task state=" .. (self.taskData).state)
    return 
  end
  do
    if (self.taskData).steps == nil then
      local stepCfg = (ConfigData.taskStep)[(self.taskCfg).id]
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self.taskData).steps = stepCfg
    end
    if (table.count)((self.taskData).steps) > 1 then
      warn("task has mult steps, can\'t support now")
    end
    for stepId,stepData in pairs((self.taskData).steps) do
      local stepCfg = ((self.taskData).taskStepCfg)[stepId]
      if stepCfg == nil then
        error("can\'t read stepCfg id=" .. stepId)
      end
      local schedule = stepData.schedule
      -- DECOMPILER ERROR at PC106: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((self.ui).tex_TaskIntro).text = (LanguageUtil.GetLocaleText)(stepCfg.intro)
      local sizeDelta = ((self.ui).img_bar).sizeDelta
      -- DECOMPILER ERROR at PC117: Confused about usage of register: R9 in 'UnsetPending'

      if self.state == (TaskEnum.eTaskState).Picked then
        ((self.ui).img_Fill).sizeDelta = sizeDelta
        ;
        ((self.ui).tex_Progress):SetIndex(1)
      else
        -- DECOMPILER ERROR at PC134: Confused about usage of register: R9 in 'UnsetPending'

        ((self.ui).img_Fill).sizeDelta = (Vector2.New)(schedule / stepData.aim * sizeDelta.x, sizeDelta.y)
        if schedule < stepData.aim then
          ((self.ui).tex_Progress):SetIndex(0, tostring(schedule), tostring(stepData.aim))
        else
          ((self.ui).tex_Progress):SetIndex(1)
        end
      end
    end
    -- DECOMPILER ERROR: 11 unprocessed JMP targets
  end
end

UINTaskListItem.RefreshRewards = function(self, isPick)
  -- function num : 0_3 , upvalues : _ENV
  (self.poolRewardItem):HideAll()
  for index,id in ipairs((self.taskCfg).rewardIds) do
    local itemCfg = (ConfigData.item)[id]
    local num = ((self.taskCfg).rewardNums)[index]
    local ItemWithCount = (self.poolRewardItem):GetOne()
    ItemWithCount:InitItemWithCount(itemCfg, num, nil, isPick)
  end
end

UINTaskListItem.OnClickBtn = function(self)
  -- function num : 0_4 , upvalues : TaskEnum, JumpManager, _ENV
  if self.state == (TaskEnum.eTaskState).InProgress then
    local jumpId = (self.taskCfg).jump_id
    local jumpArgs = (self.taskCfg).jumpArgs
    if jumpId ~= nil and jumpId > 0 then
      JumpManager:Jump(jumpId, function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    (UIUtil.PopFromBackStack)()
    ;
    (self.ctrl):CloseTaskUI()
  end
, nil, jumpArgs)
    end
  else
    do
      if self.state == (TaskEnum.eTaskState).Completed then
        (self.ctrl):SendCommitQuestReward(self.taskData)
      else
        return 
      end
    end
  end
end

UINTaskListItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINTaskListItem

