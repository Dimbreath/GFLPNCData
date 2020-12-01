-- params : ...
-- function num : 0 , upvalues : _ENV
local math = math
local floor = math.floor
local abs = math.abs
local Mathf = {}
local unity_mathf = (CS.UnityEngine).Mathf
Mathf.Deg2Rad = (math.rad)(1)
Mathf.Epsilon = 1.4013e-45
Mathf.Infinity = math.huge
Mathf.NegativeInfinity = -math.huge
Mathf.PI = math.pi
Mathf.Rad2Deg = (math.deg)(1)
Mathf.Abs = math.abs
Mathf.Acos = math.acos
Mathf.Asin = math.asin
Mathf.Atan = math.atan
Mathf.Atan2 = math.atan2
Mathf.Ceil = math.ceil
Mathf.Cos = math.cos
Mathf.Exp = math.exp
Mathf.Floor = math.floor
Mathf.Log = math.log
Mathf.Log10 = math.log10
Mathf.Max = math.max
Mathf.Min = math.min
Mathf.Pow = math.pow
Mathf.Sin = math.sin
Mathf.Sqrt = math.sqrt
Mathf.Tan = math.tan
Mathf.Deg = math.deg
Mathf.Rad = math.rad
Mathf.Random = math.random
Mathf.__index = function(t, k)
  -- function num : 0_0 , upvalues : _ENV, Mathf, unity_mathf
  local var = rawget(Mathf, k)
  if var ~= nil then
    return var
  end
  return rawget(unity_mathf, k)
end

Mathf.Approximately = function(a, b)
  -- function num : 0_1 , upvalues : abs, math
  do return abs(b - a) < (math.max)(1e-06 * (math.max)(abs(a), abs(b)), 1.121039e-44) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Mathf.Clamp = function(value, min, max)
  -- function num : 0_2
  if value < min then
    value = min
  else
    if max < value then
      value = max
    end
  end
  return value
end

Mathf.Clamp01 = function(value)
  -- function num : 0_3
  if value < 0 then
    return 0
  else
    if value > 1 then
      return 1
    end
  end
  return value
end

Mathf.DeltaAngle = function(current, target)
  -- function num : 0_4 , upvalues : Mathf
  local num = (Mathf.Repeat)(target - current, 360)
  if num > 180 then
    num = num - 360
  end
  return num
end

Mathf.Gamma = function(value, absmax, gamma)
  -- function num : 0_5 , upvalues : abs, math
  local flag = false
  if value < 0 then
    flag = true
  end
  local num = abs(value)
  if absmax < num then
    if flag or not num then
      do return -num end
      local num2 = (math.pow)(num / absmax, gamma) * absmax
      if flag or not num2 then
        return -num2
      end
    end
  end
end

Mathf.InverseLerp = function(from, to, value)
  -- function num : 0_6
  if from < to then
    if value < from then
      return 0
    end
    if to < value then
      return 1
    end
    value = value - from
    value = (value) / (to - from)
    return value
  end
  if from <= to then
    return 0
  end
  if value < to then
    return 1
  end
  if from < value then
    return 0
  end
  return 1 - (value - to) / (from - to)
end

Mathf.Lerp = function(from, to, t)
  -- function num : 0_7 , upvalues : Mathf
  return from + (to - from) * (Mathf.Clamp01)(t)
end

Mathf.LerpAngle = function(a, b, t)
  -- function num : 0_8 , upvalues : Mathf
  local num = (Mathf.Repeat)(b - a, 360)
  if num > 180 then
    num = num - 360
  end
  return a + (num) * (Mathf.Clamp01)(t)
end

Mathf.LerpUnclamped = function(a, b, t)
  -- function num : 0_9
  return a + (b - a) * t
end

Mathf.MoveTowards = function(current, target, maxDelta)
  -- function num : 0_10 , upvalues : abs, Mathf
  if abs(target - current) <= maxDelta then
    return target
  end
  return current + (Mathf.Sign)(target - current) * maxDelta
end

Mathf.MoveTowardsAngle = function(current, target, maxDelta)
  -- function num : 0_11 , upvalues : Mathf
  target = current + (Mathf.DeltaAngle)(current, target)
  return (Mathf.MoveTowards)(current, target, maxDelta)
end

Mathf.PingPong = function(t, length)
  -- function num : 0_12 , upvalues : Mathf, abs
  t = (Mathf.Repeat)(t, length * 2)
  return length - abs(t - length)
end

Mathf.Repeat = function(t, length)
  -- function num : 0_13 , upvalues : floor
  return t - floor(t / length) * length
end

Mathf.Round = function(num)
  -- function num : 0_14 , upvalues : floor
  return floor(num + 0.5)
end

Mathf.Sign = function(num)
  -- function num : 0_15
  if num > 0 then
    num = 1
  else
    if num < 0 then
      num = -1
    else
      num = 0
    end
  end
  return num
end

Mathf.SmoothDamp = function(current, target, currentVelocity, smoothTime, maxSpeed, deltaTime)
  -- function num : 0_16 , upvalues : Mathf, _ENV
  if not maxSpeed then
    maxSpeed = Mathf.Infinity
  end
  if not deltaTime then
    deltaTime = Time.deltaTime
  end
  smoothTime = (Mathf.Max)(0.0001, smoothTime)
  local num = 2 / smoothTime
  local num2 = num * deltaTime
  local num3 = 1 / (1 + num2 + 0.48 * num2 * num2 + 0.235 * num2 * num2 * num2)
  local num4 = current - target
  local num5 = target
  local max = maxSpeed * smoothTime
  num4 = (Mathf.Clamp)(num4, -max, max)
  target = current - num4
  local num7 = (currentVelocity + num * num4) * deltaTime
  currentVelocity = (currentVelocity - num * num7) * num3
  local num8 = target + (num4 + num7) * num3
  if current < num5 == num5 < num8 then
    num8 = num5
    currentVelocity = (num8 - num5) / deltaTime
  end
  do return num8, currentVelocity end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

Mathf.SmoothDampAngle = function(current, target, currentVelocity, smoothTime, maxSpeed, deltaTime)
  -- function num : 0_17 , upvalues : _ENV, Mathf
  if not deltaTime then
    deltaTime = Time.deltaTime
  end
  if not maxSpeed then
    maxSpeed = Mathf.Infinity
  end
  target = current + (Mathf.DeltaAngle)(current, target)
  return (Mathf.SmoothDamp)(current, target, currentVelocity, smoothTime, maxSpeed, deltaTime)
end

Mathf.SmoothStep = function(from, to, t)
  -- function num : 0_18 , upvalues : Mathf
  t = (Mathf.Clamp01)(t)
  t = -2 * t * t * t + 3 * t * t
  return to * (t) + from * (1 - (t))
end

Mathf.HorizontalAngle = function(dir)
  -- function num : 0_19 , upvalues : math
  return (math.deg)((math.atan2)(dir.x, dir.z))
end

Mathf.IsNan = function(number)
  -- function num : 0_20
  do return number ~= number end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Mathf.unity_mathf = (CS.UnityEngine).Mathf
-- DECOMPILER ERROR at PC111: Confused about usage of register: R5 in 'UnsetPending'

;
(CS.UnityEngine).Mathf = Mathf
setmetatable(Mathf, Mathf)
return Mathf

-- params : ...
-- function num : 0 , upvalues : _ENV
local math = math
local floor = math.floor
local abs = math.abs
local Mathf = {}
local unity_mathf = (CS.UnityEngine).Mathf
Mathf.Deg2Rad = (math.rad)(1)
Mathf.Epsilon = 1.4013e-45
Mathf.Infinity = math.huge
Mathf.NegativeInfinity = -math.huge
Mathf.PI = math.pi
Mathf.Rad2Deg = (math.deg)(1)
Mathf.Abs = math.abs
Mathf.Acos = math.acos
Mathf.Asin = math.asin
Mathf.Atan = math.atan
Mathf.Atan2 = math.atan2
Mathf.Ceil = math.ceil
Mathf.Cos = math.cos
Mathf.Exp = math.exp
Mathf.Floor = math.floor
Mathf.Log = math.log
Mathf.Log10 = math.log10
Mathf.Max = math.max
Mathf.Min = math.min
Mathf.Pow = math.pow
Mathf.Sin = math.sin
Mathf.Sqrt = math.sqrt
Mathf.Tan = math.tan
Mathf.Deg = math.deg
Mathf.Rad = math.rad
Mathf.Random = math.random
Mathf.__index = function(t, k)
    -- function num : 0_0 , upvalues : _ENV, Mathf, unity_mathf
    local var = rawget(Mathf, k)
    if var ~= nil then return var end
    return rawget(unity_mathf, k)
end

Mathf.Approximately = function(a, b)
    -- function num : 0_1 , upvalues : abs, math
    do
        return abs(b - a) <
                   (math.max)(1e-06 * (math.max)(abs(a), abs(b)), 1.121039e-44)
    end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Mathf.Clamp = function(value, min, max)
    -- function num : 0_2
    if value < min then
        value = min
    else
        if max < value then value = max end
    end
    return value
end

Mathf.Clamp01 = function(value)
    -- function num : 0_3
    if value < 0 then
        return 0
    else
        if value > 1 then return 1 end
    end
    return value
end

Mathf.DeltaAngle = function(current, target)
    -- function num : 0_4 , upvalues : Mathf
    local num = (Mathf.Repeat)(target - current, 360)
    if num > 180 then num = num - 360 end
    return num
end

Mathf.Gamma = function(value, absmax, gamma)
    -- function num : 0_5 , upvalues : abs, math
    local flag = false
    if value < 0 then flag = true end
    local num = abs(value)
    if absmax < num then
        if flag or not num then
            do return -num end
            local num2 = (math.pow)(num / absmax, gamma) * absmax
            if flag or not num2 then return -num2 end
        end
    end
end

Mathf.InverseLerp = function(from, to, value)
    -- function num : 0_6
    if from < to then
        if value < from then return 0 end
        if to < value then return 1 end
        value = value - from
        value = (value) / (to - from)
        return value
    end
    if from <= to then return 0 end
    if value < to then return 1 end
    if from < value then return 0 end
    return 1 - (value - to) / (from - to)
end

Mathf.Lerp = function(from, to, t)
    -- function num : 0_7 , upvalues : Mathf
    return from + (to - from) * (Mathf.Clamp01)(t)
end

Mathf.LerpAngle = function(a, b, t)
    -- function num : 0_8 , upvalues : Mathf
    local num = (Mathf.Repeat)(b - a, 360)
    if num > 180 then num = num - 360 end
    return a + (num) * (Mathf.Clamp01)(t)
end

Mathf.LerpUnclamped = function(a, b, t)
    -- function num : 0_9
    return a + (b - a) * t
end

Mathf.MoveTowards = function(current, target, maxDelta)
    -- function num : 0_10 , upvalues : abs, Mathf
    if abs(target - current) <= maxDelta then return target end
    return current + (Mathf.Sign)(target - current) * maxDelta
end

Mathf.MoveTowardsAngle = function(current, target, maxDelta)
    -- function num : 0_11 , upvalues : Mathf
    target = current + (Mathf.DeltaAngle)(current, target)
    return (Mathf.MoveTowards)(current, target, maxDelta)
end

Mathf.PingPong = function(t, length)
    -- function num : 0_12 , upvalues : Mathf, abs
    t = (Mathf.Repeat)(t, length * 2)
    return length - abs(t - length)
end

Mathf.Repeat = function(t, length)
    -- function num : 0_13 , upvalues : floor
    return t - floor(t / length) * length
end

Mathf.Round = function(num)
    -- function num : 0_14 , upvalues : floor
    return floor(num + 0.5)
end

Mathf.Sign = function(num)
    -- function num : 0_15
    if num > 0 then
        num = 1
    else
        if num < 0 then
            num = -1
        else
            num = 0
        end
    end
    return num
end

Mathf.SmoothDamp = function(current, target, currentVelocity, smoothTime,
                            maxSpeed, deltaTime)
    -- function num : 0_16 , upvalues : Mathf, _ENV
    if not maxSpeed then maxSpeed = Mathf.Infinity end
    if not deltaTime then deltaTime = Time.deltaTime end
    smoothTime = (Mathf.Max)(0.0001, smoothTime)
    local num = 2 / smoothTime
    local num2 = num * deltaTime
    local num3 = 1 /
                     (1 + num2 + 0.48 * num2 * num2 + 0.235 * num2 * num2 * num2)
    local num4 = current - target
    local num5 = target
    local max = maxSpeed * smoothTime
    num4 = (Mathf.Clamp)(num4, -max, max)
    target = current - num4
    local num7 = (currentVelocity + num * num4) * deltaTime
    currentVelocity = (currentVelocity - num * num7) * num3
    local num8 = target + (num4 + num7) * num3
    if current < num5 == num5 < num8 then
        num8 = num5
        currentVelocity = (num8 - num5) / deltaTime
    end
    do return num8, currentVelocity end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

Mathf.SmoothDampAngle = function(current, target, currentVelocity, smoothTime,
                                 maxSpeed, deltaTime)
    -- function num : 0_17 , upvalues : _ENV, Mathf
    if not deltaTime then deltaTime = Time.deltaTime end
    if not maxSpeed then maxSpeed = Mathf.Infinity end
    target = current + (Mathf.DeltaAngle)(current, target)
    return (Mathf.SmoothDamp)(current, target, currentVelocity, smoothTime,
                              maxSpeed, deltaTime)
end

Mathf.SmoothStep = function(from, to, t)
    -- function num : 0_18 , upvalues : Mathf
    t = (Mathf.Clamp01)(t)
    t = -2 * t * t * t + 3 * t * t
    return to * (t) + from * (1 - (t))
end

Mathf.HorizontalAngle = function(dir)
    -- function num : 0_19 , upvalues : math
    return (math.deg)((math.atan2)(dir.x, dir.z))
end

Mathf.IsNan = function(number)
    -- function num : 0_20
    do return number ~= number end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Mathf.unity_mathf = (CS.UnityEngine).Mathf -- DECOMPILER ERROR at PC111: Confused about usage of register: R5 in 'UnsetPending'
;
(CS.UnityEngine).Mathf = Mathf
setmetatable(Mathf, Mathf)
return Mathf

