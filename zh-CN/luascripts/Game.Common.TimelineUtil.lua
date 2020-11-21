-- params : ...
-- function num : 0 , upvalues : _ENV
TimelineUtil = {}
local cs_coroutine = require("XLua.Common.cs_coroutine")
-- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

TimelineUtil.Rewind = function(director, endEvent)
    -- function num : 0_0 , upvalues : cs_coroutine, _ENV
    return (cs_coroutine.start)(function()
        -- function num : 0_0_0 , upvalues : director, _ENV, endEvent
        director.time = director.duration
        director.initialTime = director.duration
        director:Evaluate();
        (coroutine.yield)(nil)
        while director.time > 0 do
            director.time = director.time - Time.deltaTime
            if director.time < 0 then director.time = 0 end
            director:Evaluate();
            (coroutine.yield)(nil)
        end
        if endEvent ~= nil then endEvent() end
        director:Stop()
    end)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

TimelineUtil.Play = function(director, endEvent, startWithCurrent)
    -- function num : 0_1 , upvalues : cs_coroutine, _ENV
    if not startWithCurrent then startWithCurrent = false end
    director.initialTime = -1
    return (cs_coroutine.start)(function()
        -- function num : 0_1_0 , upvalues : director, startWithCurrent, _ENV, endEvent
        local duration = director.duration
        if not startWithCurrent then
            director.time = 0
            director:Evaluate();
            (coroutine.yield)(nil)
        end
        while director.time < duration do
            director.time = director.time + Time.deltaTime
            if duration < director.time then director.time = duration end
            director:Evaluate();
            (coroutine.yield)(nil)
        end
        if endEvent ~= nil then endEvent() end
        director:Stop()
    end)
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

