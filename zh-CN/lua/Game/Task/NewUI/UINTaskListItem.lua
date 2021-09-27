local UINTaskListItem = class("UINTaskListItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local SectorEnum = require("Game.Sector.SectorEnum")
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

UINTaskListItem.InitTaskItem = function(self, taskData, typeId)
  -- function num : 0_1 , upvalues : TaskEnum
  self.taskData = taskData
  self.typeId = typeId
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
  -- function num : 0_2 , upvalues : _ENV, TaskEnum
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).btn_ItemClick).enabled = true
  local unlock = true
  if (self.taskCfg).open_condition ~= nil and (self.taskCfg).open_condition > 0 then
    unlock = FunctionUnlockMgr:ValidateUnlock((self.taskCfg).open_condition)
  end
  if unlock then
    ((self.ui).img_state):SetIndex(self.state - 1)
    ;
    ((self.ui).tex_State):SetIndex(self.state - 1)
    ;
    ((self.ui).obj_stepArrow):SetActive(self.state == (TaskEnum.eTaskState).Completed)
    ;
    ((self.ui).obj_lock):SetActive(false)
    ;
    ((self.ui).obj_state):SetActive(true)
  else
    ((self.ui).img_state):SetIndex(0)
    ;
    ((self.ui).tex_State):SetIndex(0)
    ;
    ((self.ui).obj_stepArrow):SetActive(false)
    ;
    ((self.ui).obj_lock):SetActive(true)
    ;
    ((self.ui).obj_state):SetActive(false)
    local sysOpenCfg = (ConfigData.system_open)[(self.taskCfg).open_condition]
    if (table.count)(sysOpenCfg.pre_condition) == 1 and (sysOpenCfg.pre_condition)[1] == 3 then
      ((self.ui).obj_lockTextSub):SetActive(true)
      local sectorStageCfg = (ConfigData.sector_stage)[(sysOpenCfg.pre_para1)[1]]
      local sectorId = ConfigData:GetSectorIdShow(sectorStageCfg.sector)
      ;
      ((self.ui).tex_lock):SetIndex(sectorStageCfg.difficulty, tostring(sectorId), tostring(sectorStageCfg.num))
    else
      ((self.ui).obj_lockTextSub):SetActive(false)
      ;
      ((self.ui).tex_lock):SetIndex(0, FunctionUnlockMgr:GetFuncUnlockDecription((self.taskCfg).open_condition))
    end
  end
  if not unlock then
    ((self.ui).obj_isOver):SetActive(false)
  elseif self.state == (TaskEnum.eTaskState).InProgress then
    ((self.ui).obj_isOver):SetActive(false)
  elseif self.state == (TaskEnum.eTaskState).Completed then
    ((self.ui).obj_isOver):SetActive(false)
  elseif self.state == (TaskEnum.eTaskState).Picked then
    ((self.ui).obj_isOver):SetActive(true)
    -- DECOMPILER ERROR at PC177: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).btn_ItemClick).enabled = false
  else
    error("can\'t figure the task state=" .. (self.taskData).state)
    return 
  end
  local stepCfg = (self.taskData):GetStepCfg()
  if stepCfg == nil then
    error("can\'t read stepCfg id=" .. (self.taskData).stepIdx)
  end
  local schedule = unlock and (self.taskData).schedule or 0
  -- DECOMPILER ERROR at PC210: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_TaskIntro).text = (LanguageUtil.GetLocaleText)(stepCfg.intro)
  local sizeDelta = ((self.ui).img_bar).sizeDelta
  -- DECOMPILER ERROR at PC221: Confused about usage of register: R5 in 'UnsetPending'

  if self.state == (TaskEnum.eTaskState).Picked then
    ((self.ui).img_Fill).sizeDelta = sizeDelta
    ;
    ((self.ui).tex_Progress):SetIndex(1)
  else
    -- DECOMPILER ERROR at PC239: Confused about usage of register: R5 in 'UnsetPending'

    ((self.ui).img_Fill).sizeDelta = (Vector2.New)(schedule / (self.taskData).aim * sizeDelta.x, sizeDelta.y)
    if schedule < (self.taskData).aim then
      ((self.ui).tex_Progress):SetIndex(0, tostring(schedule), tostring((self.taskData).aim))
    else
      ((self.ui).tex_Progress):SetIndex(1)
    end
  end
  -- DECOMPILER ERROR: 15 unprocessed JMP targets
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
    do
      local jumpArgs = (self.taskCfg).jumpArgs
      if jumpId ~= nil and jumpId > 0 then
        do
          JumpManager:Jump(jumpId, function(jumpCallback)
    -- function num : 0_4_0
    if jumpCallback ~= nil then
      jumpCallback()
    end
  end
, nil, jumpArgs)
          -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  else
    if self.state == (TaskEnum.eTaskState).Completed then
      self.state = (TaskEnum.eTaskState).Picked
      local taskWindow = UIManager:GetWindow(UIWindowTypeID.Task)
      if taskWindow ~= nil and ((self.poolRewardItem).listItem)[1] ~= nil then
        taskWindow:RecordTaskRewardItemPos(((((self.poolRewardItem).listItem)[1]).transform).position)
      end
      ;
      (self.ctrl):SendCommitQuestReward(self.taskData, nil, function()
    -- function num : 0_4_1 , upvalues : taskWindow, self
    taskWindow:ChangeBtnReceiveAll(self.typeId)
  end
)
    else
      do
        do return  end
      end
    end
  end
end

UINTaskListItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINTaskListItem

