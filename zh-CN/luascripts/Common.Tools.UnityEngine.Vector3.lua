-- params : ...
-- function num : 0 , upvalues : _ENV
local math = math
local acos = math.acos
local sqrt = math.sqrt
local max = math.max
local min = math.min
local clamp = Mathf.Clamp
local cos = math.cos
local sin = math.sin
local abs = math.abs
local sign = Mathf.Sign
local setmetatable = setmetatable
local rawset = rawset
local rawget = rawget
local type = type
local rad2Deg = 57.295779513082
local deg2Rad = 0.017453292519943
local Vector3 = {}
local _getter = {}
local unity_vector3 = (CS.UnityEngine).Vector3
Vector3.__index = function(t, k)
  -- function num : 0_0 , upvalues : rawget, Vector3, _getter, unity_vector3
  local var = rawget(Vector3, k)
  if var ~= nil then
    return var
  end
  var = rawget(_getter, k)
  if var ~= nil then
    return var(t)
  end
  return rawget(unity_vector3, k)
end

Vector3.New = function(x, y, z)
  -- function num : 0_1 , upvalues : setmetatable, Vector3
  local t = {x = x or 0, y = y or 0, z = z or 0}
  setmetatable(t, Vector3)
  return t
end

local _new = Vector3.New
Vector3.__call = function(t, x, y, z)
  -- function num : 0_2 , upvalues : setmetatable, Vector3
  local t = {x = x or 0, y = y or 0, z = z or 0}
  setmetatable(t, Vector3)
  return t
end

Vector3.Set = function(self, x, y, z)
  -- function num : 0_3
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
end

Vector3.Get = function(v)
  -- function num : 0_4
  return v.x, v.y, v.z
end

Vector3.Clone = function(self)
  -- function num : 0_5 , upvalues : setmetatable, Vector3
  return setmetatable({x = self.x, y = self.y, z = self.z}, Vector3)
end

Vector3.Distance = function(va, vb)
  -- function num : 0_6 , upvalues : sqrt
  return sqrt(va.x - vb.x ^ 2 + va.y - vb.y ^ 2 + va.z - vb.z ^ 2)
end

Vector3.Dot = function(lhs, rhs)
  -- function num : 0_7
  return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z
end

Vector3.Lerp = function(from, to, t)
  -- function num : 0_8 , upvalues : clamp, _new
  t = clamp(t, 0, 1)
  return _new(from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t, from.z + (to.z - from.z) * t)
end

Vector3.Magnitude = function(self)
  -- function num : 0_9 , upvalues : sqrt
  return sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

Vector3.Max = function(lhs, rhs)
  -- function num : 0_10 , upvalues : _new, max
  return _new(max(lhs.x, rhs.x), max(lhs.y, rhs.y), max(lhs.z, rhs.z))
end

Vector3.Min = function(lhs, rhs)
  -- function num : 0_11 , upvalues : _new, min
  return _new(min(lhs.x, rhs.x), min(lhs.y, rhs.y), min(lhs.z, rhs.z))
end

Vector3.Normalize = function(v)
  -- function num : 0_12 , upvalues : sqrt, setmetatable, Vector3
  local x, y, z = v.x, v.y, v.z
  local num = sqrt(x * x + y * y + z * z)
  if num > 1e-05 then
    return setmetatable({x = x / num, y = y / num, z = z / num}, Vector3)
  end
  return setmetatable({x = 0, y = 0, z = 0}, Vector3)
end

Vector3.SetNormalize = function(self)
  -- function num : 0_13 , upvalues : sqrt
  local num = sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
  if num > 1e-05 then
    self.x = self.x / num
    self.y = self.y / num
    self.z = self.z / num
  else
    self.x = 0
    self.y = 0
    self.z = 0
  end
  return self
end

Vector3.SqrMagnitude = function(self)
  -- function num : 0_14
  return self.x * self.x + self.y * self.y + self.z * self.z
end

local dot = Vector3.Dot
Vector3.Angle = function(from, to)
  -- function num : 0_15 , upvalues : acos, clamp, dot, Vector3, rad2Deg
  return acos(clamp(dot((Vector3.Normalize)(from), (Vector3.Normalize)(to)), -1, 1)) * rad2Deg
end

Vector3.ClampMagnitude = function(self, maxLength)
  -- function num : 0_16
  if maxLength * maxLength < self:SqrMagnitude() then
    self:SetNormalize()
    self:Mul(maxLength)
  end
  return self
end

Vector3.OrthoNormalize = function(va, vb, vc)
  -- function num : 0_17
  va:SetNormalize()
  vb:Sub(vb:Project(va))
  vb:SetNormalize()
  if vc == nil then
    return va, vb
  end
  vc:Sub(vc:Project(va))
  vc:Sub(vc:Project(vb))
  vc:SetNormalize()
  return va, vb, vc
end

Vector3.MoveTowards = function(current, target, maxDistanceDelta)
  -- function num : 0_18 , upvalues : sqrt
  local delta = target - current
  local sqrDelta = delta:SqrMagnitude()
  local sqrDistance = maxDistanceDelta * maxDistanceDelta
  do
    if sqrDistance < sqrDelta then
      local magnitude = sqrt(sqrDelta)
      if magnitude > 1e-06 then
        delta:Mul(maxDistanceDelta / magnitude)
        delta:Add(current)
        return delta
      else
        return current:Clone()
      end
    end
    return target:Clone()
  end
end

ClampedMove = function(lhs, rhs, clampedDelta)
  -- function num : 0_19 , upvalues : min
  local delta = rhs - lhs
  if delta > 0 then
    return lhs + min(delta, clampedDelta)
  else
    return lhs - min(-delta, clampedDelta)
  end
end

local overSqrt2 = 0.70710678118655
local OrthoNormalVector = function(vec)
  -- function num : 0_20 , upvalues : _new, abs, overSqrt2, sqrt
  local res = _new()
  if overSqrt2 < abs(vec.z) then
    local a = vec.y * vec.y + vec.z * vec.z
    local k = 1 / sqrt(a)
    res.x = 0
    res.y = -vec.z * k
    res.z = vec.y * k
  else
    do
      local a = vec.x * vec.x + vec.y * vec.y
      do
        local k = 1 / sqrt(a)
        res.x = -vec.y * k
        res.y = vec.x * k
        res.z = 0
        return res
      end
    end
  end
end

Vector3.RotateTowards = function(current, target, maxRadiansDelta, maxMagnitudeDelta)
  -- function num : 0_21 , upvalues : dot, Vector3, OrthoNormalVector, _ENV, rad2Deg, acos, min
  local len1 = current:Magnitude()
  local len2 = target:Magnitude()
  if len1 > 1e-06 and len2 > 1e-06 then
    local from = current / len1
    local to = target / len2
    local cosom = dot(from, to)
    if cosom > 0.999999 then
      return (Vector3.MoveTowards)(current, target, maxMagnitudeDelta)
    else
      if cosom < -0.999999 then
        local axis = OrthoNormalVector(from)
        local q = (Quaternion.AngleAxis)(maxRadiansDelta * rad2Deg, axis)
        local rotated = q:MulVec3(from)
        local delta = ClampedMove(len1, len2, maxMagnitudeDelta)
        rotated:Mul(delta)
        return rotated
      else
        do
          local angle = acos(cosom)
          local axis = (Vector3.Cross)(from, to)
          axis:SetNormalize()
          local q = (Quaternion.AngleAxis)(min(maxRadiansDelta, angle) * rad2Deg, axis)
          local rotated = q:MulVec3(from)
          do
            local delta = ClampedMove(len1, len2, maxMagnitudeDelta)
            rotated:Mul(delta)
            do return rotated end
            return (Vector3.MoveTowards)(current, target, maxMagnitudeDelta)
          end
        end
      end
    end
  end
end

Vector3.SmoothDamp = function(current, target, currentVelocity, smoothTime)
  -- function num : 0_22 , upvalues : _ENV, max, Vector3
  local maxSpeed = Mathf.Infinity
  local deltaTime = Time.deltaTime
  smoothTime = max(0.0001, smoothTime)
  local num = 2 / smoothTime
  local num2 = num * deltaTime
  local num3 = 1 / (1 + num2 + 0.48 * num2 * num2 + 0.235 * num2 * num2 * num2)
  local vector2 = target:Clone()
  local maxLength = maxSpeed * smoothTime
  local vector = current - target
  vector:ClampMagnitude(maxLength)
  target = current - vector
  local vec3 = (currentVelocity + vector * num) * deltaTime
  currentVelocity = (currentVelocity - vec3 * num) * num3
  local vector4 = target + (vector + vec3) * num3
  if (Vector3.Dot)(vector2 - current, vector4 - vector2) > 0 then
    vector4 = vector2
    currentVelocity:Set(0, 0, 0)
  end
  return vector4, currentVelocity
end

Vector3.Scale = function(a, b)
  -- function num : 0_23 , upvalues : _new
  local x = a.x * b.x
  local y = a.y * b.y
  local z = a.z * b.z
  return _new(x, y, z)
end

Vector3.Cross = function(lhs, rhs)
  -- function num : 0_24 , upvalues : _new
  local x = lhs.y * rhs.z - lhs.z * rhs.y
  local y = lhs.z * rhs.x - lhs.x * rhs.z
  local z = lhs.x * rhs.y - lhs.y * rhs.x
  return _new(x, y, z)
end

Vector3.Equals = function(self, other)
  -- function num : 0_25
  do return self.x == other.x and self.y == other.y and self.z == other.z end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Vector3.Reflect = function(inDirection, inNormal)
  -- function num : 0_26 , upvalues : dot
  local num = -2 * dot(inNormal, inDirection)
  inNormal = inNormal * num
  inNormal:Add(inDirection)
  return inNormal
end

Vector3.Project = function(vector, onNormal)
  -- function num : 0_27 , upvalues : _new, dot
  local num = onNormal:SqrMagnitude()
  if num < 1.175494e-38 then
    return _new(0, 0, 0)
  end
  local num2 = dot(vector, onNormal)
  local v3 = onNormal:Clone()
  v3:Mul(num2 / num)
  return v3
end

Vector3.ProjectOnPlane = function(vector, planeNormal)
  -- function num : 0_28 , upvalues : Vector3
  local v3 = (Vector3.Project)(vector, planeNormal)
  v3:Mul(-1)
  v3:Add(vector)
  return v3
end

Vector3.Slerp = function(from, to, t)
  -- function num : 0_29 , upvalues : OrthoNormalVector, _ENV, acos, sin
  local omega, sinom, scale0, scale1 = nil, nil, nil, nil
  if t <= 0 then
    return from:Clone()
  else
    if t >= 1 then
      return to:Clone()
    end
  end
  local v2 = to:Clone()
  local v1 = from:Clone()
  local len2 = to:Magnitude()
  local len1 = from:Magnitude()
  v2:Div(len2)
  v1:Div(len1)
  local len = (len2 - len1) * t + len1
  local cosom = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
  if cosom > 0.999999 then
    scale0 = 1 - t
    scale1 = t
  else
    if cosom < -0.999999 then
      local axis = OrthoNormalVector(from)
      local q = (Quaternion.AngleAxis)(180 * t, axis)
      local v = q:MulVec3(from)
      v:Mul(len)
      return v
    else
      do
        omega = acos(cosom)
        sinom = sin(omega)
        scale0 = sin((1 - t) * omega) / sinom
        scale1 = sin(t * omega) / sinom
        v1:Mul(scale0)
        v2:Mul(scale1)
        v2:Add(v1)
        v2:Mul(len)
        return v2
      end
    end
  end
end

Vector3.Mul = function(self, q)
  -- function num : 0_30 , upvalues : type
  if type(q) == "number" then
    self.x = self.x * q
    self.y = self.y * q
    self.z = self.z * q
  else
    self:MulQuat(q)
  end
  return self
end

Vector3.Div = function(self, d)
  -- function num : 0_31
  self.x = self.x / d
  self.y = self.y / d
  self.z = self.z / d
  return self
end

Vector3.Add = function(self, vb)
  -- function num : 0_32
  self.x = self.x + vb.x
  self.y = self.y + vb.y
  self.z = self.z + vb.z
  return self
end

Vector3.Sub = function(self, vb)
  -- function num : 0_33
  self.x = self.x - vb.x
  self.y = self.y - vb.y
  self.z = self.z - vb.z
  return self
end

Vector3.MulQuat = function(self, quat)
  -- function num : 0_34
  local num = quat.x * 2
  local num2 = quat.y * 2
  local num3 = quat.z * 2
  local num4 = quat.x * num
  local num5 = quat.y * num2
  local num6 = quat.z * num3
  local num7 = quat.x * num2
  local num8 = quat.x * num3
  local num9 = quat.y * num3
  local num10 = quat.w * num
  local num11 = quat.w * num2
  local num12 = quat.w * num3
  local x = (1 - (num5 + num6)) * self.x + (num7 - num12) * self.y + (num8 + num11) * self.z
  local y = (num7 + num12) * self.x + (1 - (num4 + num6)) * self.y + (num9 - num10) * self.z
  local z = (num8 - num11) * self.x + (num9 + num10) * self.y + (1 - (num4 + num5)) * self.z
  self:Set(x, y, z)
  return self
end

Vector3.AngleAroundAxis = function(from, to, axis)
  -- function num : 0_35 , upvalues : Vector3
  from = from - (Vector3.Project)(from, axis)
  to = to - (Vector3.Project)(to, axis)
  local angle = (Vector3.Angle)(from, to)
  return angle * ((Vector3.Dot)(axis, (Vector3.Cross)(from, to)) < 0 and -1 or 1)
end

Vector3.__tostring = function(self)
  -- function num : 0_36
  return "[" .. self.x .. "," .. self.y .. "," .. self.z .. "]"
end

Vector3.__div = function(va, d)
  -- function num : 0_37 , upvalues : _new
  return _new(va.x / d, va.y / d, va.z / d)
end

Vector3.__mul = function(va, d)
  -- function num : 0_38 , upvalues : type, _new
  if type(d) == "number" then
    return _new(va.x * d, va.y * d, va.z * d)
  else
    local vec = va:Clone()
    vec:MulQuat(d)
    return vec
  end
end

Vector3.__add = function(va, vb)
  -- function num : 0_39 , upvalues : _new
  return _new(va.x + vb.x, va.y + vb.y, va.z + vb.z)
end

Vector3.__sub = function(va, vb)
  -- function num : 0_40 , upvalues : _new
  return _new(va.x - vb.x, va.y - vb.y, va.z - vb.z)
end

Vector3.__unm = function(va)
  -- function num : 0_41 , upvalues : _new
  return _new(-va.x, -va.y, -va.z)
end

Vector3.__eq = function(a, b)
  -- function num : 0_42
  local v = a - b
  local delta = v:SqrMagnitude()
  do return delta < 1e-10 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

_getter.up = function()
  -- function num : 0_43 , upvalues : _new
  return _new(0, 1, 0)
end

_getter.down = function()
  -- function num : 0_44 , upvalues : _new
  return _new(0, -1, 0)
end

_getter.right = function()
  -- function num : 0_45 , upvalues : _new
  return _new(1, 0, 0)
end

_getter.left = function()
  -- function num : 0_46 , upvalues : _new
  return _new(-1, 0, 0)
end

_getter.forward = function()
  -- function num : 0_47 , upvalues : _new
  return _new(0, 0, 1)
end

_getter.back = function()
  -- function num : 0_48 , upvalues : _new
  return _new(0, 0, -1)
end

_getter.zero = function()
  -- function num : 0_49 , upvalues : _new
  return _new(0, 0, 0)
end

_getter.one = function()
  -- function num : 0_50 , upvalues : _new
  return _new(1, 1, 1)
end

_getter.magnitude = Vector3.Magnitude
_getter.normalized = Vector3.Normalize
_getter.sqrMagnitude = Vector3.SqrMagnitude
Vector3.unity_vector3 = (CS.UnityEngine).Vector3
-- DECOMPILER ERROR at PC139: Confused about usage of register: R23 in 'UnsetPending'

;
(CS.UnityEngine).Vector3 = Vector3
setmetatable(Vector3, Vector3)
return Vector3

-- params : ...
-- function num : 0 , upvalues : _ENV
local math = math
local acos = math.acos
local sqrt = math.sqrt
local max = math.max
local min = math.min
local clamp = Mathf.Clamp
local cos = math.cos
local sin = math.sin
local abs = math.abs
local sign = Mathf.Sign
local setmetatable = setmetatable
local rawset = rawset
local rawget = rawget
local type = type
local rad2Deg = 57.295779513082
local deg2Rad = 0.017453292519943
local Vector3 = {}
local _getter = {}
local unity_vector3 = (CS.UnityEngine).Vector3
Vector3.__index = function(t, k)
    -- function num : 0_0 , upvalues : rawget, Vector3, _getter, unity_vector3
    local var = rawget(Vector3, k)
    if var ~= nil then return var end
    var = rawget(_getter, k)
    if var ~= nil then return var(t) end
    return rawget(unity_vector3, k)
end

Vector3.New = function(x, y, z)
    -- function num : 0_1 , upvalues : setmetatable, Vector3
    local t = {x = x or 0, y = y or 0, z = z or 0}
    setmetatable(t, Vector3)
    return t
end

local _new = Vector3.New
Vector3.__call = function(t, x, y, z)
    -- function num : 0_2 , upvalues : setmetatable, Vector3
    local t = {x = x or 0, y = y or 0, z = z or 0}
    setmetatable(t, Vector3)
    return t
end

Vector3.Set = function(self, x, y, z)
    -- function num : 0_3
    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
end

Vector3.Get = function(v)
    -- function num : 0_4
    return v.x, v.y, v.z
end

Vector3.Clone = function(self)
    -- function num : 0_5 , upvalues : setmetatable, Vector3
    return setmetatable({x = self.x, y = self.y, z = self.z}, Vector3)
end

Vector3.Distance = function(va, vb)
    -- function num : 0_6 , upvalues : sqrt
    return sqrt(va.x - vb.x ^ 2 + va.y - vb.y ^ 2 + va.z - vb.z ^ 2)
end

Vector3.Dot = function(lhs, rhs)
    -- function num : 0_7
    return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z
end

Vector3.Lerp = function(from, to, t)
    -- function num : 0_8 , upvalues : clamp, _new
    t = clamp(t, 0, 1)
    return _new(from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t,
                from.z + (to.z - from.z) * t)
end

Vector3.Magnitude = function(self)
    -- function num : 0_9 , upvalues : sqrt
    return sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

Vector3.Max = function(lhs, rhs)
    -- function num : 0_10 , upvalues : _new, max
    return _new(max(lhs.x, rhs.x), max(lhs.y, rhs.y), max(lhs.z, rhs.z))
end

Vector3.Min = function(lhs, rhs)
    -- function num : 0_11 , upvalues : _new, min
    return _new(min(lhs.x, rhs.x), min(lhs.y, rhs.y), min(lhs.z, rhs.z))
end

Vector3.Normalize = function(v)
    -- function num : 0_12 , upvalues : sqrt, setmetatable, Vector3
    local x, y, z = v.x, v.y, v.z
    local num = sqrt(x * x + y * y + z * z)
    if num > 1e-05 then
        return setmetatable({x = x / num, y = y / num, z = z / num}, Vector3)
    end
    return setmetatable({x = 0, y = 0, z = 0}, Vector3)
end

Vector3.SetNormalize = function(self)
    -- function num : 0_13 , upvalues : sqrt
    local num = sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
    if num > 1e-05 then
        self.x = self.x / num
        self.y = self.y / num
        self.z = self.z / num
    else
        self.x = 0
        self.y = 0
        self.z = 0
    end
    return self
end

Vector3.SqrMagnitude = function(self)
    -- function num : 0_14
    return self.x * self.x + self.y * self.y + self.z * self.z
end

local dot = Vector3.Dot
Vector3.Angle = function(from, to)
    -- function num : 0_15 , upvalues : acos, clamp, dot, Vector3, rad2Deg
    return acos(clamp(dot((Vector3.Normalize)(from), (Vector3.Normalize)(to)),
                      -1, 1)) * rad2Deg
end

Vector3.ClampMagnitude = function(self, maxLength)
    -- function num : 0_16
    if maxLength * maxLength < self:SqrMagnitude() then
        self:SetNormalize()
        self:Mul(maxLength)
    end
    return self
end

Vector3.OrthoNormalize = function(va, vb, vc)
    -- function num : 0_17
    va:SetNormalize()
    vb:Sub(vb:Project(va))
    vb:SetNormalize()
    if vc == nil then return va, vb end
    vc:Sub(vc:Project(va))
    vc:Sub(vc:Project(vb))
    vc:SetNormalize()
    return va, vb, vc
end

Vector3.MoveTowards = function(current, target, maxDistanceDelta)
    -- function num : 0_18 , upvalues : sqrt
    local delta = target - current
    local sqrDelta = delta:SqrMagnitude()
    local sqrDistance = maxDistanceDelta * maxDistanceDelta
    do
        if sqrDistance < sqrDelta then
            local magnitude = sqrt(sqrDelta)
            if magnitude > 1e-06 then
                delta:Mul(maxDistanceDelta / magnitude)
                delta:Add(current)
                return delta
            else
                return current:Clone()
            end
        end
        return target:Clone()
    end
end

ClampedMove = function(lhs, rhs, clampedDelta)
    -- function num : 0_19 , upvalues : min
    local delta = rhs - lhs
    if delta > 0 then
        return lhs + min(delta, clampedDelta)
    else
        return lhs - min(-delta, clampedDelta)
    end
end

local overSqrt2 = 0.70710678118655
local OrthoNormalVector = function(vec)
    -- function num : 0_20 , upvalues : _new, abs, overSqrt2, sqrt
    local res = _new()
    if overSqrt2 < abs(vec.z) then
        local a = vec.y * vec.y + vec.z * vec.z
        local k = 1 / sqrt(a)
        res.x = 0
        res.y = -vec.z * k
        res.z = vec.y * k
    else
        do
            local a = vec.x * vec.x + vec.y * vec.y
            do
                local k = 1 / sqrt(a)
                res.x = -vec.y * k
                res.y = vec.x * k
                res.z = 0
                return res
            end
        end
    end
end

Vector3.RotateTowards = function(current, target, maxRadiansDelta,
                                 maxMagnitudeDelta)
    -- function num : 0_21 , upvalues : dot, Vector3, OrthoNormalVector, _ENV, rad2Deg, acos, min
    local len1 = current:Magnitude()
    local len2 = target:Magnitude()
    if len1 > 1e-06 and len2 > 1e-06 then
        local from = current / len1
        local to = target / len2
        local cosom = dot(from, to)
        if cosom > 0.999999 then
            return (Vector3.MoveTowards)(current, target, maxMagnitudeDelta)
        else
            if cosom < -0.999999 then
                local axis = OrthoNormalVector(from)
                local q =
                    (Quaternion.AngleAxis)(maxRadiansDelta * rad2Deg, axis)
                local rotated = q:MulVec3(from)
                local delta = ClampedMove(len1, len2, maxMagnitudeDelta)
                rotated:Mul(delta)
                return rotated
            else
                do
                    local angle = acos(cosom)
                    local axis = (Vector3.Cross)(from, to)
                    axis:SetNormalize()
                    local q = (Quaternion.AngleAxis)(
                                  min(maxRadiansDelta, angle) * rad2Deg, axis)
                    local rotated = q:MulVec3(from)
                    do
                        local delta = ClampedMove(len1, len2, maxMagnitudeDelta)
                        rotated:Mul(delta)
                        do return rotated end
                        return (Vector3.MoveTowards)(current, target,
                                                     maxMagnitudeDelta)
                    end
                end
            end
        end
    end
end

Vector3.SmoothDamp = function(current, target, currentVelocity, smoothTime)
    -- function num : 0_22 , upvalues : _ENV, max, Vector3
    local maxSpeed = Mathf.Infinity
    local deltaTime = Time.deltaTime
    smoothTime = max(0.0001, smoothTime)
    local num = 2 / smoothTime
    local num2 = num * deltaTime
    local num3 = 1 /
                     (1 + num2 + 0.48 * num2 * num2 + 0.235 * num2 * num2 * num2)
    local vector2 = target:Clone()
    local maxLength = maxSpeed * smoothTime
    local vector = current - target
    vector:ClampMagnitude(maxLength)
    target = current - vector
    local vec3 = (currentVelocity + vector * num) * deltaTime
    currentVelocity = (currentVelocity - vec3 * num) * num3
    local vector4 = target + (vector + vec3) * num3
    if (Vector3.Dot)(vector2 - current, vector4 - vector2) > 0 then
        vector4 = vector2
        currentVelocity:Set(0, 0, 0)
    end
    return vector4, currentVelocity
end

Vector3.Scale = function(a, b)
    -- function num : 0_23 , upvalues : _new
    local x = a.x * b.x
    local y = a.y * b.y
    local z = a.z * b.z
    return _new(x, y, z)
end

Vector3.Cross = function(lhs, rhs)
    -- function num : 0_24 , upvalues : _new
    local x = lhs.y * rhs.z - lhs.z * rhs.y
    local y = lhs.z * rhs.x - lhs.x * rhs.z
    local z = lhs.x * rhs.y - lhs.y * rhs.x
    return _new(x, y, z)
end

Vector3.Equals = function(self, other)
    -- function num : 0_25
    do return self.x == other.x and self.y == other.y and self.z == other.z end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Vector3.Reflect = function(inDirection, inNormal)
    -- function num : 0_26 , upvalues : dot
    local num = -2 * dot(inNormal, inDirection)
    inNormal = inNormal * num
    inNormal:Add(inDirection)
    return inNormal
end

Vector3.Project = function(vector, onNormal)
    -- function num : 0_27 , upvalues : _new, dot
    local num = onNormal:SqrMagnitude()
    if num < 1.175494e-38 then return _new(0, 0, 0) end
    local num2 = dot(vector, onNormal)
    local v3 = onNormal:Clone()
    v3:Mul(num2 / num)
    return v3
end

Vector3.ProjectOnPlane = function(vector, planeNormal)
    -- function num : 0_28 , upvalues : Vector3
    local v3 = (Vector3.Project)(vector, planeNormal)
    v3:Mul(-1)
    v3:Add(vector)
    return v3
end

Vector3.Slerp = function(from, to, t)
    -- function num : 0_29 , upvalues : OrthoNormalVector, _ENV, acos, sin
    local omega, sinom, scale0, scale1 = nil, nil, nil, nil
    if t <= 0 then
        return from:Clone()
    else
        if t >= 1 then return to:Clone() end
    end
    local v2 = to:Clone()
    local v1 = from:Clone()
    local len2 = to:Magnitude()
    local len1 = from:Magnitude()
    v2:Div(len2)
    v1:Div(len1)
    local len = (len2 - len1) * t + len1
    local cosom = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
    if cosom > 0.999999 then
        scale0 = 1 - t
        scale1 = t
    else
        if cosom < -0.999999 then
            local axis = OrthoNormalVector(from)
            local q = (Quaternion.AngleAxis)(180 * t, axis)
            local v = q:MulVec3(from)
            v:Mul(len)
            return v
        else
            do
                omega = acos(cosom)
                sinom = sin(omega)
                scale0 = sin((1 - t) * omega) / sinom
                scale1 = sin(t * omega) / sinom
                v1:Mul(scale0)
                v2:Mul(scale1)
                v2:Add(v1)
                v2:Mul(len)
                return v2
            end
        end
    end
end

Vector3.Mul = function(self, q)
    -- function num : 0_30 , upvalues : type
    if type(q) == "number" then
        self.x = self.x * q
        self.y = self.y * q
        self.z = self.z * q
    else
        self:MulQuat(q)
    end
    return self
end

Vector3.Div = function(self, d)
    -- function num : 0_31
    self.x = self.x / d
    self.y = self.y / d
    self.z = self.z / d
    return self
end

Vector3.Add = function(self, vb)
    -- function num : 0_32
    self.x = self.x + vb.x
    self.y = self.y + vb.y
    self.z = self.z + vb.z
    return self
end

Vector3.Sub = function(self, vb)
    -- function num : 0_33
    self.x = self.x - vb.x
    self.y = self.y - vb.y
    self.z = self.z - vb.z
    return self
end

Vector3.MulQuat = function(self, quat)
    -- function num : 0_34
    local num = quat.x * 2
    local num2 = quat.y * 2
    local num3 = quat.z * 2
    local num4 = quat.x * num
    local num5 = quat.y * num2
    local num6 = quat.z * num3
    local num7 = quat.x * num2
    local num8 = quat.x * num3
    local num9 = quat.y * num3
    local num10 = quat.w * num
    local num11 = quat.w * num2
    local num12 = quat.w * num3
    local x = (1 - (num5 + num6)) * self.x + (num7 - num12) * self.y +
                  (num8 + num11) * self.z
    local y = (num7 + num12) * self.x + (1 - (num4 + num6)) * self.y +
                  (num9 - num10) * self.z
    local z = (num8 - num11) * self.x + (num9 + num10) * self.y +
                  (1 - (num4 + num5)) * self.z
    self:Set(x, y, z)
    return self
end

Vector3.AngleAroundAxis = function(from, to, axis)
    -- function num : 0_35 , upvalues : Vector3
    from = from - (Vector3.Project)(from, axis)
    to = to - (Vector3.Project)(to, axis)
    local angle = (Vector3.Angle)(from, to)
    return angle *
               ((Vector3.Dot)(axis, (Vector3.Cross)(from, to)) < 0 and -1 or 1)
end

Vector3.__tostring = function(self)
    -- function num : 0_36
    return "[" .. self.x .. "," .. self.y .. "," .. self.z .. "]"
end

Vector3.__div = function(va, d)
    -- function num : 0_37 , upvalues : _new
    return _new(va.x / d, va.y / d, va.z / d)
end

Vector3.__mul = function(va, d)
    -- function num : 0_38 , upvalues : type, _new
    if type(d) == "number" then
        return _new(va.x * d, va.y * d, va.z * d)
    else
        local vec = va:Clone()
        vec:MulQuat(d)
        return vec
    end
end

Vector3.__add = function(va, vb)
    -- function num : 0_39 , upvalues : _new
    return _new(va.x + vb.x, va.y + vb.y, va.z + vb.z)
end

Vector3.__sub = function(va, vb)
    -- function num : 0_40 , upvalues : _new
    return _new(va.x - vb.x, va.y - vb.y, va.z - vb.z)
end

Vector3.__unm = function(va)
    -- function num : 0_41 , upvalues : _new
    return _new(-va.x, -va.y, -va.z)
end

Vector3.__eq = function(a, b)
    -- function num : 0_42
    local v = a - b
    local delta = v:SqrMagnitude()
    do return delta < 1e-10 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

_getter.up = function()
    -- function num : 0_43 , upvalues : _new
    return _new(0, 1, 0)
end

_getter.down = function()
    -- function num : 0_44 , upvalues : _new
    return _new(0, -1, 0)
end

_getter.right = function()
    -- function num : 0_45 , upvalues : _new
    return _new(1, 0, 0)
end

_getter.left = function()
    -- function num : 0_46 , upvalues : _new
    return _new(-1, 0, 0)
end

_getter.forward = function()
    -- function num : 0_47 , upvalues : _new
    return _new(0, 0, 1)
end

_getter.back = function()
    -- function num : 0_48 , upvalues : _new
    return _new(0, 0, -1)
end

_getter.zero = function()
    -- function num : 0_49 , upvalues : _new
    return _new(0, 0, 0)
end

_getter.one = function()
    -- function num : 0_50 , upvalues : _new
    return _new(1, 1, 1)
end

_getter.magnitude = Vector3.Magnitude
_getter.normalized = Vector3.Normalize
_getter.sqrMagnitude = Vector3.SqrMagnitude
Vector3.unity_vector3 = (CS.UnityEngine).Vector3 -- DECOMPILER ERROR at PC139: Confused about usage of register: R23 in 'UnsetPending'
;
(CS.UnityEngine).Vector3 = Vector3
setmetatable(Vector3, Vector3)
return Vector3

