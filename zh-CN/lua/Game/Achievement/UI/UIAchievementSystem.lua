local UIAchievementSystem = class("UIAchievementSystem", UIBaseWindow)
local base = UIBaseWindow
local JumpManager = require("Game.Jump.JumpManager")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_ResLoader = CS.ResLoader
local UINAchievementTog = require("Game.Achievement.UI.UINAchievementTog")
local UINAchievementItem = require("Game.Achievement.UI.UINAchievementItem")
local UINAchievementLevelNode = require("Game.Achievement.UI.AchieveLevelUI.UINAchievementLevelNode")
local defaultTogType = 1
UIAchievementSystem.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINAchievementLevelNode, UINAchievementTog
  self.achieveItemDic = {}
  self.achieveDataList = {}
  self.resloader = (cs_ResLoader.Create)()
  self.taskNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
  self.currAchievementType = nil
  self.achievementLevelNode = (UINAchievementLevelNode.New)()
  ;
  (self.achievementLevelNode):Init((self.ui).achievementLevelNode)
  ;
  (UIUtil.SetTopStatus)(self, self.OnReturnClick)
  self.typeTogPool = (UIItemPool.New)(UINAchievementTog, (self.ui).obj_achivTypeTogHolder)
  ;
  ((self.ui).obj_achivTypeTogHolder):SetActive(false)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopList_achieveListNode).onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loopList_achieveListNode).onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self._JumpToTarget = BindCallback(self, self.JumpToTarget)
  self._GetReward = BindCallback(self, self.GetReward)
  self.__OnTaskUpdate = BindCallback(self, self.OnTaskUpdate)
  self.__OnTaskDelete = BindCallback(self, self.OnTaskDelete)
  self.__OnTaskCommit = BindCallback(self, self.OnTaskCommit)
  self.__onTaskPicked = BindCallback(self, self.OnTaskPicked)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
  MsgCenter:AddListener(eMsgEventId.UpdatePickedAchivTask, self.__onTaskPicked)
  self.offsetMin = ((((self.ui).loopList_achieveListNode).gameObject).transform).offsetMin
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ReceiveAll, self, self.OnClickReceiveAll)
end

UIAchievementSystem.InitAchievement = function(self, openTagType)
  -- function num : 0_1 , upvalues : _ENV
  self:GenSubPageTogs()
  self:m_HandaySelectSubpage(openTagType)
  self:InitRedDotEvent()
  ;
  (self.achievementLevelNode):RefreshPlayerLevel(false)
  local cur = (PlayerDataCenter.achivLevelData):GetPickedAchNum()
  local total = (PlayerDataCenter.achivLevelData):GetTotalAchNum()
  ;
  (self.achievementLevelNode):RefreshAchFinishedNum(cur, total)
  NoticeManager:DeleteNoticeByType((NoticeManager.eNoticeType).AchievementAchieved)
end

UIAchievementSystem.GenSubPageTogs = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local openPageCallback = BindCallback(self, self.ShowSubPage)
  ;
  (self.typeTogPool):HideAll()
  for _,achieveTypeCfg in ipairs(ConfigData.achievement) do
    local toggle = (self.typeTogPool):GetOne()
    toggle:InitAchieveTog(achieveTypeCfg, openPageCallback)
  end
end

UIAchievementSystem.m_HandaySelectSubpage = function(self, achievementType)
  -- function num : 0_3 , upvalues : defaultTogType, _ENV
  if not achievementType then
    achievementType = defaultTogType
  end
  for _,toggle in pairs((self.typeTogPool).listItem) do
    if toggle.type == achievementType then
      toggle:SetSelected(true)
      break
    end
  end
end

UIAchievementSystem.InitRedDotEvent = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for _,item in ipairs((self.typeTogPool).listItem) do
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelPage, item.task_type)
    item:SetRedDot(not ok or node:GetRedDotCount() > 0)
  end
  self.__onAchievTogRedDotEvent = function(node)
    -- function num : 0_4_0 , upvalues : _ENV, self
    local taskType = node.nodeId
    for _,item in ipairs((self.typeTogPool).listItem) do
      if node:GetRedDotCount() <= 0 then
        do
          item:SetRedDot(item.task_type ~= taskType)
          do break end
          -- DECOMPILER ERROR at PC18: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC18: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end

  RedDotController:AddListener(RedDotDynPath.AchivTaskPagePath, self.__onAchievTogRedDotEvent)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIAchievementSystem.OnClickReceiveAll = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local taskctl = ControllerManager:GetController(ControllerTypeId.Task, true)
  taskctl:SendOneKeyPick(self.ids, BindCallback(self, self.ChangeBtnReceiveAll))
end

UIAchievementSystem.RemoveRedDotEvent = function(self)
  -- function num : 0_6 , upvalues : _ENV
  RedDotController:RemoveListener(RedDotDynPath.AchivTaskPagePath, self.__onAchievTogRedDotEvent)
end

UIAchievementSystem.ShowSubPage = function(self, achievementType)
  -- function num : 0_7 , upvalues : _ENV, TaskEnum
  self.currAchievementType = achievementType
  local taskTypeId = ((ConfigData.achievement)[achievementType]).task_type
  local achivDatas = ((PlayerDataCenter.allTaskData).achievementDatas)[taskTypeId]
  local pickedAchivs = ((PlayerDataCenter.achivLevelData).pickedRewardAchivs)[taskTypeId]
  if achivDatas == nil then
    error("Can\'t find achivDatas, taskTypeId=" .. tostring(taskTypeId))
    return 
  end
  self.achieveDataList = {}
  for _,data in pairs(achivDatas) do
    local state = (TaskEnum.eTaskState).InProgress
    if data:CheckComplete() then
      state = (TaskEnum.eTaskState).Completed
    end
    ;
    (table.insert)(self.achieveDataList, {taskData = data, state = state, stcData = data.stcData})
  end
  for _,pickedAchivData in pairs(pickedAchivs) do
    (table.insert)(self.achieveDataList, {taskData = nil, state = (TaskEnum.eTaskState).Picked, stcData = (ConfigData.task)[pickedAchivData.taskId], completedTimestamp = pickedAchivData.completedTimestamp})
  end
  ;
  (table.sort)(self.achieveDataList, function(a, b)
    -- function num : 0_7_0 , upvalues : TaskEnum
    if (a.stcData).id >= (b.stcData).id then
      do return a.state ~= b.state end
      if a.state == (TaskEnum.eTaskState).Completed then
        return true
      elseif b.state == (TaskEnum.eTaskState).Completed then
        return false
      elseif a.state == (TaskEnum.eTaskState).InProgress then
        return true
      elseif b.state == (TaskEnum.eTaskState).InProgress then
        return false
      end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
)
  self:ChangeBtnReceiveAll()
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).loopList_achieveListNode).totalCount = #self.achieveDataList
  ;
  ((self.ui).loopList_achieveListNode):RefillCells()
end

UIAchievementSystem.ChangeBtnReceiveAll = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self.ids = {}
  local curPageTaskType = ((ConfigData.achievement)[self.currAchievementType]).task_type
  local isThisTypeHasTask = false
  for type,taskDataDic in pairs((PlayerDataCenter.allTaskData).achievementDatas) do
    for taskId,taskData in pairs(taskDataDic) do
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R13 in 'UnsetPending'

      if taskData:CheckComplete() then
        (self.ids)[taskId] = true
        if type == curPageTaskType then
          isThisTypeHasTask = true
        end
      end
    end
  end
  if (table.count)(self.ids) > 0 and isThisTypeHasTask then
    (((self.ui).btn_ReceiveAll).gameObject):SetActive(true)
    local size = ((((self.ui).btn_ReceiveAll).gameObject).transform).sizeDelta
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((((self.ui).loopList_achieveListNode).gameObject).transform).offsetMin = (Vector2.New)((self.offsetMin).x, (self.offsetMin).y + size.y)
  else
    do
      ;
      (((self.ui).btn_ReceiveAll).gameObject):SetActive(false)
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((((self.ui).loopList_achieveListNode).gameObject).transform).offsetMin = (Vector2.New)((self.offsetMin).x, (self.offsetMin).y)
    end
  end
end

UIAchievementSystem.m_OnNewItem = function(self, go)
  -- function num : 0_9 , upvalues : UINAchievementItem
  local achieveItem = (UINAchievementItem.New)()
  achieveItem:Init(go)
  achieveItem:InitAchieveItem(self.resloader, self._GetReward, self._JumpToTarget)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.achieveItemDic)[go] = achieveItem
end

UIAchievementSystem.m_OnChangeItem = function(self, go, index)
  -- function num : 0_10 , upvalues : _ENV
  local achieveItem = (self.achieveItemDic)[go]
  if achieveItem == nil then
    error("Can\'t find achieveItem by gameObject")
    return 
  end
  local achieveData = (self.achieveDataList)[index + 1]
  if achieveData == nil then
    error("Can\'t find achieveData by index, index = " .. tonumber(index))
  end
  achieveItem:RefreshAchieveItem(achieveData)
end

UIAchievementSystem.m_GetItemGoByIndex = function(self, index)
  -- function num : 0_11
  local go = ((self.ui).loopList_achieveListNode):GetCellByIndex(index)
  if go ~= nil then
    return (self.achieveItemDic)[go]
  end
  return nil
end

UIAchievementSystem.m_GetItemByTaskId = function(self, taskId)
  -- function num : 0_12 , upvalues : _ENV
  for i,achieveData in ipairs(self.achieveDataList) do
    if (achieveData.stcData).id == taskId then
      local index = i - 1
      return self:m_GetItemGoByIndex(index), i
    end
  end
end

UIAchievementSystem.GetReward = function(self, achieveData)
  -- function num : 0_13 , upvalues : TaskEnum, _ENV
  if achieveData.state == (TaskEnum.eTaskState).Completed then
    self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
    ;
    (self.taskNetworkCtrl):SendCommitQuest(achieveData.taskData)
  else
    if achieveData.state == (TaskEnum.eTaskState).Picked then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.achievement_taskCompleted))
    else
      ;
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.achievement_taskNotComplete))
    end
  end
end

UIAchievementSystem.JumpToTarget = function(self, taskCfg)
  -- function num : 0_14 , upvalues : JumpManager
  local jumpId = taskCfg.jump_id
  local jumpArgs = taskCfg.jumpArgs
  if jumpId ~= nil and jumpId ~= 0 then
    JumpManager:Jump(jumpId, function(jumpCallback)
    -- function num : 0_14_0
    if jumpCallback ~= nil then
      jumpCallback()
    end
  end
, nil, jumpArgs)
  end
end

UIAchievementSystem.OnTaskUpdate = function(self, taskData)
  -- function num : 0_15 , upvalues : _ENV, TaskEnum
  if (taskData.stcData).type ~= ((ConfigData.achievement)[self.currAchievementType]).task_type then
    return 
  end
  local achieveItem, index = self:m_GetItemByTaskId((taskData.stcData).id)
  if index ~= nil then
    local achieveData = (self.achieveDataList)[index]
    local state = (TaskEnum.eTaskState).InProgress
    if taskData:CheckComplete() then
      state = (TaskEnum.eTaskState).Completed
    end
    achieveData.taskData = taskData
    achieveData.state = state
    if achieveItem ~= nil then
      achieveItem:RefreshUI()
    end
  end
  do
    self:ChangeBtnReceiveAll()
  end
end

UIAchievementSystem.OnTaskDelete = function(self, id)
  -- function num : 0_16 , upvalues : _ENV
  local _, index = self:m_GetItemByTaskId(id)
  if index ~= nil then
    (table.remove)(self.achieveDataList, index)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).loopList_achieveListNode).totalCount = #self.achieveDataList
    ;
    ((self.ui).loopList_achieveListNode):RefillCells()
  end
end

UIAchievementSystem.OnTaskCommit = function(self, taskStcData)
  -- function num : 0_17 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_17_0 , upvalues : taskStcData, self
    if window == nil then
      return 
    end
    window:InitRewardsItem(taskStcData.rewardIds, taskStcData.rewardNums, self._heroIdSnapShoot)
  end
)
end

UIAchievementSystem.OnTaskPicked = function(self)
  -- function num : 0_18 , upvalues : _ENV
  self:ShowSubPage(self.currAchievementType)
  local cur = (PlayerDataCenter.achivLevelData):GetPickedAchNum()
  local total = (PlayerDataCenter.achivLevelData):GetTotalAchNum()
  ;
  (self.achievementLevelNode):RefreshAchFinishedNum(cur, total)
end

UIAchievementSystem.OpenAchievementInfo = function(self)
  -- function num : 0_19
end

UIAchievementSystem.SetOnAchievementSystemCloseCallback = function(self, action)
  -- function num : 0_20
  self._onCloseCallback = action
end

UIAchievementSystem.OnReturnClick = function(self)
  -- function num : 0_21
  self:OnCloseWin()
  if self._onCloseCallback ~= nil then
    (self._onCloseCallback)()
  end
  self:Delete()
end

UIAchievementSystem.OnDelete = function(self)
  -- function num : 0_22 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__OnTaskUpdate)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__OnTaskDelete)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__OnTaskCommit)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedAchivTask, self.__onTaskPicked)
  self:RemoveRedDotEvent()
  DestroyUnityObject((self.ui).loopList_achieveListNode)
  ;
  (self.achievementLevelNode):Delete()
  if self.achieveItemDic ~= nil then
    for go,achieveItem in pairs(self.achieveItemDic) do
      achieveItem:Delete()
    end
  end
  do
    ;
    (base.OnDelete)(self)
  end
end

UIAchievementSystem.OnDeleteEntity = function(self)
  -- function num : 0_23 , upvalues : base
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (base.OnDeleteEntity)(self)
end

return UIAchievementSystem

