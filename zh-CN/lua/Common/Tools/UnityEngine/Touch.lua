local zero = Vector2.zero
local rawget = rawget
local setmetatable = setmetatable
TouchPhase = {Began = 0, Moved = 1, Stationary = 2, Ended = 3, Canceled = 4}
TouchBits = {DeltaPosition = 1, Position = 2, RawPosition = 4, ALL = 7}
local TouchPhase = TouchPhase
local TouchBits = TouchBits
local Touch = {}
local unity_touch = (CS.UnityEngine).Touch
local unity_touchphase = (CS.UnityEngine).TouchPhase
Touch.__index = function(t, k)
  -- function num : 0_0 , upvalues : rawget, Touch, unity_touch
  local var = rawget(Touch, k)
  if var ~= nil then
    return var
  end
  return rawget(unity_touch, k)
end

Touch.New = function(fingerId, position, rawPosition, deltaPosition, deltaTime, tapCount, phase)
  -- function num : 0_1 , upvalues : setmetatable, zero, Touch
  return setmetatable({fingerId = fingerId or 0, position = position or zero, rawPosition = rawPosition or zero, deltaPosition = deltaPosition or zero, deltaTime = deltaTime or 0, tapCount = tapCount or 0, phase = phase or 0}, Touch)
end

Touch.Init = function(self, fingerId, position, rawPosition, deltaPosition, deltaTime, tapCount, phase)
  -- function num : 0_2
  self.fingerId = fingerId
  self.position = position
  self.rawPosition = rawPosition
  self.deltaPosition = deltaPosition
  self.deltaTime = deltaTime
  self.tapCount = tapCount
  self.phase = phase
end

Touch.Destroy = function(self)
  -- function num : 0_3
  self.position = nil
  self.rawPosition = nil
  self.deltaPosition = nil
end

Touch.GetMask = function(...)
  -- function num : 0_4 , upvalues : TouchBits
  local arg = {...}
  local value = 0
  for i = 1, #arg do
    local n = TouchBits[arg[i]] or 0
    if n ~= 0 then
      value = value + n
    end
  end
  if value == 0 then
    value = TouchBits.all
  end
  return value
end

TouchPhase.unity_touchphase = (CS.UnityEngine).TouchPhase
Touch.unity_touch = (CS.UnityEngine).Touch
-- DECOMPILER ERROR at PC46: Confused about usage of register: R8 in 'UnsetPending'

;
(CS.UnityEngine).TouchPhase = TouchPhase
-- DECOMPILER ERROR at PC49: Confused about usage of register: R8 in 'UnsetPending'

;
(CS.UnityEngine).Touch = Touch
setmetatable(Touch, Touch)
return Touch

