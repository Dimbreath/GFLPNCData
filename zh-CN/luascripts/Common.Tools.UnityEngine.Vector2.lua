-- params : ...
-- function num : 0 , upvalues : _ENV
local sqrt = math.sqrt
local setmetatable = setmetatable
local rawget = rawget
local math = math
local acos = math.acos
local max = math.max
local Vector2 = {}
local _getter = {}
local unity_vector2 = (CS.UnityEngine).Vector2
Vector2.__index = function(t, k)
    -- function num : 0_0 , upvalues : rawget, Vector2, _getter, unity_vector2
    local var = rawget(Vector2, k)
    if var ~= nil then return var end
    var = rawget(_getter, k)
    if var ~= nil then return var(t) end
    return rawget(unity_vector2, k)
end

Vector2.__call = function(t, x, y)
    -- function num : 0_1 , upvalues : setmetatable, Vector2
    return setmetatable({x = x or 0, y = y or 0}, Vector2)
end

Vector2.New = function(x, y)
    -- function num : 0_2 , upvalues : setmetatable, Vector2
    return setmetatable({x = x or 0, y = y or 0}, Vector2)
end

Vector2.Set = function(self, x, y)
    -- function num : 0_3
    self.x = x or 0
    self.y = y or 0
end

Vector2.Get = function(self)
    -- function num : 0_4
    return self.x, self.y
end

Vector2.SqrMagnitude = function(self)
    -- function num : 0_5
    return self.x * self.x + self.y * self.y
end

Vector2.Clone = function(self)
    -- function num : 0_6 , upvalues : setmetatable, Vector2
    return setmetatable({x = self.x, y = self.y}, Vector2)
end

Vector2.Normalize = function(v)
    -- function num : 0_7 , upvalues : sqrt, setmetatable, Vector2
    local x = v.x
    local y = v.y
    local magnitude = sqrt(x * x + y * y)
    if magnitude > 1e-05 then
        x = x / magnitude
        y = y / magnitude
    else
        x = 0
        y = 0
    end
    return setmetatable({x = x, y = y}, Vector2)
end

Vector2.SetNormalize = function(self)
    -- function num : 0_8 , upvalues : sqrt
    local magnitude = sqrt(self.x * self.x + self.y * self.y)
    if magnitude > 1e-05 then
        self.x = self.x / magnitude
        self.y = self.y / magnitude
    else
        self.x = 0
        self.y = 0
    end
    return self
end

Vector2.Dot = function(lhs, rhs)
    -- function num : 0_9
    return lhs.x * rhs.x + lhs.y * rhs.y
end

Vector2.Angle = function(from, to)
    -- function num : 0_10 , upvalues : sqrt, acos
    local x1, y1 = from.x, from.y
    local d = sqrt(x1 * x1 + y1 * y1)
    if d > 1e-05 then
        x1 = x1 / d
        y1 = y1 / d
    else
        x1 = 0
    end
    local x2, y2 = to.x, to.y
    d = sqrt(x2 * x2 + y2 * y2)
    if d > 1e-05 then
        x2 = x2 / d
        y2 = y2 / d
    else
        x2 = 0
    end
    d = x1 * x2 + y1 * y2
    if d < -1 then
        d = -1
    else
        if d > 1 then d = 1 end
    end
    return acos(d) * 57.29578
end

Vector2.Magnitude = function(v)
    -- function num : 0_11 , upvalues : sqrt
    return sqrt(v.x * v.x + v.y * v.y)
end

Vector2.Reflect = function(dir, normal)
    -- function num : 0_12 , upvalues : setmetatable, Vector2
    local dx = dir.x
    local dy = dir.y
    local nx = normal.x
    local ny = normal.y
    local s = -2 * (dx * nx + dy * ny)
    return setmetatable({x = s * nx + dx, y = s * ny + dy}, Vector2)
end

Vector2.Distance = function(a, b)
    -- function num : 0_13 , upvalues : sqrt
    return sqrt(a.x - b.x ^ 2 + a.y - b.y ^ 2)
end

Vector2.Lerp = function(a, b, t)
    -- function num : 0_14 , upvalues : setmetatable, Vector2
    if t < 0 then
        t = 0
    else
        if t > 1 then t = 1 end
    end
    return setmetatable({x = a.x + (b.x - a.x) * t, y = a.y + (b.y - a.y) * t},
                        Vector2)
end

Vector2.LerpUnclamped = function(a, b, t)
    -- function num : 0_15 , upvalues : setmetatable, Vector2
    return setmetatable({x = a.x + (b.x - a.x) * t, y = a.y + (b.y - a.y) * t},
                        Vector2)
end

Vector2.MoveTowards = function(current, target, maxDistanceDelta)
    -- function num : 0_16 , upvalues : sqrt, setmetatable, Vector2
    local cx = current.x
    local cy = current.y
    local x = target.x - cx
    local y = target.y - cy
    local s = x * x + y * y
    if maxDistanceDelta * maxDistanceDelta < s and s ~= 0 then
        s = maxDistanceDelta / sqrt(s)
        return setmetatable({x = cx + x * (s), y = cy + y * (s)}, Vector2)
    end
    return setmetatable({x = target.x, y = target.y}, Vector2)
end

Vector2.ClampMagnitude = function(v, maxLength)
    -- function num : 0_17 , upvalues : sqrt, setmetatable, Vector2
    local x = v.x
    local y = v.y
    local sqrMag = x * x + y * y
    do
        if maxLength * maxLength < sqrMag then
            local mag = maxLength / sqrt(sqrMag)
            x = x * mag
            y = y * mag
            return setmetatable({x = x, y = y}, Vector2)
        end
        return setmetatable({x = x, y = y}, Vector2)
    end
end

Vector2.SmoothDamp = function(current, target, Velocity, smoothTime, maxSpeed,
                              deltaTime)
    -- function num : 0_18 , upvalues : _ENV, math, sqrt, setmetatable, Vector2
    if not deltaTime then deltaTime = Time.deltaTime end
    if not maxSpeed then maxSpeed = math.huge end
    smoothTime = (math.max)(0.0001, smoothTime)
    local num = 2 / smoothTime
    local num2 = num * deltaTime
    num2 = 1 / (1 + num2 + 0.48 * num2 * num2 + 0.235 * num2 * num2 * num2)
    local tx = target.x
    local ty = target.y
    local cx = current.x
    local cy = current.y
    local vecx = cx - tx
    local vecy = cy - ty
    local m = vecx * vecx + vecy * vecy
    local n = maxSpeed * smoothTime
    if n * n < m then
        m = n / sqrt(m)
        vecx = vecx * (m)
        vecy = vecy * (m)
    end
    m = Velocity.x
    n = Velocity.y
    local vec3x = (m + num * (vecx)) * deltaTime
    local vec3y = (n + num * (vecy)) * deltaTime
    Velocity.x = (m - num * vec3x) * (num2)
    Velocity.y = (n - num * vec3y) * (num2)
    m = cx - vecx + (vecx + vec3x) * (num2)
    n = cy - vecy + (vecy + vec3y) * (num2)
    if (tx - cx) * (m - tx) + (ty - cy) * (n - ty) > 0 then
        m = tx
        n = ty
        Velocity.x = 0
        Velocity.y = 0
    end
    return setmetatable({x = m, y = n}, Vector2), Velocity
end

Vector2.Max = function(a, b)
    -- function num : 0_19 , upvalues : setmetatable, math, Vector2
    return setmetatable({x = (math.max)(a.x, b.x), y = (math.max)(a.y, b.y)},
                        Vector2)
end

Vector2.Min = function(a, b)
    -- function num : 0_20 , upvalues : setmetatable, math, Vector2
    return setmetatable({x = (math.min)(a.x, b.x), y = (math.min)(a.y, b.y)},
                        Vector2)
end

Vector2.Scale = function(a, b)
    -- function num : 0_21 , upvalues : setmetatable, Vector2
    return setmetatable({x = a.x * b.x, y = a.y * b.y}, Vector2)
end

Vector2.Div = function(self, d)
    -- function num : 0_22
    self.x = self.x / d
    self.y = self.y / d
    return self
end

Vector2.Mul = function(self, d)
    -- function num : 0_23
    self.x = self.x * d
    self.y = self.y * d
    return self
end

Vector2.Add = function(self, b)
    -- function num : 0_24
    self.x = self.x + b.x
    self.y = self.y + b.y
    return self
end

Vector2.Sub = function(self, b)
    -- function num : 0_25
    self.x = self.x - b.x
    self.y = self.y - b.y
    return
end

Vector2.__tostring = function(self)
    -- function num : 0_26 , upvalues : _ENV
    return (string.format)("(%f,%f)", self.x, self.y)
end

Vector2.__div = function(va, d)
    -- function num : 0_27 , upvalues : setmetatable, Vector2
    return setmetatable({x = va.x / d, y = va.y / d}, Vector2)
end

Vector2.__mul = function(a, d)
    -- function num : 0_28 , upvalues : _ENV, setmetatable, Vector2
    if type(d) == "number" then
        return setmetatable({x = a.x * d, y = a.y * d}, Vector2)
    else
        return setmetatable({x = a * d.x, y = a * d.y}, Vector2)
    end
end

Vector2.__add = function(a, b)
    -- function num : 0_29 , upvalues : setmetatable, Vector2
    return setmetatable({x = a.x + b.x, y = a.y + b.y}, Vector2)
end

Vector2.__sub = function(a, b)
    -- function num : 0_30 , upvalues : setmetatable, Vector2
    return setmetatable({x = a.x - b.x, y = a.y - b.y}, Vector2)
end

Vector2.__unm = function(v)
    -- function num : 0_31 , upvalues : setmetatable, Vector2
    return setmetatable({x = -v.x, y = -v.y}, Vector2)
end

Vector2.__eq = function(a, b)
    -- function num : 0_32
    do return a.x - b.x ^ 2 + a.y - b.y ^ 2 < 9.999999e-11 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

_getter.up = function()
    -- function num : 0_33 , upvalues : setmetatable, Vector2
    return setmetatable({x = 0, y = 1}, Vector2)
end

_getter.right = function()
    -- function num : 0_34 , upvalues : setmetatable, Vector2
    return setmetatable({x = 1, y = 0}, Vector2)
end

_getter.zero = function()
    -- function num : 0_35 , upvalues : setmetatable, Vector2
    return setmetatable({x = 0, y = 0}, Vector2)
end

_getter.one = function()
    -- function num : 0_36 , upvalues : setmetatable, Vector2
    return setmetatable({x = 1, y = 1}, Vector2)
end

_getter.magnitude = Vector2.Magnitude
_getter.normalized = Vector2.Normalize
_getter.sqrMagnitude = Vector2.SqrMagnitude
Vector2.unity_vector2 = (CS.UnityEngine).Vector2 -- DECOMPILER ERROR at PC98: Confused about usage of register: R9 in 'UnsetPending'
;
(CS.UnityEngine).Vector2 = Vector2
setmetatable(Vector2, Vector2)
return Vector2

