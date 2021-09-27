local UISectorTask = class("UISectorTask", UIBaseWindow)
local base = UIBaseWindow
local UINSectorTaskItem = require("Game.Sector.SectorTask.UINSectorTaskItem")
local UINSectorTaskAchiveItem = require("Game.Sector.SectorTask.UINSectorTaskAchiveItem")
local UInSectorTaskRewardFloat = require("Game.Sector.SectorTask.UInSectorTaskRewardFloat")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local TaskEnum = require("Game.Task.TaskEnum")
local TaskUIType = {Sector = 1, WeeklyChallenge = 2}
UISectorTask.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UInSectorTaskRewardFloat, UINSectorTaskAchiveItem
  self.curSectorId = nil
  self.sectorTaskDatas = nil
  self.itemDic = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_taskScroll).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_taskScroll).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.viewReward = (UInSectorTaskRewardFloat.New)()
  ;
  (self.viewReward):Init((self.ui).viewReward)
  self.SectorTaskController = ControllerManager:GetController(ControllerTypeId.SectorTaskCtrl, true)
  self.achivParentWidth = (((self.ui).achivParent).rect).width
  ;
  (UIUtil.SetTopStatus)(self, self.__OnClickReturn)
  self.rewardItemPool = (UIItemPool.New)(UINSectorTaskAchiveItem, (self.ui).obj_rewardItem)
  ;
  ((self.ui).obj_rewardItem):SetActive(false)
  self.__refillTaskList = BindCallback(self, self.__RefillTaskList)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__refillTaskList)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__refillTaskList)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__refillTaskList)
  self.__refreshSectorAchivUI = BindCallback(self, self.__RefreshSectorAchivUI)
  MsgCenter:AddListener(eMsgEventId.SectorPickReward, self.__refreshSectorAchivUI)
  MsgCenter:AddListener(eMsgEventId.PeroidUpdate, self.__refreshSectorAchivUI)
  self.__onItemUpdate = BindCallback(self, self.__OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  self.__OnClickPeriodFunc = BindCallback(self, self.OnClickPeriodItem)
  self.resloader = ((CS.ResLoader).Create)()
end

UISectorTask.InitSectorTask = function(self, curSectorId, closeCallback)
  -- function num : 0_1 , upvalues : TaskUIType
  self.taskUIType = TaskUIType.Sector
  self.curSectorId = curSectorId
  self.closeCallback = closeCallback
  self.initTween = true
  self:__RefreshSectorTaskHead()
  self:__RefreshAchivTaskUI()
  self:__RefreshSectorAchivUI()
  ;
  ((self.ui).img_Icon):SetIndex(0)
end

UISectorTask.InitWeeklyChallengeTask = function(self, closeCallback)
  -- function num : 0_2 , upvalues : TaskUIType, _ENV
  self.taskUIType = TaskUIType.WeeklyChallenge
  self.closeCallback = closeCallback
  self.initTween = true
  self:__RefreshSectorTaskHead()
  self:__RefreshAchivTaskUI()
  self:__RefreshSectorAchivUI()
  ;
  ((self.ui).img_Icon):SetIndex(1)
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  local counterElem = (PlayerDataCenter.allWeeklyChallengeData):GetCounterElem()
  if counterElem ~= nil then
    self.nextRefreshTimeStamp = counterElem.nextExpiredTm
    if self.nextRefreshTimeStamp ~= nil and PlayerDataCenter.timestamp < self.nextRefreshTimeStamp then
      self.timerId = TimerManager:StartTimer(1, self.CutDownTime, self, false, false, false)
      self:CutDownTime()
    end
  end
end

UISectorTask.__RefreshSectorTaskHead = function(self)
  -- function num : 0_3 , upvalues : TaskUIType, _ENV
  (((self.ui).img_SectorPic).gameObject):SetActive(self.taskUIType == TaskUIType.Sector)
  ;
  (((self.ui).tex_IsPeriodic).gameObject):SetActive(self.taskUIType == TaskUIType.WeeklyChallenge)
  ;
  (((self.ui).bg_weeklyChallenge).gameObject):SetActive(self.taskUIType == TaskUIType.WeeklyChallenge)
  ;
  ((self.ui).taskCount):SetActive(self.taskUIType == TaskUIType.Sector)
  ;
  ((self.ui).taskTime):SetActive(self.taskUIType == TaskUIType.WeeklyChallenge)
  if self.taskUIType == TaskUIType.Sector then
    do
      if self.curSectorId ~= nil then
        local sectorCfg = (ConfigData.sector)[self.curSectorId]
        ;
        ((self.ui).tex_name):SetIndex(1, (LanguageUtil.GetLocaleText)(sectorCfg.name))
        ;
        ((self.ui).tex_typeName):SetIndex(0, (LanguageUtil.GetLocaleText)(sectorCfg.type_name))
      end
      -- DECOMPILER ERROR at PC90: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).img_SectorPic).texture = ExplorationManager:GetSectorHeadTexture(self.curSectorId, nil, nil, self.resloader)
      ;
      ((self.ui).tex_name):SetIndex(0)
      ;
      ((self.ui).tex_typeName):SetIndex(1)
      -- DECOMPILER ERROR: 8 unprocessed JMP targets
    end
  end
end

UISectorTask.CutDownTime = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local remaindTime = (math.max)((math.floor)(self.nextRefreshTimeStamp - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimestampToTimeInter(remaindTime, false, true)
  if h < 10 or not tostring(h) then
    local hStr = "0" .. tostring(h)
  end
  if m < 10 or not tostring(m) then
    local mStr = "0" .. tostring(m)
  end
  if s < 10 or not tostring(s) then
    local sStr = "0" .. tostring(s)
  end
  if d > 0 then
    ((self.ui).tex_TaskTime):SetIndex(0, tostring(d), hStr, mStr, sStr)
  else
    ;
    ((self.ui).tex_TaskTime):SetIndex(1, hStr, mStr, sStr)
  end
  if remaindTime <= 0 and self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
end

UISectorTask.__RefreshTaskCount = function(self)
  -- function num : 0_5 , upvalues : _ENV, TaskEnum
  local totalCount = #self.sectorTaskDatas
  local pickCount = 0
  for _,data in ipairs(self.sectorTaskDatas) do
    if data.state == (TaskEnum.eTaskState).Picked then
      pickCount = pickCount + 1
    end
  end
  do
    if pickCount <= 9 or not tostring(pickCount) then
      local strPick = "0" .. tostring(pickCount)
    end
    if totalCount <= 9 or not tostring(totalCount) then
      local strTotal = "0" .. tostring(totalCount)
    end
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_TaskCount).text = strPick .. "/" .. strTotal
  end
end

UISectorTask.__RefreshAchivTaskUI = function(self)
  -- function num : 0_6 , upvalues : TaskUIType, _ENV, TaskEnum
  if self.taskUIType == TaskUIType.Sector then
    self.sectorTaskDatas = (self.SectorTaskController):GetSectorTaskDatas(self.curSectorId)
    self:__RefreshTaskCount()
  else
    local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
    local taskDataDic, _ = taskCtrl:GetDatas4Task((TaskEnum.eTaskType).WeeklyChallengeTask)
    self.sectorTaskDatas = {}
    for _,data in pairs(taskDataDic) do
      (table.insert)(self.sectorTaskDatas, data)
    end
    self:SortTaskData()
  end
  do
    local num = #self.sectorTaskDatas
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).loop_taskScroll).totalCount = num
    ;
    ((self.ui).loop_taskScroll):RefreshCells()
  end
end

UISectorTask.__OnNewItem = function(self, go)
  -- function num : 0_7 , upvalues : UINSectorTaskItem
  local taskItem = (UINSectorTaskItem.New)()
  taskItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = taskItem
end

UISectorTask.__OnChangeItem = function(self, go, index)
  -- function num : 0_8 , upvalues : _ENV
  local taskItem = (self.itemDic)[go]
  if taskItem == nil then
    error("Can\'t find goodItem by gameObject")
    return 
  end
  local taskData = (self.sectorTaskDatas)[index + 1]
  taskItem:RefreshSectorTaskItem(taskData, self.taskUIType - 1, BindCallback(self, self.ItemClicked))
end

UISectorTask.ItemClicked = function(self, taskData)
  -- function num : 0_9 , upvalues : _ENV
  if (GR.EnableTaskLog)() then
    print((string.format)("[Dev]TaskId:%s, stepId:%s", (taskData.stcData).id, 1))
  end
  if taskData:CheckComplete() and not self.isPicking then
    self.isPicking = true
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Task)):SendCommitQuest(taskData, function()
    -- function num : 0_9_0 , upvalues : _ENV, self
    AudioManager:PlayAudioById(1120)
    self.isPicking = false
  end
)
  end
end

UISectorTask.__RefillTaskList = function(self)
  -- function num : 0_10 , upvalues : _ENV, TaskUIType, TaskEnum
  local oldNum = (table.count)(self.sectorTaskDatas)
  if self.taskUIType == TaskUIType.Sector then
    self.sectorTaskDatas = (self.SectorTaskController):GetSectorTaskDatas(self.curSectorId)
    self:__RefreshTaskCount()
  else
    local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
    local taskDataDic, _ = taskCtrl:GetDatas4Task((TaskEnum.eTaskType).WeeklyChallengeTask)
    self.sectorTaskDatas = {}
    for _,data in pairs(taskDataDic) do
      (table.insert)(self.sectorTaskDatas, data)
    end
    self:SortTaskData()
  end
  do
    local num = #self.sectorTaskDatas
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

    if oldNum <= num then
      ((self.ui).loop_taskScroll).totalCount = num
      ;
      ((self.ui).loop_taskScroll):RefillCells()
    else
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).loop_taskScroll).totalCount = num
      ;
      ((self.ui).loop_taskScroll):RefreshCells()
    end
  end
end

UISectorTask.SortTaskData = function(self)
  -- function num : 0_11 , upvalues : _ENV, TaskEnum
  if self.sectorTaskDatas == nil then
    return 
  end
  ;
  (table.sort)(self.sectorTaskDatas, function(a, b)
    -- function num : 0_11_0 , upvalues : TaskEnum
    if (not a:CheckComplete() or not 0) and not a.state then
      local aState = (TaskEnum.eTaskState).Picked
    end
    if (not b:CheckComplete() or not 0) and not b.state then
      local bState = (TaskEnum.eTaskState).Picked
    end
    if aState >= bState then
      do return aState == bState end
      do return a.id < b.id end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
end

UISectorTask.__RefreshSectorAchivUI = function(self)
  -- function num : 0_12 , upvalues : TaskUIType, _ENV, TaskEnum
  self.starId = nil
  local starCount, starTotalCount, sectorAchivDatas, starCountList = nil, nil, nil, nil
  if self.taskUIType == TaskUIType.Sector then
    self.starId = (self.SectorTaskController):GetSectorAchievementScore(self.curSectorId)
    starTotalCount = (self.SectorTaskController):GetSectorTaskTotalCount(self.starId, self.curSectorId)
    self.sectorAchivDatas = (self.SectorTaskController):GetSectorAchievementDatas(self.curSectorId)
    starCountList = {}
    for i,data in ipairs(self.sectorAchivDatas) do
      starCountList[i] = ((data.achiveCfg).conditionNums)[1]
    end
  else
    do
      local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
      self.sectorAchivDatas = taskCtr:GetDatas4Peroid((TaskEnum.eTaskPeriodType).WeeklyChallengeTask)
      self.starId = (((self.sectorAchivDatas)[1]).stcData).activeId
      -- DECOMPILER ERROR at PC56: Overwrote pending register: R1 in 'AssignReg'

      starTotalCount = 0
      starCountList = {}
      for i,data in ipairs(self.sectorAchivDatas) do
        starTotalCount = (data.stcData).activeNum
        starCountList[i] = starTotalCount
      end
      do
        local numPlaceFunc = function(num)
    -- function num : 0_12_0
    if num < 0 then
      num = -num
    end
    local res = 0
    while num >= 1 do
      num = num / 10
      res = res + 1
    end
    return res
  end

        local totalCountPlace = numPlaceFunc(starTotalCount < 10 and 10 or starTotalCount)
        local starCountPlace = numPlaceFunc(starCount)
        -- DECOMPILER ERROR at PC85: Confused about usage of register: R8 in 'UnsetPending'

        if starCountPlace == totalCountPlace then
          ((self.ui).tex_Trim).text = ""
        else
          local placeDiff = totalCountPlace - starCountPlace
          local str = ""
          for i = 1, placeDiff do
            str = str .. "0"
          end
          -- DECOMPILER ERROR at PC99: Confused about usage of register: R10 in 'UnsetPending'

          ;
          ((self.ui).tex_Trim).text = str
        end
        do
          -- DECOMPILER ERROR at PC105: Confused about usage of register: R8 in 'UnsetPending'

          ;
          ((self.ui).tex_Point).text = tostring(starCount)
          local fillAmount = 0
          if starTotalCount ~= 0 then
            fillAmount = starCount / starTotalCount
          end
          if not self.initTween then
            ((self.ui).img_Process):DOKill(true)
            ;
            ((self.ui).img_Process):DOFillAmount(fillAmount, 0.35)
          else
            -- DECOMPILER ERROR at PC127: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self.ui).img_Process).fillAmount = fillAmount
            self.initTween = false
          end
          ;
          (self.rewardItemPool):HideAll()
          for index,achivData in ipairs(self.sectorAchivDatas) do
            local item = ((self.rewardItemPool):GetOne())
            local state, pointCount = nil, nil
            if self.taskUIType == TaskUIType.Sector then
              state = achivData.state
              pointCount = starCountList[index]
            else
              state = achivData.stateType
              pointCount = starCountList[index]
            end
            item:InitSectorTaskAchiveItem(index, state, self.taskUIType - 1, pointCount, self.__OnClickPeriodFunc)
            local pos = Vector3.zero
            if starTotalCount ~= 0 then
              pos = (Vector3.New)(pointCount / starTotalCount * self.achivParentWidth, 0, 0)
            end
            -- DECOMPILER ERROR at PC171: Confused about usage of register: R18 in 'UnsetPending'

            ;
            (item.transform).localPosition = pos
          end
        end
      end
    end
  end
end

UISectorTask.__OnItemUpdate = function(self, itemIdList)
  -- function num : 0_13 , upvalues : TaskUIType, _ENV
  if self.starId == nil or itemIdList[self.starId] == nil then
    return 
  end
  if self.taskUIType == TaskUIType.Sector then
    (PlayerDataCenter.sectorAchievementDatas):UpdateSectorAchivRedDot(self.curSectorId)
    self:__RefreshSectorAchivUI()
  end
end

UISectorTask.__ShowAchivRewardsFloatWin = function(self, rewardItem, achivRewardIds, achivRewardNums)
  -- function num : 0_14 , upvalues : HAType, VAType, _ENV
  (self.viewReward):FloatTo(rewardItem.transform, HAType.autoCenter, VAType.up)
  ;
  (self.viewReward):RefreshItems(achivRewardIds, achivRewardNums)
  ;
  (self.viewReward):Show()
  AudioManager:PlayAudioById(1055)
end

UISectorTask.OnClickPeriodItem = function(self, item, index)
  -- function num : 0_15 , upvalues : TaskUIType, TaskEnum, _ENV
  local data = (self.sectorAchivDatas)[index]
  if self.taskUIType == TaskUIType.Sector then
    if data.state == (TaskEnum.eTaskState).Completed then
      item:SetPicking(true)
      self._heroIdSnapShoot = PlayerDataCenter:GetHeroIdSnapShoot()
      ;
      (NetworkManager:GetNetwork(NetworkTypeID.Sector)):SendPickReward(self.curSectorId, (data.achiveCfg).id, function()
    -- function num : 0_15_0 , upvalues : item, _ENV, data, self
    item:SetPicking(false)
    AudioManager:PlayAudioById(1120)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_15_0_0 , upvalues : data, self
      if window == nil then
        return 
      end
      local rewardIds = (data.achiveCfg).achivRewardIds
      local rewardNums = (data.achiveCfg).achivRewardNums
      window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot)
    end
)
  end
)
    else
      self:__ShowAchivRewardsFloatWin(item, (data.achiveCfg).achivRewardIds, (data.achiveCfg).achivRewardNums)
    end
  else
    if data.stateType == (TaskEnum.eTaskState).Completed then
      local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
      taskCtr:SendCommitTaskPeriod(index, (TaskEnum.eTaskPeriodType).WeeklyChallengeTask)
    else
      do
        self:__ShowAchivRewardsFloatWin(item, (data.stcData).rewardIds, (data.stcData).rewardNums)
      end
    end
  end
end

UISectorTask.__OnClickReturn = function(self)
  -- function num : 0_16
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  self:Delete()
end

UISectorTask.OnDelete = function(self)
  -- function num : 0_17 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__refillTaskList)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__refillTaskList)
  MsgCenter:RemoveListener(eMsgEventId.TaskCommitComplete, self.__refillTaskList)
  MsgCenter:RemoveListener(eMsgEventId.SectorPickReward, self.__refreshSectorAchivUI)
  MsgCenter:RemoveListener(eMsgEventId.PeroidUpdate, self.__refreshSectorAchivUI)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  ;
  (base.OnDelete)(self)
end

return UISectorTask

