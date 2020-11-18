-- params : ...
-- function num : 0 , upvalues : _ENV
local rawget = rawget
local unity_time = (CS.UnityEngine).Time
local _Time = {deltaTime = 0, fixedDeltaTime = 0, maximumDeltaTime = 0.3333333, fixedTime = 0, frameCount = 1, realtimeSinceStartup = 0, time = 0, timeScale = 1, timeSinceLevelLoad = 0, unscaledDeltaTime = 0, unscaledTime = 0}
local _set = {}
_set.fixedDeltaTime = function(v)
  -- function num : 0_0 , upvalues : _Time, unity_time
  _Time.fixedDeltaTime = v
  unity_time.fixedDeltaTime = v
end

_set.maximumDeltaTime = function(v)
  -- function num : 0_1 , upvalues : _Time, unity_time
  _Time.maximumDeltaTime = v
  unity_time.maximumDeltaTime = v
end

_set.timeScale = function(v)
  -- function num : 0_2 , upvalues : _Time, unity_time
  _Time.timeScale = v
  unity_time.timeScale = v
end

_set.captureFramerate = function(v)
  -- function num : 0_3 , upvalues : _Time, unity_time
  _Time.captureFramerate = v
  unity_time.captureFramerate = v
end

_set.timeSinceLevelLoad = function(v)
  -- function num : 0_4 , upvalues : _Time
  _Time.timeSinceLevelLoad = v
end

_Time.__index = function(t, k)
  -- function num : 0_5 , upvalues : rawget, _Time, unity_time
  local var = rawget(_Time, k)
  if var then
    return var
  end
  return (unity_time.__index)(unity_time, k)
end

_Time.__newindex = function(t, k, v)
  -- function num : 0_6 , upvalues : rawget, _set, _ENV
  local func = rawget(_set, k)
  if func then
    return func(v)
  end
  error((string.format)("Property or indexer `CS.UnityEngine.Time.%s\' cannot be assigned to (it is read only)", k))
end

local Time = {}
local counter = 1
Time.SetDeltaTime = function(self, deltaTime, unscaledDeltaTime)
  -- function num : 0_7 , upvalues : _Time, counter, unity_time
  local _Time = _Time
  _Time.deltaTime = deltaTime
  _Time.unscaledDeltaTime = unscaledDeltaTime
  counter = counter - 1
  if counter == 0 and unity_time then
    _Time.time = unity_time.time
    _Time.timeSinceLevelLoad = unity_time.timeSinceLevelLoad
    _Time.unscaledTime = unity_time.unscaledTime
    _Time.realtimeSinceStartup = unity_time.realtimeSinceStartup
    _Time.frameCount = unity_time.frameCount
    counter = 1000000
  else
    _Time.time = _Time.time + deltaTime
    _Time.realtimeSinceStartup = _Time.realtimeSinceStartup + unscaledDeltaTime
    _Time.timeSinceLevelLoad = _Time.timeSinceLevelLoad + deltaTime
    _Time.unscaledTime = _Time.unscaledTime + unscaledDeltaTime
  end
end

Time.SetFixedDelta = function(self, fixedDeltaTime)
  -- function num : 0_8 , upvalues : _Time
  _Time.deltaTime = fixedDeltaTime
  _Time.fixedDeltaTime = fixedDeltaTime
  _Time.fixedTime = _Time.fixedTime + fixedDeltaTime
end

Time.SetFrameCount = function(self)
  -- function num : 0_9 , upvalues : _Time
  _Time.frameCount = _Time.frameCount + 1
end

Time.SetTimeScale = function(self, scale)
  -- function num : 0_10 , upvalues : _Time, unity_time
  local last = _Time.timeScale
  _Time.timeScale = scale
  unity_time.timeScale = scale
  return last
end

Time.GetTimestamp = function(self)
  -- function num : 0_11 , upvalues : _ENV
  return gettime()
end

Time.unity_time = unity_time
-- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

;
(CS.UnityEngine).Time = Time
setmetatable(Time, _Time)
if unity_time ~= nil then
  _Time.maximumDeltaTime = unity_time.maximumDeltaTime
  _Time.timeScale = unity_time.timeScale
end
return Time

