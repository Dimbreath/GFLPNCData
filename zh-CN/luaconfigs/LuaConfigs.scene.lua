-- params : ...
-- function num : 0 , upvalues : _ENV
local scene = {
{scene_name = "006_Arena_001"}
, 
{audio_id = 3102, deploy_rows = 2, id = 2, scene_name = "006_Arena_002", size_row = 6}
, 
{audio_id = 3101, deploy_rows = 2, id = 3, scene_name = "006_Arena_003", size_row = 6}
, 
{audio_id = 3103, id = 4, scene_name = "006_Arena_004"}
, 
{deploy_rows = 2, id = 5, size_row = 6}
, 
{id = 6, scene_name = "006_Arena_005"}
, 
{id = 7, scene_name = "006_Arena_006"}
, 
{id = 8, scene_name = "006_Arena_007"}
}
local __default_values = {audio_id = 3104, deploy_rows = 3, id = 1, scene_name = "006_Arena_000", size_col = 5, size_row = 7}
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

