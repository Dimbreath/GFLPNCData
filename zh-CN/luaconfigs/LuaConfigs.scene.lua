-- params : ...
-- function num : 0 , upvalues : _ENV
local scene = {
{scene_name = "006_Arena_001"}
, 
{id = 2, scene_name = "006_Arena_002"}
, 
{id = 3, scene_name = "006_Arena_003"}
, 
{id = 4, scene_name = "006_Arena_004"}
, 
{id = 5}
, 
{id = 6, scene_name = "006_Arena_005"}
}
local __default_values = {id = 1, scene_name = "006_Arena_000"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(scene) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(scene, {__index = __rawdata})
return scene

