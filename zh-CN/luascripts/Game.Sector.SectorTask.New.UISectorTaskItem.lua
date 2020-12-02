-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorTaskItem = class("UISectorTaskItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
UISectorTaskItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).Btn_TaskItem, self, self.__OnTaskItemClick)
  ;
  ((self.ui).obj_ResNode):SetActive(false)
  self.textUIState = {[1] = (self.ui).obj_Picked, [2] = ((self.ui).tex_InProgress).gameObject, [3] = (self.ui).obj_Completed}
  self.originSizeDelta = {x = (((self.ui).rect_Process).sizeDelta).x, y = (((self.ui).rect_Process).sizeDelta).y}
end

UISectorTaskItem.RefreshSectorTaskItem = function(self, taskData, onClickAction)
  -- function num : 0_1
  self.taskData = taskData
  self.stcData = taskData.stcData
  self.state = taskData.state
  self.__onClickAction = onClickAction
  self:__RefreshStepCfgData(self.stcData)
  self:__RefreshUI()
end

UISectorTaskItem.__RefreshStepCfgData = function(self, stcData)
  -- function num : 0_2 , upvalues : _ENV
  local taskStepCfg = ((ConfigData.taskStep)[stcData.id])[1]
  if taskStepCfg == nil then
    error("Can`t find taskStepCfg:ID = " .. tostring(stcData.id))
    return 
  end
  self.intro = taskStepCfg.intro
  self.step = taskStepCfg.step
  if (self.taskData).steps ~= nil then
    self.stepCfg = ((self.taskData).steps)[1]
  end
end

UISectorTaskItem.__RefreshUI = function(self)
  -- function num : 0_3 , upvalues : _ENV, TaskEnum
  for _,go in pairs(self.textUIState) do
    go:SetActive(false)
  end
  ;
  (((self.ui).rect_Process).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Intro).text = (LanguageUtil.GetLocaleText)(self.intro)
  self:__ShowRewardUI()
  if self.state == (TaskEnum.eTaskState).Picked then
    self:__SetPickedUI()
  else
    self:__SetProcessUI()
    if self.state == (TaskEnum.eTaskState).Completed then
      self:__SetCompletedUI()
    else
      self:__SetInProgressUI()
    end
  end
end

UISectorTaskItem.__SetProcessUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.stepCfg == nil then
    error("Can\'t find stepCfg")
    return 
  end
  ;
  (((self.ui).rect_Process).gameObject):SetActive(true)
  local rate = (math.min)((self.stepCfg).schedule, (self.stepCfg).aim) / (self.stepCfg).aim
  local sizeDelta = {}
  sizeDelta.x = rate * (self.originSizeDelta).x
  sizeDelta.y = (self.originSizeDelta).y
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).rect_Process).sizeDelta = sizeDelta
end

UISectorTaskItem.__SetInProgressUI = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.stepCfg == nil then
    error("Can\'t find stepCfg")
    return 
  end
  ;
  ((self.ui).img_State):SetIndex(0)
  ;
  (((self.ui).tex_InProgress).gameObject):SetActive(true)
  ;
  ((self.ui).tex_InProgress):SetIndex(0, tostring((math.min)((self.stepCfg).schedule, (self.stepCfg).aim)), tostring((self.stepCfg).aim))
end

UISectorTaskItem.__SetCompletedUI = function(self)
  -- function num : 0_6
  ((self.ui).img_State):SetIndex(1)
  ;
  ((self.ui).obj_Completed):SetActive(true)
end

UISectorTaskItem.__SetPickedUI = function(self)
  -- function num : 0_7
  ((self.ui).img_State):SetIndex(2)
  ;
  ((self.ui).obj_Picked):SetActive(true)
end

UISectorTaskItem.__ShowRewardUI = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.step ~= 1 then
    return 
  end
  for i = 1, #(self.stcData).rewardIds do
    local rewardId = ((self.stcData).rewardIds)[i]
    local rewardNum = ((self.stcData).rewardNums)[i]
    local itemCfg = (ConfigData.item)[rewardId]
    ;
    ((self.ui).obj_ResNode):SetActive(true)
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.icon)
    ;
    ((self.ui).tex_Count):SetIndex(0, tostring(rewardNum))
  end
end

UISectorTaskItem.__OnTaskItemClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (GR.EnableTaskLog)() then
    print((string.format)("[Dev]TaskId:%s, stepId:%s", (self.stcData).id, 1))
  else
    if self.__onClickAction ~= nil then
      (self.__onClickAction)((self.taskData).id)
    end
  end
end

UISectorTaskItem.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnDelete)(self)
end

return UISectorTaskItem

