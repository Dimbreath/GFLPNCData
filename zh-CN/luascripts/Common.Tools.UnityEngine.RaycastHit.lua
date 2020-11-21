-- params : ...
-- function num : 0 , upvalues : _ENV
local rawget = rawget
local setmetatable = setmetatable
RaycastBits = {
    Collider = 1,
    Normal = 2,
    Point = 4,
    Rigidbody = 8,
    Transform = 16,
    ALL = 31
}
local RaycastBits = RaycastBits
local RaycastHit = {}
local unity_raycasthit = (CS.UnityEngine).RaycastHit
RaycastHit.__index = function(t, k)
    -- function num : 0_0 , upvalues : rawget, RaycastHit, unity_raycasthit
    local var = rawget(RaycastHit, k)
    if var ~= nil then return var end
    return rawget(unity_raycasthit, k)
end

RaycastHit.New = function(collider, distance, normal, point, rigidbody,
                          transform)
    -- function num : 0_1 , upvalues : setmetatable, RaycastHit
    local hit = {
        collider = collider,
        distance = distance,
        normal = normal,
        point = point,
        rigidbody = rigidbody,
        transform = transform
    }
    setmetatable(hit, RaycastHit)
    return hit
end

RaycastHit.Init = function(self, collider, distance, normal, point, rigidbody,
                           transform)
    -- function num : 0_2
    self.collider = collider
    self.distance = distance
    self.normal = normal
    self.point = point
    self.rigidbody = rigidbody
    self.transform = transform
end

RaycastHit.Get = function(self)
    -- function num : 0_3
    return self.collider, self.distance, self.normal, self.point,
           self.rigidbody, self.transform
end

RaycastHit.Destroy = function(self)
    -- function num : 0_4
    self.collider = nil
    self.rigidbody = nil
    self.transform = nil
end

RaycastHit.GetMask = function(...)
    -- function num : 0_5 , upvalues : RaycastBits
    local arg = {...}
    local value = 0
    for i = 1, #arg do
        local n = RaycastBits[arg[i]] or 0
        if n ~= 0 then value = value + n end
    end
    if value == 0 then value = RaycastBits.all end
    return value
end

RaycastHit.unity_raycasthit = (CS.UnityEngine).RaycastHit -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'
;
(CS.UnityEngine).RaycastHit = RaycastHit
setmetatable(RaycastHit, RaycastHit)
return RaycastHit

