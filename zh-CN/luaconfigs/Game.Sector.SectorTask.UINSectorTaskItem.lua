-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSectorTaskItem = class("UINSectorTaskItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
UINSectorTaskItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.isPicking = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).Btn_TaskItem, self, self.__OnTaskItemClick)
  self.originSizeDelta = {x = (((self.ui).rect_Process).sizeDelta).x, y = (((self.ui).rect_Process).sizeDelta).y}
end

UINSectorTaskItem.RefreshSectorTaskItem = function(self, taskData, onClickAction)
  -- function num : 0_1
  self.taskData = taskData
  self.__onClickAction = onClickAction
  self:__RefreshTaskItemUI()
end

UINSectorTaskItem.__RefreshTaskItemUI = function(self)
  -- function num : 0_2 , upvalues : _ENV, TaskEnum
  local stcData = (self.taskData).stcData
  local taskStepCfg = ((ConfigData.taskStep)[stcData.id])[1]
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  if taskStepCfg ~= nil then
    ((self.ui).tex_Intro).text = (LanguageUtil.GetLocaleText)(taskStepCfg.intro)
  else
    error("can\'t read taskStepCfg id:" .. tostring(((self.taskData).stcData).id))
  end
  if #stcData.rewardIds > 0 then
    local rewardId = (stcData.rewardIds)[1]
    local rewardNum = (stcData.rewardNums)[1]
    local itemCfg = (ConfigData.item)[rewardId]
    ;
    ((self.ui).obj_ResNode):SetActive(true)
    ;
    ((self.ui).tex_Count):SetIndex(0, tostring(rewardNum))
  else
    do
      ;
      ((self.ui).obj_ResNode):SetActive(false)
      ;
      ((self.ui).obj_bar):SetActive(false)
      ;
      (((self.ui).tex_Num).gameObject):SetActive(false)
      ;
      ((self.ui).obj_Completed):SetActive(false)
      ;
      ((self.ui).obj_Picked):SetActive(false)
      local hideProgress = ((self.taskData).stcData).is_hideProgress
      if (self.taskData).state == (TaskEnum.eTaskState).InProgress then
        ((self.ui).img_State):SetIndex(0)
        if not hideProgress then
          ((self.ui).obj_bar):SetActive(true)
          ;
          (((self.ui).tex_Num).gameObject):SetActive(true)
          local schedule, aim = (self.taskData):GetTaskProcess()
          -- DECOMPILER ERROR at PC118: Confused about usage of register: R6 in 'UnsetPending'

          ;
          ((self.ui).rect_Process).sizeDelta = (Vector2.New)(schedule / aim * (self.originSizeDelta).x, (self.originSizeDelta).y)
          -- DECOMPILER ERROR at PC133: Confused about usage of register: R6 in 'UnsetPending'

          ;
          ((self.ui).tex_Num).text = tostring((math.min)(schedule, aim)) .. "/" .. tostring(aim)
        end
      else
        do
          if (self.taskData).state == (TaskEnum.eTaskState).Completed then
            ((self.ui).img_State):SetIndex(1)
            ;
            ((self.ui).obj_Completed):SetActive(true)
            if not hideProgress then
              ((self.ui).obj_bar):SetActive(true)
              local schedule, aim = (self.taskData):GetTaskProcess()
              -- DECOMPILER ERROR at PC170: Confused about usage of register: R6 in 'UnsetPending'

              ;
              ((self.ui).rect_Process).sizeDelta = (Vector2.New)((self.originSizeDelta).x, (self.originSizeDelta).y)
            end
          else
            do
              if (self.taskData).state == (TaskEnum.eTaskState).Picked then
                ((self.ui).img_State):SetIndex(2)
                ;
                ((self.ui).obj_Picked):SetActive(true)
              end
            end
          end
        end
      end
    end
  end
end

UINSectorTaskItem.__OnTaskItemClick = function(self)
  -- function num : 0_3 , upvalues : _ENV, TaskEnum
  if (GR.EnableTaskLog)() then
    print((string.format)("[Dev]TaskId:%s, stepId:%s", ((self.taskData).stcData).id, 1))
  end
  if (self.taskData).state == (TaskEnum.eTaskState).Completed and not self.isPicking then
    self.isPicking = true
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Task)):SendCommitQuest(self.taskData, function()
    -- function num : 0_3_0 , upvalues : self
    self.isPicking = false
  end
)
  end
end

UINSectorTaskItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINSectorTaskItem

