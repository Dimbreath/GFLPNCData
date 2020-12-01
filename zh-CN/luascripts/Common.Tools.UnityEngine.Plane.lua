-- params : ...
-- function num : 0 , upvalues : _ENV
local setmetatable = setmetatable
local Mathf = Mathf
local Vector3 = Vector3
local Plane = {}
local unity_plane = (CS.UnityEngine).Plane
Plane.__index = function(t, k)
  -- function num : 0_0 , upvalues : _ENV, Plane
  return rawget(Plane, k)
end

Plane.__call = function(t, v)
  -- function num : 0_1 , upvalues : Plane
  return (Plane.New)(v)
end

Plane.New = function(normal, d)
  -- function num : 0_2 , upvalues : setmetatable, Plane
  return setmetatable({normal = normal:Normalize(), distance = d}, Plane)
end

Plane.Get = function(self)
  -- function num : 0_3
  return self.normal, self.distance
end

Plane.Raycast = function(self, ray)
  -- function num : 0_4 , upvalues : Vector3, Mathf
  local a = (Vector3.Dot)(ray.direction, self.normal)
  local num2 = -(Vector3.Dot)(ray.origin, self.normal) - self.distance
  if (Mathf.Approximately)(a, 0) then
    return false, 0
  end
  local enter = num2 / a
  do return enter > 0, enter end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Plane.SetNormalAndPosition = function(self, inNormal, inPoint)
  -- function num : 0_5 , upvalues : Vector3
  self.normal = inNormal:Normalize()
  self.distance = -(Vector3.Dot)(inNormal, inPoint)
end

Plane.Set3Points = function(self, a, b, c)
  -- function num : 0_6 , upvalues : Vector3
  self.normal = (Vector3.Normalize)((Vector3.Cross)(b - a, c - a))
  self.distance = -(Vector3.Dot)(self.normal, a)
end

Plane.GetDistanceToPoint = function(self, inPt)
  -- function num : 0_7 , upvalues : Vector3
  return (Vector3.Dot)(self.normal, inPt) + self.distance
end

Plane.GetSide = function(self, inPt)
  -- function num : 0_8 , upvalues : Vector3
  do return (Vector3.Dot)(self.normal, inPt) + self.distance > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Plane.SameSide = function(self, inPt0, inPt1)
  -- function num : 0_9
  local distanceToPoint = self:GetDistanceToPoint(inPt0)
  local num2 = self:GetDistanceToPoint(inPt1)
  do return (distanceToPoint > 0 and num2 > 0) or (distanceToPoint <= 0 and num2 <= 0) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Plane.unity_plane = (CS.UnityEngine).Plane
-- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

;
(CS.UnityEngine).Plane = Plane
setmetatable(Plane, Plane)
return Plane

-- params : ...
-- function num : 0 , upvalues : _ENV
local setmetatable = setmetatable
local Mathf = Mathf
local Vector3 = Vector3
local Plane = {}
local unity_plane = (CS.UnityEngine).Plane
Plane.__index = function(t, k)
    -- function num : 0_0 , upvalues : _ENV, Plane
    return rawget(Plane, k)
end

Plane.__call = function(t, v)
    -- function num : 0_1 , upvalues : Plane
    return (Plane.New)(v)
end

Plane.New = function(normal, d)
    -- function num : 0_2 , upvalues : setmetatable, Plane
    return setmetatable({normal = normal:Normalize(), distance = d}, Plane)
end

Plane.Get = function(self)
    -- function num : 0_3
    return self.normal, self.distance
end

Plane.Raycast = function(self, ray)
    -- function num : 0_4 , upvalues : Vector3, Mathf
    local a = (Vector3.Dot)(ray.direction, self.normal)
    local num2 = -(Vector3.Dot)(ray.origin, self.normal) - self.distance
    if (Mathf.Approximately)(a, 0) then return false, 0 end
    local enter = num2 / a
    do return enter > 0, enter end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Plane.SetNormalAndPosition = function(self, inNormal, inPoint)
    -- function num : 0_5 , upvalues : Vector3
    self.normal = inNormal:Normalize()
    self.distance = -(Vector3.Dot)(inNormal, inPoint)
end

Plane.Set3Points = function(self, a, b, c)
    -- function num : 0_6 , upvalues : Vector3
    self.normal = (Vector3.Normalize)((Vector3.Cross)(b - a, c - a))
    self.distance = -(Vector3.Dot)(self.normal, a)
end

Plane.GetDistanceToPoint = function(self, inPt)
    -- function num : 0_7 , upvalues : Vector3
    return (Vector3.Dot)(self.normal, inPt) + self.distance
end

Plane.GetSide = function(self, inPt)
    -- function num : 0_8 , upvalues : Vector3
    do return (Vector3.Dot)(self.normal, inPt) + self.distance > 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Plane.SameSide = function(self, inPt0, inPt1)
    -- function num : 0_9
    local distanceToPoint = self:GetDistanceToPoint(inPt0)
    local num2 = self:GetDistanceToPoint(inPt1)
    do
        return (distanceToPoint > 0 and num2 > 0) or
                   (distanceToPoint <= 0 and num2 <= 0)
    end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Plane.unity_plane = (CS.UnityEngine).Plane -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'
;
(CS.UnityEngine).Plane = Plane
setmetatable(Plane, Plane)
return Plane

