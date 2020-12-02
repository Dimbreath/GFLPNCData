-- params : ...
-- function num : 0 , upvalues : _ENV
local clamp = Mathf.Clamp
local sqrt = Mathf.Sqrt
local min = Mathf.Min
local max = Mathf.Max
local setmetatable = setmetatable
local rawget = rawget
local Vector4 = {}
local _getter = {}
local unity_vector4 = (CS.UnityEngine).Vector4
Vector4.__index = function(t, k)
  -- function num : 0_0 , upvalues : rawget, Vector4, _getter, unity_vector4
  local var = rawget(Vector4, k)
  if var ~= nil then
    return var
  end
  var = rawget(_getter, k)
  if var ~= nil then
    return var(t)
  end
  return rawget(unity_vector4, k)
end

Vector4.__call = function(t, x, y, z, w)
  -- function num : 0_1 , upvalues : setmetatable, Vector4
  return setmetatable({x = x or 0, y = y or 0, z = z or 0, w = w or 0}, Vector4)
end

Vector4.New = function(x, y, z, w)
  -- function num : 0_2 , upvalues : setmetatable, Vector4
  return setmetatable({x = x or 0, y = y or 0, z = z or 0, w = w or 0}, Vector4)
end

Vector4.Set = function(self, x, y, z, w)
  -- function num : 0_3
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
  self.w = w or 0
end

Vector4.Get = function(self)
  -- function num : 0_4
  return self.x, self.y, self.z, self.w
end

Vector4.Lerp = function(from, to, t)
  -- function num : 0_5 , upvalues : clamp, Vector4
  t = clamp(t, 0, 1)
  return (Vector4.New)(from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t, from.z + (to.z - from.z) * t, from.w + (to.w - from.w) * t)
end

Vector4.MoveTowards = function(current, target, maxDistanceDelta)
  -- function num : 0_6
  local vector = target - current
  local magnitude = vector:Magnitude()
  if maxDistanceDelta < magnitude and magnitude ~= 0 then
    maxDistanceDelta = maxDistanceDelta / magnitude
    vector:Mul(maxDistanceDelta)
    vector:Add(current)
    return vector
  end
  return target
end

Vector4.Scale = function(a, b)
  -- function num : 0_7 , upvalues : Vector4
  return (Vector4.New)(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w)
end

Vector4.SetScale = function(self, scale)
  -- function num : 0_8
  self.x = self.x * scale.x
  self.y = self.y * scale.y
  self.z = self.z * scale.z
  self.w = self.w * scale.w
end

Vector4.Normalize = function(self)
  -- function num : 0_9 , upvalues : Vector4
  local v = (Vector4.New)(self.x, self.y, self.z, self.w)
  return v:SetNormalize()
end

Vector4.SetNormalize = function(self)
  -- function num : 0_10
  local num = self:Magnitude()
  if num == 1 then
    return self
  else
    if num > 1e-05 then
      self:Div(num)
    else
      self:Set(0, 0, 0, 0)
    end
  end
  return self
end

Vector4.Div = function(self, d)
  -- function num : 0_11
  self.x = self.x / d
  self.y = self.y / d
  self.z = self.z / d
  self.w = self.w / d
  return self
end

Vector4.Mul = function(self, d)
  -- function num : 0_12
  self.x = self.x * d
  self.y = self.y * d
  self.z = self.z * d
  self.w = self.w * d
  return self
end

Vector4.Add = function(self, b)
  -- function num : 0_13
  self.x = self.x + b.x
  self.y = self.y + b.y
  self.z = self.z + b.z
  self.w = self.w + b.w
  return self
end

Vector4.Sub = function(self, b)
  -- function num : 0_14
  self.x = self.x - b.x
  self.y = self.y - b.y
  self.z = self.z - b.z
  self.w = self.w - b.w
  return self
end

Vector4.Dot = function(a, b)
  -- function num : 0_15
  return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w
end

Vector4.Project = function(a, b)
  -- function num : 0_16 , upvalues : Vector4
  local s = (Vector4.Dot)(a, b) / (Vector4.Dot)(b, b)
  return b * s
end

Vector4.Distance = function(a, b)
  -- function num : 0_17 , upvalues : Vector4
  local v = a - b
  return (Vector4.Magnitude)(v)
end

Vector4.Magnitude = function(a)
  -- function num : 0_18 , upvalues : sqrt
  return sqrt(a.x * a.x + a.y * a.y + a.z * a.z + a.w * a.w)
end

Vector4.SqrMagnitude = function(a)
  -- function num : 0_19
  return a.x * a.x + a.y * a.y + a.z * a.z + a.w * a.w
end

Vector4.Min = function(lhs, rhs)
  -- function num : 0_20 , upvalues : Vector4, max
  return (Vector4.New)(max(lhs.x, rhs.x), max(lhs.y, rhs.y), max(lhs.z, rhs.z), max(lhs.w, rhs.w))
end

Vector4.Max = function(lhs, rhs)
  -- function num : 0_21 , upvalues : Vector4, min
  return (Vector4.New)(min(lhs.x, rhs.x), min(lhs.y, rhs.y), min(lhs.z, rhs.z), min(lhs.w, rhs.w))
end

Vector4.__tostring = function(self)
  -- function num : 0_22 , upvalues : _ENV
  return (string.format)("[%f,%f,%f,%f]", self.x, self.y, self.z, self.w)
end

Vector4.__div = function(va, d)
  -- function num : 0_23 , upvalues : Vector4
  return (Vector4.New)(va.x / d, va.y / d, va.z / d, va.w / d)
end

Vector4.__mul = function(va, d)
  -- function num : 0_24 , upvalues : Vector4
  return (Vector4.New)(va.x * d, va.y * d, va.z * d, va.w * d)
end

Vector4.__add = function(va, vb)
  -- function num : 0_25 , upvalues : Vector4
  return (Vector4.New)(va.x + vb.x, va.y + vb.y, va.z + vb.z, va.w + vb.w)
end

Vector4.__sub = function(va, vb)
  -- function num : 0_26 , upvalues : Vector4
  return (Vector4.New)(va.x - vb.x, va.y - vb.y, va.z - vb.z, va.w - vb.w)
end

Vector4.__unm = function(va)
  -- function num : 0_27 , upvalues : Vector4
  return (Vector4.New)(-va.x, -va.y, -va.z, -va.w)
end

Vector4.__eq = function(va, vb)
  -- function num : 0_28 , upvalues : Vector4
  local v = va - vb
  local delta = (Vector4.SqrMagnitude)(v)
  do return delta < 1e-10 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

_getter.zero = function()
  -- function num : 0_29 , upvalues : Vector4
  return (Vector4.New)(0, 0, 0, 0)
end

_getter.one = function()
  -- function num : 0_30 , upvalues : Vector4
  return (Vector4.New)(1, 1, 1, 1)
end

_getter.magnitude = Vector4.Magnitude
_getter.normalized = Vector4.Normalize
_getter.sqrMagnitude = Vector4.SqrMagnitude
Vector4.unity_vector4 = (CS.UnityEngine).Vector4
-- DECOMPILER ERROR at PC89: Confused about usage of register: R9 in 'UnsetPending'

;
(CS.UnityEngine).Vector4 = Vector4
setmetatable(Vector4, Vector4)
return Vector4

