-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityController = class("ActivityController", ControllerBase)
local base = ControllerBase
local ActivityEnum = require("Game.Activity.ActivityEnum")
local ActivityInfo = require("Game.Activity.ActivityInfo")
local cs_playerData = (CS.PlayerDataCenter).Instance
ActivityController.ctor = function(self)
  -- function num : 0_0
  self.activityInfoDic = {}
  self.lockActIdDic = {}
  self.notOpenIdList = {}
end

ActivityController.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, cs_playerData
  self.__UnlockEvet = BindCallback(self, self.FunctionUnlockEvent)
  MsgCenter:AddListener(eMsgEventId.UnlockFunc, self.__UnlockEvet)
  self.__TaskComplect = BindCallback(self, self.TaskComplect)
  MsgCenter:AddListener(eMsgEventId.TaskCommitComplete, self.__TaskComplect)
  self.__TaskUpdate = BindCallback(self, self.TaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdate)
  local curTime = cs_playerData.timestamp
  for k,v in pairs(ConfigData.rookie_star) do
    if FunctionUnlockMgr:ValidateUnlock(v.system_id) then
      self:AddNewActInfo(k, true)
    else
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.lockActIdDic)[k] = v.system_id
    end
  end
  self:ResetTimer()
end

ActivityController.AddNewActInfo = function(self, id, ignoreTimer)
  -- function num : 0_2 , upvalues : ActivityInfo, ActivityEnum, _ENV
  if not ignoreTimer then
    ignoreTimer = false
  end
  local info = (ActivityInfo.CreateData)(id)
  local actState = info:GetState()
  if actState == (ActivityEnum.eActivityState).End then
    return actState
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.activityInfoDic)[id] = info
  if actState == (ActivityEnum.eActivityState).Open then
    self:RefreshRedDotData(id)
    return actState
  end
  local pos = 1
  for i = #self.notOpenIdList, 1, -1 do
    local actId = (self.notOpenIdList)[i]
    local openTime = ((self.activityInfoDic)[actId]).startTime
    if info.startTime < openTime then
      pos = i + 1
      break
    end
  end
  do
    ;
    (table.insert)(self.notOpenIdList, pos, id)
    if pos == #self.notOpenIdList and not ignoreTimer then
      self:ResetTimer()
    end
    return actState
  end
end

ActivityController.ResetTimer = function(self)
  -- function num : 0_3 , upvalues : cs_playerData, _ENV
  if #self.notOpenIdList == 0 then
    if self.timer ~= nil then
      (self.timer):Stop()
      self.timer = nil
    end
    return 
  end
  local actInfo = (self.activityInfoDic)[(self.notOpenIdList)[#self.notOpenIdList]]
  local timeDelay = cs_playerData.timestamp - actInfo.startTime
  if self.timer == nil then
    self.timer = TimerManager:GetTimer(timeDelay, self.TimerCallBack, self, true, false, false)
  else
    ;
    (self.timer):Stop()
    ;
    (self.timer):Init(timeDelay, self.TimerCallBack, self, true, false, false)
  end
  ;
  (self.timer):Start()
end

ActivityController.TimerCallBack = function(self)
  -- function num : 0_4 , upvalues : _ENV, ActivityEnum
  if #self.notOpenIdList == 0 then
    return 
  end
  local actId = (self.notOpenIdList)[#self.notOpenIdList]
  if ((self.activityInfoDic)[actId]):IsOpen() then
    (table.remove)(self.notOpenIdList, #self.notOpenIdList)
  else
    actId = nil
  end
  self:ResetTimer()
  if actId ~= nil then
    self:RefreshRedDotData(actId)
    MsgCenter:Broadcast(eMsgEventId.ActivityState, actId, (ActivityEnum.eActivityState).Open)
  end
end

ActivityController.GetActivityState = function(self, activityId)
  -- function num : 0_5 , upvalues : ActivityEnum
  if (self.lockActIdDic)[activityId] ~= nil then
    return (ActivityEnum.eActivityState).NotOpen
  end
  if (self.activityInfoDic)[activityId] ~= nil then
    return ((self.activityInfoDic)[activityId]):GetState()
  end
  return (ActivityEnum.eActivityState).End
end

ActivityController.GetOpenActivities = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local list = {}
  for key,value in pairs(self.activityInfoDic) do
    if value:IsOpen() then
      (table.insert)(list, value)
    end
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_6_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return list
end

ActivityController.GetInfo = function(self, activityId)
  -- function num : 0_7
  return (self.activityInfoDic)[activityId]
end

ActivityController.FunctionUnlockEvent = function(self, fid)
  -- function num : 0_8 , upvalues : _ENV, ActivityEnum
  local actIds = {}
  for k,v in pairs(self.lockActIdDic) do
    if v == fid then
      (table.insert)(actIds, k)
      break
    end
  end
  do
    if #actIds > 0 then
      for i,v in ipairs(actIds) do
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

        (self.lockActIdDic)[v] = nil
        local actState = self:AddNewActInfo(v)
        if actState == (ActivityEnum.eActivityState).Open then
          self:RefreshRedDotData(v)
          MsgCenter:Broadcast(eMsgEventId.ActivityState, v, (ActivityEnum.eActivityState).Open)
        end
      end
    end
  end
end

ActivityController.TaskComplect = function(self, taskCfg)
  -- function num : 0_9 , upvalues : _ENV, ActivityEnum
  for k,v in pairs(self.activityInfoDic) do
    if v.curStageId ~= nil and (((v.cfg).phase)[v.curStageId]).task == taskCfg.id then
      v:RefreshStage()
      self:RefreshRedDotData(v.id)
      MsgCenter:Broadcast(eMsgEventId.ActivityChange, v.id, taskCfg)
      if v:IsFinish() then
        MsgCenter:Broadcast(eMsgEventId.ActivityState, v.id, (ActivityEnum.eActivityState).End)
      end
    else
      if v.curStageId ~= nil and v:ContainsTask(taskCfg.id) then
        MsgCenter:Broadcast(eMsgEventId.ActivityChange, v.id, taskCfg)
        self:RedDotNumChange(v.id, -1)
      end
    end
  end
end

ActivityController.TaskUpdate = function(self, taskData)
  -- function num : 0_10 , upvalues : _ENV
  if taskData:CheckComplete() then
    for k,v in pairs(self.activityInfoDic) do
      if v.curStageId ~= nil and v:ContainsTask(taskData.id) then
        self:RedDotNumChange(v.id, 1)
      end
    end
  end
end

ActivityController.OpenStarUpPanel = function(self)
  -- function num : 0_11 , upvalues : ActivityEnum, _ENV
  local activityInfo = (self.activityInfoDic)[(ActivityEnum.eActivityFixedId).StarUp]
  if activityInfo ~= nil and activityInfo:IsOpen() and not activityInfo:IsFinish() then
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityStarUp, function(window)
    -- function num : 0_11_0 , upvalues : activityInfo
    if window ~= nil then
      window:InitWindow(activityInfo)
    end
  end
)
  end
end

ActivityController.RefreshRedDotData = function(self, activityId)
  -- function num : 0_12 , upvalues : _ENV
  local actInfo = (self.activityInfoDic)[activityId]
  if actInfo == nil then
    return 
  end
  local isHave, actNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Activity)
  if not isHave then
    error("未找到活动红点节点，请检查")
    return 
  end
  local childNode = actNode:AddChildWithPath(activityId, RedDotDynPath.ActivitySingle)
  local count = 0
  if actInfo.curStageId == nil then
    childNode:SetRedDotCount(count)
    return 
  end
  for i = 1, actInfo.curStageId do
    local mainTask, childTasks = actInfo:GetTasks(i, false, true)
    if mainTask ~= nil and mainTask:CheckComplete() then
      count = count + 1
    end
    for _,v in ipairs(childTasks) do
      if v:CheckComplete() then
        count = count + 1
      end
    end
  end
  childNode:SetRedDotCount(count)
end

ActivityController.RedDotNumChange = function(self, activityId, addVal)
  -- function num : 0_13 , upvalues : _ENV
  local isHave, actNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Activity, activityId)
  if not isHave then
    error("没有找到id为" .. activityId .. "的活动红点，请检查")
    return 
  end
  actNode:OffsetRedDotCount(addVal)
end

ActivityController.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UnlockFunc, self.__UnlockEvet)
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  ;
  (base.OnDelete)(self)
end

return ActivityController

