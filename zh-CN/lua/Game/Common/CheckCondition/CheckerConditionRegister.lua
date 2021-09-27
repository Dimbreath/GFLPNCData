local CheckerConditionRegister = class("CheckerConditionRegister")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
CheckerConditionRegister.AddCheckerNode = function(self, ...)
  -- function num : 0_0 , upvalues : _ENV, CheckerTypeId
  local paramNum = select("#", ...)
  if paramNum == 0 then
    print("[CheckCondition] not args")
    return false
  end
  local preConditions = select(1, ...)
  local length = #preConditions
  for i = 2, paramNum do
    local para = select(i, ...)
    local len = #para
    if len > 0 and len ~= length then
      print("[CheckCondition] args length is different")
      return false
    end
  end
  for i,preCondition in ipairs(preConditions) do
    if preCondition == CheckerTypeId.TimeRange and paramNum >= 3 then
      local paraStart = select(2, ...)
      local startTime = paraStart[i]
      local paraEnd = select(3, ...)
      local endTime = paraEnd[i] or 0
      self:_AddTimeCoditionNode(startTime, endTime)
    end
  end
end

CheckerConditionRegister._AddTimeCoditionNode = function(self, startTime, endTime)
  -- function num : 0_1 , upvalues : _ENV
  local InsertToArray = function(arg, array)
    -- function num : 0_1_0 , upvalues : _ENV
    local left = 1
    local right = #array
    local mid = nil
    while 1 do
      while 1 do
        if left <= right then
          mid = (left + right) // 2
          if arg <= array[mid] then
            left = mid + 1
            -- DECOMPILER ERROR at PC11: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC11: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC11: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC11: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      right = mid - 1
    end
    ;
    (table.insert)(array, left, arg)
  end

  if startTime > 0 and PlayerDataCenter.timestamp < startTime then
    if self.timeList == nil then
      self.timeList = {}
    end
    InsertToArray(startTime, self.timeList)
  end
  if endTime > 0 and PlayerDataCenter.timestamp < endTime then
    if self.timeList == nil then
      self.timeList = {}
    end
    InsertToArray(endTime, self.timeList)
  end
  if self.timeList ~= nil and #self.timeList > 0 and self.timerId == nil then
    self.timerId = TimerManager:StartTimer(1, function()
    -- function num : 0_1_1 , upvalues : self
    self:_TimeLoop()
  end
, self, false, false, false)
  end
end

CheckerConditionRegister._TimeLoop = function(self)
  -- function num : 0_2 , upvalues : _ENV, CheckerTypeId
  local isThrounghNode = false
  local timestamp = PlayerDataCenter.timestamp
  for i = #self.timeList, 1, -1 do
    if timestamp >= (self.timeList)[i] then
      do
        isThrounghNode = true
        -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self.timeList)[i] = nil
        -- DECOMPILER ERROR at PC15: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC15: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if #self.timeList == 0 then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if isThrounghNode then
    MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.TimeRange)
  end
end

return CheckerConditionRegister

