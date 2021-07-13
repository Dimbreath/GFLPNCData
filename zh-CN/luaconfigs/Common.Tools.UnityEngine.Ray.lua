-- params : ...
-- function num : 0 , upvalues : _ENV
local rawget = rawget
local setmetatable = setmetatable
local Vector3 = Vector3
local Ray = {direction = Vector3.zero, origin = Vector3.zero}
local unity_ray = (CS.UnityEngine).Ray
Ray.__index = function(t, k)
  -- function num : 0_0 , upvalues : rawget, Ray, unity_ray
  local var = rawget(Ray, k)
  if var ~= nil then
    return var
  end
  return rawget(unity_ray, k)
end

Ray.__call = function(t, direction, origin)
  -- function num : 0_1 , upvalues : Ray
  return (Ray.New)(direction, origin)
end

Ray.New = function(direction, origin)
  -- function num : 0_2 , upvalues : setmetatable, Ray
  local ray = {}
  ray.direction = direction:Normalize()
  ray.origin = origin
  setmetatable(ray, Ray)
  return ray
end

Ray.GetPoint = function(self, distance)
  -- function num : 0_3
  local dir = self.direction * distance
  dir:Add(self.origin)
  return dir
end

Ray.Get = function(self)
  -- function num : 0_4
  local o = self.origin
  local d = self.direction
  return o.x, o.y, o.z, d.x, d.y, d.z
end

Ray.__tostring = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return (string.format)("Origin:(%f,%f,%f),Dir:(%f,%f, %f)", (self.origin).x, (self.origin).y, (self.origin).z, (self.direction).x, (self.direction).y, (self.direction).z)
end

Ray.unity_ray = (CS.UnityEngine).Ray
-- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

;
(CS.UnityEngine).Ray = Ray
setmetatable(Ray, Ray)
return Ray

