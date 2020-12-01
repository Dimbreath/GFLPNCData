-- params : ...
-- function num : 0 , upvalues : _ENV
local TimePassController = class("TimePassController", ControllerBase)
local base = ControllerBase
local TimePassFunc = require("Game.TimePass.TimePassFunc")
TimePassController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.timestampList = {}
  self.timestampDataDic = {}
  self.dataDic = {}
  self.couldUpdate = true
  self.__OnUpdate = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__OnUpdate)
end

TimePassController.AddRefreshTimePoint = function(self, m_id, data)
  -- function num : 0_1 , upvalues : _ENV
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
      ;
      (table.insert)((self.timestampDataDic)[timestamp], data)
    else
      ;
      (table.insert)((self.timestampDataDic)[timestamp], data)
    end
    self.couldUpdate = true
  end
end

TimePassController.RemoveRefreshTimePoint = function(self, m_id)
  -- function num : 0_2 , upvalues : _ENV
  self.couldUpdate = false
  local data = (self.dataDic)[m_id]
  local oldNextRefreshTimePoint = self:GetNextRefreshTimePoint()
  local timestamp = data.nextExpiredTm
  local dataList = (self.timestampDataDic)[timestamp]
  if dataList ~= nil then
    (table.removebyvalue)(dataList, data)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

    if #dataList == 0 then
      (self.timestampDataDic)[timestamp] = nil
    end
  end
  self.couldUpdate = true
end

TimePassController.GetNextRefreshTimePoint = function(self)
  -- function num : 0_3
  return (self.timestampList)[1]
end

TimePassController.OnUpdate = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if not self.couldUpdate then
    return 
  end
  local NextRefreshTimePoint = self:GetNextRefreshTimePoint()
  if NextRefreshTimePoint ~= nil and NextRefreshTimePoint < (math.floor)(PlayerDataCenter.timestamp) then
    self.couldUpdate = false
    self:OnTimeUp()
  end
end

TimePassController.OnTimeUp = function(self)
  -- function num : 0_5 , upvalues : _ENV, TimePassFunc
  local curTimestamp = self:GetNextRefreshTimePoint()
  local dataList = (self.timestampDataDic)[curTimestamp]
  local moduleRefreshTables = {}
  for _,data in ipairs(dataList) do
    local func = TimePassFunc[data.moduleId]
    if func == nil then
      error((string.format)("At timestamp %s can\'t find func for moduleId:%s", curTimestamp, data.moduleId))
    else
      func(data, moduleRefreshTables)
    end
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.timestampDataDic)[curTimestamp] = nil
  ;
  (table.remove)(self.timestampList, 1)
  self.couldUpdate = true
end

TimePassController.InitTimePassData = function(self)
  -- function num : 0_6 , upvalues : _ENV, TimePassController
  (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_COUNTER_Detail(function(args)
    -- function num : 0_6_0 , upvalues : _ENV, TimePassController, self
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
  end
)
end

TimePassController.OnUpdateTimePassData = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, TimePassController
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
  end
  local delete = msg.delete
  for m_id,_ in pairs(delete) do
    local moduleId = m_id >> 54
    if (TimePassController.isModuleAdd2List)(moduleId) and (self.dataDic)[m_id] ~= nil then
      self:RemoveRefreshTimePoint(m_id)
    end
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.dataDic)[m_id] = nil
  end
end

TimePassController.isModuleAdd2List = function(moduleId)
  -- function num : 0_8 , upvalues : _ENV
  do return moduleId < proto_object_CounterModule.CounterModuleSeperate end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TimePassController.getCounterElemData = function(self, moduleId, spcifyId)
  -- function num : 0_9
  local id = moduleId << 54 | spcifyId
  return (self.dataDic)[id]
end

TimePassController.GetLogicWeekNum = function(self, nextExpiredTm)
  -- function num : 0_10 , upvalues : _ENV
  local timePassData = self:getCounterElemData(proto_object_CounterModule.CounterModuleGlobalDailyFlush, 0)
  local nextExpiredTm = timePassData.nextExpiredTm
  local nowTm = PlayerDataCenter.timestamp
  local hour = (TimestampToDate(nextExpiredTm)).hour
  local logicTime = (math.ceil)(nowTm - hour * 3600 + 1)
  local weekNum = (TimestampToDate(logicTime)).wday
  if weekNum == 1 then
    return 7
  else
    return weekNum - 1
  end
end

TimePassController.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnDelete)(self)
end

return TimePassController

-- params : ...
-- function num : 0 , upvalues : _ENV
local TimePassController = class("TimePassController", ControllerBase)
local base = ControllerBase
local TimePassFunc = require("Game.TimePass.TimePassFunc")
TimePassController.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.timestampList = {}
    self.timestampDataDic = {}
    self.dataDic = {}
    self.couldUpdate = true
    self.__OnUpdate = BindCallback(self, self.OnUpdate)
    UpdateManager:AddUpdate(self.__OnUpdate)
end

TimePassController.AddRefreshTimePoint =
    function(self, m_id, data)
        -- function num : 0_1 , upvalues : _ENV
        self.couldUpdate = false
        local timestamp = data.nextExpiredTm
        local curTimestamp = (self:GetNextRefreshTimePoint())
        local isInserted = nil
        for index, timestampInList in ipairs(self.timestampList) do
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
                (self.timestampDataDic)[timestamp] = {};
                (table.insert)((self.timestampDataDic)[timestamp], data)
            else

                (table.insert)((self.timestampDataDic)[timestamp], data)
            end
            self.couldUpdate = true
        end
    end

TimePassController.RemoveRefreshTimePoint =
    function(self, m_id)
        -- function num : 0_2 , upvalues : _ENV
        self.couldUpdate = false
        local data = (self.dataDic)[m_id]
        local oldNextRefreshTimePoint = self:GetNextRefreshTimePoint()
        local timestamp = data.nextExpiredTm
        local dataList = (self.timestampDataDic)[timestamp]
        if dataList ~= nil then
            (table.removebyvalue)(dataList, data)
            -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

            if #dataList == 0 then
                (self.timestampDataDic)[timestamp] = nil
            end
        end
        self.couldUpdate = true
    end

TimePassController.GetNextRefreshTimePoint =
    function(self)
        -- function num : 0_3
        return (self.timestampList)[1]
    end

TimePassController.OnUpdate = function(self)
    -- function num : 0_4 , upvalues : _ENV
    if not self.couldUpdate then return end
    local NextRefreshTimePoint = self:GetNextRefreshTimePoint()
    if NextRefreshTimePoint ~= nil and NextRefreshTimePoint <
        (math.floor)(PlayerDataCenter.timestamp) then
        self.couldUpdate = false
        self:OnTimeUp()
    end
end

TimePassController.OnTimeUp = function(self)
    -- function num : 0_5 , upvalues : _ENV, TimePassFunc
    local curTimestamp = self:GetNextRefreshTimePoint()
    local dataList = (self.timestampDataDic)[curTimestamp]
    local moduleRefreshTables = {}
    for _, data in ipairs(dataList) do
        local func = TimePassFunc[data.moduleId]
        if func == nil then
            error((string.format)(
                      "At timestamp %s can\'t find func for moduleId:%s",
                      curTimestamp, data.moduleId))
        else
            func(data, moduleRefreshTables)
        end
    end -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'
    
    (self.timestampDataDic)[curTimestamp] = nil;
    (table.remove)(self.timestampList, 1)
    self.couldUpdate = true
end

TimePassController.InitTimePassData = function(self)
    -- function num : 0_6 , upvalues : _ENV, TimePassController
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_COUNTER_Detail(
        function(args)
            -- function num : 0_6_0 , upvalues : _ENV, TimePassController, self
            if args ~= nil and args.Count > 0 then
                local CounterSeriesData = args[0]
                for m_id, CounterElem in pairs(CounterSeriesData.data) do
                    local moduleId = CounterElem.moduleId
                    if (TimePassController.isModuleAdd2List)(moduleId) then
                        self:AddRefreshTimePoint(m_id, CounterElem)
                    end -- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'
                    
                    (self.dataDic)[m_id] = CounterElem
                end
            end
        end)
end

TimePassController.OnUpdateTimePassData =
    function(self, msg)
        -- function num : 0_7 , upvalues : _ENV, TimePassController
        local update = msg.update
        for m_id, CounterElem in pairs(update) do
            local moduleId = CounterElem.moduleId
            if (TimePassController.isModuleAdd2List)(moduleId) then
                if (self.dataDic)[m_id] ~= nil then
                    self:RemoveRefreshTimePoint(m_id)
                end
                self:AddRefreshTimePoint(m_id, CounterElem)
            end -- DECOMPILER ERROR at PC23: Confused about usage of register: R9 in 'UnsetPending'
            
            (self.dataDic)[m_id] = CounterElem
        end
        local delete = msg.delete
        for m_id, _ in pairs(delete) do
            local moduleId = m_id >> 54
            if (TimePassController.isModuleAdd2List)(moduleId) and
                (self.dataDic)[m_id] ~= nil then
                self:RemoveRefreshTimePoint(m_id)
            end -- DECOMPILER ERROR at PC45: Confused about usage of register: R10 in 'UnsetPending'
            
            (self.dataDic)[m_id] = nil
        end
    end

TimePassController.isModuleAdd2List = function(moduleId)
    -- function num : 0_8 , upvalues : _ENV
    do return moduleId < proto_object_CounterModule.CounterModuleSeperate end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TimePassController.getCounterElemData = function(self, moduleId, spcifyId)
    -- function num : 0_9
    local id = moduleId << 54 | spcifyId
    return (self.dataDic)[id]
end

TimePassController.GetLogicWeekNum = function(self, nextExpiredTm)
    -- function num : 0_10 , upvalues : _ENV
    local timePassData = self:getCounterElemData(
                             proto_object_CounterModule.CounterModuleGlobalDailyFlush,
                             0)
    local nextExpiredTm = timePassData.nextExpiredTm
    local nowTm = PlayerDataCenter.timestamp
    local hour = (TimestampToDate(nextExpiredTm)).hour
    local logicTime = (math.ceil)(nowTm - hour * 3600 + 1)
    local weekNum = (TimestampToDate(logicTime)).wday
    if weekNum == 1 then
        return 7
    else
        return weekNum - 1
    end
end

TimePassController.OnDelete = function(self)
    -- function num : 0_11 , upvalues : base
    (base.OnDelete)(self)
end

return TimePassController

