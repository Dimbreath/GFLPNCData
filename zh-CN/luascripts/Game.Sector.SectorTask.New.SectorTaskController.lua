-- params : ...
-- function num : 0 , upvalues : _ENV
local SectorTaskController = class("SectorTaskController")
local TaskEnum = require("Game.Task.TaskEnum")
local SectorEnum = require("Game.Sector.SectorEnum")
local cs_MessageCommon = CS.MessageCommon
SectorTaskController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.taskNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  self.__onTaskUpdate = BindCallback(self, self.__OnTaskUpdate)
  self.__onTaskDelete = BindCallback(self, self.__OnTaskDelete)
  self.__onTaskCommit = BindCallback(self, self.__OnTaskCommit)
  self.__onPickedAchivItem = BindCallback(self, self.__OnPickedAchivItem)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__onTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__onTaskDelete)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommit)
  MsgCenter:AddListener(eMsgEventId.SectorPickReward, self.__onPickedAchivItem)
  self.__onUpdateItemEvent = BindCallback(self, self.__OnItemUpdateEvent)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
  self.isInit = false
end

SectorTaskController.OpenSectorTaskWindows = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if not self.isInit then
    return 
  end
  if self.uiWindow == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.SectorTask, function(window)
    -- function num : 0_1_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitSectorTask(self)
    window:RefreshProcessUI(self:GetSectorTaskProcess())
    window:RefreshSectorTask(self.sortDataArr, self.achivDataArr)
    self.uiWindow = window
  end
)
  end
end

SectorTaskController.InitCurrSectorData = function(self, sectorId, sectorCfg)
  -- function num : 0_2 , upvalues : _ENV, TaskEnum
  self.sectorId = sectorId
  self.type = sectorCfg.achievement
  self.achivCfg = (ConfigData.sectorAchievement)[sectorId]
  if self.achivCfg == nil then
    self.achivCfg = {}
  end
  self.originDataDic = {}
  self.originDataDic = ((PlayerDataCenter.allTaskData).sectorTaskDatas)[self.type]
  self.taskDataDic = {}
  for k,Data in pairs(self.originDataDic) do
    if Data:CheckComplete() then
      Data.state = (TaskEnum.eTaskState).Completed
    else
      Data.state = (TaskEnum.eTaskState).InProgress
    end
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.taskDataDic)[k] = Data
  end
  self:__OnSectorAchivUpdate(sectorId, (PlayerDataCenter.sectorDatas)[sectorId])
  self.isInit = true
end

SectorTaskController.OnTaskItemClick = function(self, taskId)
  -- function num : 0_3 , upvalues : _ENV, SectorEnum
  local taskData = (self.taskDataDic)[taskId]
  if taskData == nil then
    error("Can`t Find taskData :ID = " .. taskId)
  end
  if taskData.state == (SectorEnum.eSectorAchivState).Completed then
    (self.taskNetworkCtrl):SendCommitQuest(taskData)
  end
end

SectorTaskController.__OnTaskUpdate = function(self, taskData)
  -- function num : 0_4 , upvalues : TaskEnum
  if (taskData.stcData).type ~= self.type then
    return 
  end
  if taskData:CheckComplete() then
    taskData.state = (TaskEnum.eTaskState).Completed
  else
    taskData.state = (TaskEnum.eTaskState).InProgress
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.taskDataDic)[taskData.id] = taskData
  self:__SortData()
  if self.uiWindow ~= nil then
    (self.uiWindow):RefreshTaskItem(self.sortDataArr)
  end
end

SectorTaskController.__OnTaskDelete = function(self, taskId)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.originDataDic)[taskId] = nil
end

SectorTaskController.__OnTaskCommit = function(self, taskCfg)
  -- function num : 0_6 , upvalues : _ENV
  self:__OnSectorAchivUpdate(self.sectorId, (PlayerDataCenter.sectorDatas)[self.sectorId])
  self:__SortData()
  if self.uiWindow ~= nil then
    (self.uiWindow):RefreshTaskItem(self.sortDataArr)
  end
end

SectorTaskController.OnAchivItemClick = function(self, achivId)
  -- function num : 0_7 , upvalues : _ENV, SectorEnum, cs_MessageCommon
  local achivData = (self.achivDataArr)[achivId]
  if achivData == nil then
    error("Can`t Find achivData :ID = " .. achivId)
  end
  if achivData.state == (SectorEnum.eSectorAchivState).Normal then
    local achivCfg = achivData.achivCfg
    local msg = ConfigData:GetTipContent(TipContent.SectorTask_CanObtainReward)
    for i = 1, #achivCfg.achivRewardIds do
      local rewardId = (achivCfg.achivRewardIds)[i]
      local rewardNum = (achivCfg.achivRewardNums)[i]
      local item = (ConfigData.item)[rewardId]
      msg = msg .. "\n" .. (LanguageUtil.GetLocaleText)(item.name) .. " x " .. tostring(rewardNum)
    end
    ;
    (cs_MessageCommon.ShowMessageBox)(msg)
  else
    do
      if achivData.state == (SectorEnum.eSectorAchivState).Completed then
        self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
        ;
        (self.sectorNetworkCtrl):SendPickReward(self.sectorId, achivId)
      else
        if achivData.state == (SectorEnum.eSectorAchivState).Picked then
          (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.SectorTask_ObtainedReward))
        end
      end
    end
  end
end

SectorTaskController.__OnPickedAchivItem = function(self, sectorId, id)
  -- function num : 0_8 , upvalues : _ENV
  local achivCfg = (self.achivCfg)[id]
  local rewardIds = {}
  local rewardNums = {}
  for i = 1, #achivCfg.achivRewardIds do
    local rewardId = (achivCfg.achivRewardIds)[i]
    local rewardNum = (achivCfg.achivRewardNums)[i]
    local item = (ConfigData.item)[rewardId]
    ;
    (table.insert)(rewardIds, (achivCfg.achivRewardIds)[i])
    ;
    (table.insert)(rewardNums, (achivCfg.achivRewardNums)[i])
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_8_0 , upvalues : rewardIds, rewardNums, self
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot)
  end
)
end

SectorTaskController.__OnSectorAchivUpdate = function(self, sectorId, sectorData)
  -- function num : 0_9 , upvalues : SectorEnum, _ENV, TaskEnum
  if sectorId ~= self.sectorId then
    return 
  end
  local completed = sectorData.completed
  local boxPicked = sectorData.boxPicked
  if #self.achivCfg == 0 or #((self.achivCfg)[1]).conditionIds == 0 then
    return 
  end
  self.achivDataArr = {}
  for i = 1, #self.achivCfg do
    local state = nil
    if boxPicked ~= nil and boxPicked[i] ~= nil then
      state = (SectorEnum.eSectorAchivState).Picked
    else
      if ((PlayerDataCenter.sectorDatas).CheckAchivCondition)((self.achivCfg)[i]) then
        state = (SectorEnum.eSectorAchivState).Completed
      else
        state = (SectorEnum.eSectorAchivState).Normal
      end
    end
    local achivData = {}
    achivData.state = state
    achivData.achivCfg = (self.achivCfg)[i]
    ;
    (table.insert)(self.achivDataArr, achivData)
  end
  if completed == nil then
    completed = {}
  end
  for taskId,v in pairs(completed) do
    local taskData = {}
    taskData.state = (TaskEnum.eTaskState).Picked
    local stcData = (ConfigData.task)[taskId]
    taskData.stcData = stcData
    taskData.id = taskId
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self.taskDataDic)[taskId] = taskData
  end
  self:__SortData()
end

SectorTaskController.GetSectorTaskProcess = function(self)
  -- function num : 0_10
  self:__GetProcessRate()
  return self.starId, self.starCount, self.starTotalCount
end

SectorTaskController.SetWindowQuitEvent = function(self, QuitAction)
  -- function num : 0_11
  self.__OnQuitAction = QuitAction
end

SectorTaskController.__OnItemUpdateEvent = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self:__OnSectorAchivUpdate(self.sectorId, (PlayerDataCenter.sectorDatas)[self.sectorId])
  if self.uiWindow ~= nil then
    (self.uiWindow):RefreshProcessUI(self:GetSectorTaskProcess())
    ;
    (self.uiWindow):RefreshSectorTask(self.sortDataArr, self.achivDataArr)
  end
end

SectorTaskController.__GetProcessRate = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self.starId = (((self.achivCfg)[1]).conditionIds)[1]
  self.starCount = PlayerDataCenter:GetItemCount(self.starId)
  self.starTotalCount = (((self.achivCfg)[#self.achivCfg]).conditionNums)[1]
end

SectorTaskController.__SortData = function(self)
  -- function num : 0_14 , upvalues : _ENV, TaskEnum
  self.sortDataArr = {}
  for k,data in pairs(self.taskDataDic) do
    (table.insert)(self.sortDataArr, data)
  end
  ;
  (table.sort)(self.sortDataArr, function(a, b)
    -- function num : 0_14_0 , upvalues : TaskEnum
    if a.id >= b.id then
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
end

SectorTaskController.OnUiWindowClose = function(self)
  -- function num : 0_15
  if self.__OnQuitAction ~= nil then
    (self.__OnQuitAction)()
  end
  ;
  (self.uiWindow):Delete()
  self.uiWindow = nil
end

SectorTaskController.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__onTaskUpdate)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__onTaskDelete)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__onTaskCommit)
  MsgCenter:RemoveListener(eMsgEventId.SectorPickReward, self.__onPickedAchivItem)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
end

return SectorTaskController

