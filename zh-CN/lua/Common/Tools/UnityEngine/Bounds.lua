local rawget = rawget
local setmetatable = setmetatable
local type = type
local Vector3 = Vector3
local zero = Vector3.zero
local Bounds = {center = Vector3.zero, extents = Vector3.zero}
local _getter = {}
local unity_bounds = (CS.UnityEngine).Bounds
Bounds.__index = function(t, k)
  -- function num : 0_0 , upvalues : rawget, Bounds, _getter, unity_bounds
  local var = rawget(Bounds, k)
  if var ~= nil then
    return var
  end
  var = rawget(_getter, k)
  if var ~= nil then
    return var(t)
  end
  return rawget(unity_bounds, k)
end

Bounds.__call = function(t, center, size)
  -- function num : 0_1 , upvalues : setmetatable, Bounds
  return setmetatable({center = center, extents = size * 0.5}, Bounds)
end

Bounds.New = function(center, size)
  -- function num : 0_2 , upvalues : setmetatable, Bounds
  return setmetatable({center = center, extents = size * 0.5}, Bounds)
end

Bounds.Get = function(self)
  -- function num : 0_3
  local size = self:GetSize()
  return self.center, size
end

Bounds.GetSize = function(self)
  -- function num : 0_4
  return self.extents * 2
end

Bounds.SetSize = function(self, value)
  -- function num : 0_5
  self.extents = value * 0.5
end

Bounds.GetMin = function(self)
  -- function num : 0_6
  return self.center - self.extents
end

Bounds.SetMin = function(self, value)
  -- function num : 0_7
  self:SetMinMax(value, self:GetMax())
end

Bounds.GetMax = function(self)
  -- function num : 0_8
  return self.center + self.extents
end

Bounds.SetMax = function(self, value)
  -- function num : 0_9
  self:SetMinMax(self:GetMin(), value)
end

Bounds.SetMinMax = function(self, min, max)
  -- function num : 0_10
  self.extents = (max - min) * 0.5
  self.center = min + self.extents
end

Bounds.Encapsulate = function(self, point)
  -- function num : 0_11 , upvalues : Vector3
  self:SetMinMax((Vector3.Min)(self:GetMin(), point), (Vector3.Max)(self:GetMax(), point))
end

Bounds.Expand = function(self, amount)
  -- function num : 0_12 , upvalues : type, Vector3
  if type(amount) == "number" then
    amount = amount * 0.5
    ;
    (self.extents):Add((Vector3.New)(amount, amount, amount))
  else
    ;
    (self.extents):Add(amount * 0.5)
  end
end

Bounds.Intersects = function(self, bounds)
  -- function num : 0_13
  local min = self:GetMin()
  local max = self:GetMax()
  local min2 = bounds:GetMin()
  local max2 = bounds:GetMax()
  do return min.x <= max2.x and min2.x <= max.x and min.y <= max2.y and min2.y <= max.y and min.z <= max2.z and min2.z <= max.z end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Bounds.Contains = function(self, p)
  -- function num : 0_14
  local min = self:GetMin()
  local max = self:GetMax()
  if p.x < min.x or p.y < min.y or p.z < min.z or max.x < p.x or max.y < p.y or max.z < p.z then
    return false
  end
  return true
end

Bounds.IntersectRay = function(self, ray)
  -- function num : 0_15 , upvalues : _ENV
  local tmin = -Mathf.Infinity
  local tmax = Mathf.Infinity
  local t0, t1, f = nil, nil, nil
  local t = self:GetCenter() - ray:GetOrigin()
  local p = {t.x, t.y, t.z}
  t = self.extents
  local extent = {t.x, t.y, t.z}
  t = ray:GetDirection()
  local dir = {t.x, t.y, t.z}
  for i = 1, 3 do
    f = 1 / dir[i]
    t0 = (p[i] + extent[i]) * (f)
    t1 = (p[i] - extent[i]) * (f)
    if t0 < t1 then
      if tmin < t0 then
        tmin = t0
      end
      if t1 < tmax then
        tmax = t1
      end
      if tmax < tmin then
        return false
      end
      if tmax < 0 then
        return false
      end
    else
      if tmin < t1 then
        tmin = t1
      end
      if t0 < tmax then
        tmax = t0
      end
      if tmax < tmin then
        return false
      end
      if tmax < 0 then
        return false
      end
    end
  end
  return true, tmin
end

Bounds.ClosestPoint = function(self, point)
  -- function num : 0_16 , upvalues : _ENV
  local t = point - self:GetCenter()
  local closest = {t.x, t.y, t.z}
  local et = self.extents
  local extent = {et.x, et.y, et.z}
  local distance = 0
  local delta = nil
  for i = 1, 3 do
    if closest[i] < -extent[i] then
      delta = closest[i] + extent[i]
      distance = distance + (delta) * (delta)
      closest[i] = -extent[i]
    else
      if extent[i] < closest[i] then
        delta = closest[i] - extent[i]
        distance = distance + (delta) * (delta)
        closest[i] = extent[i]
      end
    end
  end
  if distance == 0 then
    return rkPoint, 0
  else
    outPoint = closest + self:GetCenter()
    return outPoint, distance
  end
end

Bounds.Destroy = function(self)
  -- function num : 0_17
  self.center = nil
  self.size = nil
end

Bounds.__tostring = function(self)
  -- function num : 0_18 , upvalues : _ENV
  return (string.format)("Center: %s, Extents %s", tostring(self.center), tostring(self.extents))
end

Bounds.__eq = function(a, b)
  -- function num : 0_19
  do return a.center == b.center and a.extents == b.extents end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

_getter.size = Bounds.GetSize
_getter.min = Bounds.GetMin
_getter.max = Bounds.GetMax
Bounds.unity_bounds = (CS.UnityEngine).Bounds
-- DECOMPILER ERROR at PC66: Confused about usage of register: R8 in 'UnsetPending'

;
(CS.UnityEngine).Bounds = Bounds
setmetatable(Bounds, Bounds)
return Bounds

