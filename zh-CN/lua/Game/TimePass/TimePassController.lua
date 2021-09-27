local TimePassController = class("TimePassController", ControllerBase)
local base = ControllerBase
local TimePassFunc = require("Game.TimePass.TimePassFunc")
local TimePassPostprocessFunc = require("Game.TimePass.TimePassPostprocessFunc")
local TimePassOrder = {proto_object_CounterModule.CounterModuleWeeklyChallengeFresh << 54, proto_object_CounterModule.CounterModuleGlobalDailyFlush << 54}
TimePassController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.timestampList = {}
  self.timestampDataDic = {}
  self.dataDic = {}
  self:_InitEventTimer()
  self.couldUpdate = true
  self.__OnUpdate = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__OnUpdate)
end

TimePassController._InitEventTimer = function(self)
  -- function num : 0_1
  self.eventTimerDic = {}
  self.nextEventTimestamp = nil
end

TimePassController.AddEventTimer = function(self, timestamp, event)
  -- function num : 0_2
  if not (self.eventTimerDic)[timestamp] then
    local eventDic = {}
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  if (self.eventTimerDic)[timestamp] == nil then
    (self.eventTimerDic)[timestamp] = eventDic
  end
  if self.nextEventTimestamp == nil or timestamp < self.nextEventTimestamp then
    self.nextEventTimestamp = timestamp
  end
  eventDic[event] = true
end

TimePassController._EventTimeIsUp = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local eventDic = (self.eventTimerDic)[self.nextEventTimestamp]
  if eventDic == nil then
    return 
  end
  for event,_ in pairs(eventDic) do
    event()
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.eventTimerDic)[self.nextEventTimestamp] = nil
  local earlist = nil
  for timestamp,v in pairs(self.eventTimerDic) do
    if earlist == nil or timestamp < earlist then
      earlist = timestamp
    end
  end
  self.nextEventTimestamp = earlist
end

TimePassController._UpdEventTimer = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.nextEventTimestamp ~= nil and self.nextEventTimestamp <= PlayerDataCenter.timestamp then
    self:_EventTimeIsUp()
  end
end

TimePassController.AddRefreshTimePoint = function(self, m_id, data)
  -- function num : 0_5 , upvalues : _ENV
  self.couldUpdate = false
  local timestamp = data.nextExpiredTm
  local curTimestamp = (self:GetNextRefreshTimePoint())
  local isInserted = nil
  for index,timestampInList in ipairs(self.timestampList) do
    if timestamp < timestampInList then
      (table.insert)(self.timestampList, index, timestamp)
      isInserted = true
      break
    else
      if timestamp == timestampInList then
        isInserted = true
        break
      end
    end
  end
  do
    if not isInserted then
      (table.insert)(self.timestampList, timestamp)
    end
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

    if (self.timestampDataDic)[timestamp] == nil then
      (self.timestampDataDic)[timestamp] = {}
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.timestampDataDic)[timestamp])[m_id] = data
    else
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.timestampDataDic)[timestamp])[m_id] = data
    end
    self.couldUpdate = true
  end
end

TimePassController.RemoveRefreshTimePoint = function(self, m_id)
  -- function num : 0_6 , upvalues : _ENV
  self.couldUpdate = false
  local data = (self.dataDic)[m_id]
  local oldNextRefreshTimePoint = self:GetNextRefreshTimePoint()
  local timestamp = data.nextExpiredTm
  local dataDic = (self.timestampDataDic)[timestamp]
  if dataDic ~= nil then
    dataDic[m_id] = nil
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    if (table.count)(dataDic) == 0 then
      (self.timestampDataDic)[timestamp] = nil
      ;
      (table.removebyvalue)(self.timestampList, timestamp)
    end
  end
  self.couldUpdate = true
end

TimePassController.GetNextRefreshTimePoint = function(self)
  -- function num : 0_7
  return (self.timestampList)[1]
end

TimePassController.OnUpdate = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self:_UpdEventTimer()
  if not self.couldUpdate then
    return 
  end
  local NextRefreshTimePoint = self:GetNextRefreshTimePoint()
  if NextRefreshTimePoint ~= nil and NextRefreshTimePoint < PlayerDataCenter.timestamp then
    self.couldUpdate = false
    self:OnTimeUp()
  end
end

TimePassController.OnTimeUp = function(self)
  -- function num : 0_9 , upvalues : _ENV, TimePassOrder, TimePassFunc
  local curTimestamp = self:GetNextRefreshTimePoint()
  local dataDic = (self.timestampDataDic)[curTimestamp]
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  if dataDic == nil then
    (self.timestampDataDic)[curTimestamp] = nil
    ;
    (table.removebyvalue)(self.timestampList, curTimestamp)
    return 
  end
  local moduleRefreshTables = {}
  for _,m_id in ipairs(TimePassOrder) do
    local data = dataDic[m_id]
    if data ~= nil then
      local func = TimePassFunc[data.moduleId]
      if func == nil then
        error((string.format)("At timestamp %s can\'t find func for moduleId:%s", curTimestamp, data.moduleId))
      else
        func(data, moduleRefreshTables)
      end
      dataDic[m_id] = nil
    end
  end
  for m_id,data in pairs(dataDic) do
    local func = TimePassFunc[data.moduleId]
    if func == nil then
      error((string.format)("At timestamp %s can\'t find func for moduleId:%s", curTimestamp, data.moduleId))
    else
      func(data, moduleRefreshTables)
    end
  end
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.timestampDataDic)[curTimestamp] = nil
  ;
  (table.remove)(self.timestampList, 1)
  self.couldUpdate = true
end

TimePassController.InitTimePassData = function(self, callback)
  -- function num : 0_10 , upvalues : _ENV, TimePassController
  (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_COUNTER_Detail(function(args)
    -- function num : 0_10_0 , upvalues : _ENV, TimePassController, self, callback
    if args ~= nil and args.Count > 0 then
      local CounterSeriesData = args[0]
      for m_id,CounterElem in pairs(CounterSeriesData.data) do
        local moduleId = CounterElem.moduleId
        if (TimePassController.isModuleAdd2List)(moduleId) then
          self:AddRefreshTimePoint(m_id, CounterElem)
        end
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.dataDic)[m_id] = CounterElem
      end
    end
    do
      callback()
    end
  end
)
end

TimePassController.OnUpdateTimePassData = function(self, msg)
  -- function num : 0_11 , upvalues : _ENV, TimePassController, TimePassPostprocessFunc
  local update = msg.update
  for m_id,CounterElem in pairs(update) do
    local moduleId = CounterElem.moduleId
    if (TimePassController.isModuleAdd2List)(moduleId) then
      if (self.dataDic)[m_id] ~= nil then
        self:RemoveRefreshTimePoint(m_id)
      end
      self:AddRefreshTimePoint(m_id, CounterElem)
    end
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.dataDic)[m_id] = CounterElem
    local func = TimePassPostprocessFunc[moduleId]
    if func ~= nil then
      func(true)
    end
  end
  local delete = msg.delete
  for m_id,_ in pairs(delete) do
    local moduleId = m_id >> 54
    if (TimePassController.isModuleAdd2List)(moduleId) and (self.dataDic)[m_id] ~= nil then
      self:RemoveRefreshTimePoint(m_id)
    end
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.dataDic)[m_id] = nil
    local func = TimePassPostprocessFunc[moduleId]
    if func ~= nil then
      func(false)
    end
  end
end

TimePassController.isModuleAdd2List = function(moduleId)
  -- function num : 0_12 , upvalues : _ENV
  do return moduleId < proto_object_CounterModule.CounterModuleSeperate end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TimePassController.getCounterElemData = function(self, moduleId, spcifyId)
  -- function num : 0_13
  local id = moduleId << 54 | spcifyId
  return (self.dataDic)[id]
end

TimePassController.GetLogicWeekNum = function(self, timeStamp)
  -- function num : 0_14 , upvalues : _ENV
  local timePassData = self:getCounterElemData(proto_object_CounterModule.CounterModuleGlobalDailyFlush, 0)
  local nextExpiredTm = timePassData.nextExpiredTm
  if not timeStamp then
    local nowTm = PlayerDataCenter.timestamp
  end
  local hour = (TimestampToDate(nextExpiredTm)).hour
  local logicTime = (math.ceil)(nowTm - hour * 3600 + 1)
  local weekNum = (TimestampToDate(logicTime)).wday
  if weekNum == 1 then
    return 7, nextExpiredTm
  else
    return weekNum - 1, nextExpiredTm
  end
end

TimePassController.GetIsLogicToday = function(self, timeStamp)
  -- function num : 0_15 , upvalues : _ENV
  local timePassData = self:getCounterElemData(proto_object_CounterModule.CounterModuleGlobalDailyFlush, 0)
  local nextExpiredTm = timePassData.nextExpiredTm
  if timePassData.nextExpiredTm - timeStamp < 86400 then
    return true
  end
end

TimePassController.GetCounterModuleDungeonEnter = function(self, dungeonId)
  -- function num : 0_16 , upvalues : _ENV
  local counterData = self:getCounterElemData(proto_object_CounterModule.CounterModuleDungeonEnter, dungeonId)
  local num = counterData ~= nil and counterData.times or 0
  return num
end

TimePassController.OnDelete = function(self)
  -- function num : 0_17 , upvalues : base
  (base.OnDelete)(self)
end

return TimePassController

