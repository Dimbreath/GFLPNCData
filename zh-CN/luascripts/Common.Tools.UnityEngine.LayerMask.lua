-- params : ...
-- function num : 0 , upvalues : _ENV
local Layer = Layer
local rawget = rawget
local setmetatable = setmetatable
local LayerMask = {}
local unity_layermask = (CS.UnityEngine).LayerMask
LayerMask.__index = function(t, k)
  -- function num : 0_0 , upvalues : rawget, LayerMask
  return rawget(LayerMask, k)
end

LayerMask.__call = function(t, v)
  -- function num : 0_1 , upvalues : setmetatable, _ENV, LayerMask
  return setmetatable({value = value or 0}, LayerMask)
end

LayerMask.New = function(value)
  -- function num : 0_2 , upvalues : setmetatable, LayerMask
  return setmetatable({value = value or 0}, LayerMask)
end

LayerMask.Get = function(self)
  -- function num : 0_3
  return self.value
end

LayerMask.NameToLayer = function(name)
  -- function num : 0_4 , upvalues : Layer
  return Layer[name]
end

LayerMask.GetMask = function(...)
  -- function num : 0_5 , upvalues : LayerMask
  local arg = {...}
  local value = 0
  for i = 1, #arg do
    local n = (LayerMask.NameToLayer)(arg[i])
    if n ~= nil then
      value = value + 2 ^ n
    end
  end
  return value
end

LayerMask.unity_layermask = (CS.UnityEngine).LayerMask
-- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

;
(CS.UnityEngine).LayerMask = LayerMask
setmetatable(LayerMask, LayerMask)
return LayerMask

