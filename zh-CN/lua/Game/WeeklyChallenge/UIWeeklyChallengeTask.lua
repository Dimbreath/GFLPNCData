local UIWeeklyChallengeTask = class("UIWeeklyChallengeTask", UIBaseWindow)
local base = UIBaseWindow
local UINTaskList = require("Game.Task.NewUI.UINTaskList")
local UINTaskPeroidNode = require("Game.Task.NewUI.UINTaskPeroidNode")
local TaskEnum = require("Game.Task.TaskEnum")
UIWeeklyChallengeTask.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINTaskList, UINTaskPeroidNode
  (UIUtil.SetTopStatus)(self, self.OnClickBack, {}, nil, nil)
  self.taskListNode = (UINTaskList.New)()
  ;
  (self.taskListNode):Init((self.ui).taskListNode)
  self.peroidNode = (UINTaskPeroidNode.New)()
  ;
  (self.peroidNode):Init((self.ui).peroidListNode)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AllPickClick, self, self.OnClickAllPick)
  self.__RefreshTaskUIShow = BindCallback(self, self.RefreshTaskUIShow)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__RefreshTaskUIShow)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__RefreshTaskUIShow)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__RefreshTaskUIShow)
  self.__RefreshPeroidUIShow = BindCallback(self, self.RefreshPeroidUIShow)
  MsgCenter:AddListener(eMsgEventId.PeroidUpdate, self.__RefreshPeroidUIShow)
end

UIWeeklyChallengeTask.InitWeeklyChallengeTask = function(self)
  -- function num : 0_1
  self:RefreshTaskUIShow()
  self:RefreshPeroidUIShow()
end

UIWeeklyChallengeTask.RefreshTaskUIShow = function(self)
  -- function num : 0_2 , upvalues : _ENV, TaskEnum
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtrl:SelectTask((TaskEnum.eTaskType).WeeklyChallengeTask)
  local taskDatas, peroidDatas = taskCtrl:GetDatas4Task((TaskEnum.eTaskType).WeeklyChallengeTask)
  local taskList = {}
  for key,task in pairs(taskDatas) do
    (table.insert)(taskList, task)
  end
  ;
  (self.taskListNode):RefreshTaskItems(taskList, true)
end

UIWeeklyChallengeTask.RefreshPeroidUIShow = function(self)
  -- function num : 0_3 , upvalues : _ENV, TaskEnum
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtrl:SelectTask((TaskEnum.eTaskType).WeeklyChallengeTask)
  local taskDatas, peroidDatas = taskCtrl:GetDatas4Task((TaskEnum.eTaskType).WeeklyChallengeTask)
  ;
  (self.peroidNode):RefreshPeroid((TaskEnum.eTaskType).WeeklyChallengeTask, peroidDatas, true)
  local isShowAllPick = false
  for index,data in ipairs(peroidDatas) do
    if data.stateType == (TaskEnum.eTaskState).Completed then
      isShowAllPick = true
      break
    end
  end
  do
    ;
    (((self.ui).btn_AllPickClick).gameObject):SetActive(isShowAllPick)
  end
end

UIWeeklyChallengeTask.OnClickAllPick = function(self)
  -- function num : 0_4 , upvalues : _ENV, TaskEnum
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  local taskDatas, peroidDatas = taskCtrl:GetDatas4Task((TaskEnum.eTaskType).WeeklyChallengeTask)
  local indexDic = {}
  for index,data in ipairs(peroidDatas) do
    if data.stateType == (TaskEnum.eTaskState).Completed then
      indexDic[index] = true
    end
  end
  taskCtrl:SendCommitTaskPeriodArray(indexDic, (TaskEnum.eTaskPeriodType).WeeklyChallengeTask)
end

UIWeeklyChallengeTask.OnClickBack = function(self)
  -- function num : 0_5
  self:Delete()
end

UIWeeklyChallengeTask.OnDelete = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__RefreshTaskUIShow)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__RefreshTaskUIShow)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__RefreshTaskUIShow)
  MsgCenter:RemoveListener(eMsgEventId.PeroidUpdate, self.__RefreshPeroidUIShow)
  ;
  (self.taskListNode):Delete()
  ;
  (self.peroidNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UIWeeklyChallengeTask

