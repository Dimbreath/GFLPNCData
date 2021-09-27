TimelineUtil = {}
local cs_coroutine = require("XLua.Common.cs_coroutine")
-- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

TimelineUtil.Rewind = function(director, endEvent, endNoStop, startWithCurrent, useUnscaledTime, updateCallback)
  -- function num : 0_0 , upvalues : cs_coroutine, _ENV
  if not startWithCurrent then
    startWithCurrent = false
  end
  if not useUnscaledTime then
    useUnscaledTime = false
  end
  if not endNoStop then
    endNoStop = false
  end
  return (cs_coroutine.start)(function()
    -- function num : 0_0_0 , upvalues : startWithCurrent, director, _ENV, useUnscaledTime, updateCallback, endEvent, endNoStop
    if not startWithCurrent then
      director.time = director.duration
    end
    director.initialTime = director.duration
    director:Evaluate()
    ;
    (coroutine.yield)(nil)
    while 1 do
      if director.time > 0 then
        do
          if not useUnscaledTime or not Time.unscaledDeltaTime then
            local curDeltaTime = Time.deltaTime
          end
          director.time = director.time - curDeltaTime
          if director.time < 0 then
            director.time = 0
          end
          director:Evaluate()
          if updateCallback ~= nil then
            updateCallback()
          end
          ;
          (coroutine.yield)(nil)
          -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    if endEvent ~= nil then
      endEvent()
    end
    if not endNoStop then
      director:Stop()
    end
  end
)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

TimelineUtil.Play = function(director, endEvent, startWithCurrent, endNoStop, useUnscaledTime, updateCallback, playRate)
  -- function num : 0_1 , upvalues : cs_coroutine, _ENV
  if not useUnscaledTime then
    useUnscaledTime = false
  end
  if not startWithCurrent then
    startWithCurrent = false
  end
  if not endNoStop then
    endNoStop = false
  end
  director.initialTime = -1
  return (cs_coroutine.start)(function()
    -- function num : 0_1_0 , upvalues : director, startWithCurrent, _ENV, useUnscaledTime, playRate, updateCallback, endEvent, endNoStop
    local duration = director.duration
    if not startWithCurrent then
      director.time = 0
      director:Evaluate()
      ;
      (coroutine.yield)(nil)
    end
    while 1 do
      if director.time < duration then
        do
          if not useUnscaledTime or not Time.unscaledDeltaTime then
            local curDeltaTime = Time.deltaTime
          end
          curDeltaTime = curDeltaTime * (playRate or 1)
          director.time = director.time + curDeltaTime
          if duration < director.time then
            director.time = duration
          end
          director:Evaluate()
          if updateCallback ~= nil then
            updateCallback()
          end
          ;
          (coroutine.yield)(nil)
          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    if endEvent ~= nil then
      endEvent()
    end
    if not endNoStop then
      director:Stop()
    end
  end
)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

TimelineUtil.StopTlCo = function(coroutine)
  -- function num : 0_2 , upvalues : cs_coroutine
  (cs_coroutine.stop)(coroutine)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

TimelineUtil.StopAll = function()
  -- function num : 0_3 , upvalues : cs_coroutine
  (cs_coroutine.stopall)()
end


