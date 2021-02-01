-- params : ...
-- function num : 0 , upvalues : _ENV
local UINActivityStarUpTask = class("UINActivityStarUpTask", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local ActivityEnum = require("Game.Activity.ActivityEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
UINActivityStarUpTask.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Get, self, self.OnClickGet)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Goto, self, self.OnClickGoto)
  ;
  ((self.ui).rewardItem):SetActive(false)
  self.rewardPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
end

UINActivityStarUpTask.InitItem = function(self, taskInfo)
  -- function num : 0_1 , upvalues : TaskEnum, _ENV
  self.taskInfo = taskInfo
  local isFinish = taskInfo.state == (TaskEnum.eTaskState).Picked
  ;
  (self.rewardPool):HideAll()
  for i,v in ipairs((taskInfo.stcData).rewardIds) do
    local item = (self.rewardPool):GetOne(true)
    local itemCfg = (ConfigData.item)[v]
    local num = ((taskInfo.stcData).rewardNums)[i]
    item:InitItemWithCount(itemCfg, num, nil, isFinish)
  end
  ;
  ((self.ui).tex_TaskIntro):SetIndex(isFinish and 0 or 1, (LanguageUtil.GetLocaleText)((taskInfo.stcData).name))
  self:UpdateUI()
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINActivityStarUpTask.UpdateUI = function(self)
  -- function num : 0_2 , upvalues : TaskEnum, _ENV
  if (self.taskInfo).state == (TaskEnum.eTaskState).Picked then
    ((self.ui).img_Buttom):SetIndex(2)
  else
    if (self.taskInfo):CheckComplete() then
      ((self.ui).img_Buttom):SetIndex(1)
    else
      ;
      ((self.ui).img_Buttom):SetIndex(0)
    end
  end
  ;
  ((self.ui).obj_Unfinish):SetActive(false)
  ;
  ((self.ui).obj_Completed):SetActive(false)
  ;
  (((self.ui).btn_Get).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Goto).gameObject):SetActive(false)
  local isFinish = (self.taskInfo).state == (TaskEnum.eTaskState).Picked
  local isComplect = (self.taskInfo):CheckComplete()
  local isCanjump = ((self.taskInfo).stcData).jump_id ~= nil and ((self.taskInfo).stcData).jump_id > 0
  ;
  (((self.ui).btn_Goto).gameObject):SetActive((not isComplect and isCanjump))
  ;
  (((self.ui).obj_Unfinish).gameObject):SetActive((not isComplect and not isCanjump))
  if isComplect then
    (((self.ui).btn_Get).gameObject):SetActive(not isFinish)
    ;
    ((self.ui).obj_Completed):SetActive(isFinish)
    local schedule, aim = (self.taskInfo):GetTaskProcess()
    -- DECOMPILER ERROR at PC121: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Progress).text = tostring(schedule) .. "/" .. tostring(aim)
    local progress = schedule / aim
    if progress >= 1 or not progress then
      progress = 1
    end
    self.barWidth = ((((self.ui).bar).rectTransform).rect).width
    local vec = (((self.ui).img_Fill).rectTransform).sizeDelta
    vec.x = self.barWidth * progress
    -- DECOMPILER ERROR at PC144: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (((self.ui).img_Fill).rectTransform).sizeDelta = vec
    for i,v in ipairs((self.rewardPool).listItem) do
      v:SetPickedUIActive(isFinish)
    end
    -- DECOMPILER ERROR: 11 unprocessed JMP targets
  end
end

UINActivityStarUpTask.OnClickGoto = function(self)
  -- function num : 0_3 , upvalues : JumpManager, _ENV
  if ((self.taskInfo).stcData).jump_id ~= nil and ((self.taskInfo).stcData).jump_id > 0 and JumpManager:ValidateJump(((self.taskInfo).stcData).jump_id, ((self.taskInfo).stcData).jumpArgs) then
    (UIUtil.OnClickBack)()
    JumpManager:Jump(((self.taskInfo).stcData).jump_id, nil, nil, ((self.taskInfo).stcData).jumpArgs)
  end
end

UINActivityStarUpTask.OnClickGet = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtr:SendCommitQuestReward(self.taskInfo)
end

UINActivityStarUpTask.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallBack)
  ;
  (base.OnDelete)(self)
end

return UINActivityStarUpTask

