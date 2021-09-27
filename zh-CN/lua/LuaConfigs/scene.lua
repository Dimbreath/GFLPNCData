local scene = {
{deploy_rows = 3, scene_name = "006_Arena_001", size_row = 7}
, 
{audio_id = 3102, id = 2, scene_name = "006_Arena_002"}
, 
{audio_id = 3101, id = 3, scene_name = "006_Arena_003"}
, 
{audio_id = 3103, deploy_rows = 3, id = 4, scene_name = "006_Arena_004", size_row = 7}
, 
{id = 5}
, 
{deploy_rows = 3, id = 6, scene_name = "006_Arena_005", size_row = 7}
, 
{audio_id = 3105, deploy_rows = 3, id = 7, scene_name = "006_Arena_006", size_row = 7}
, 
{deploy_rows = 3, id = 8, scene_name = "006_Arena_007", size_row = 7}
, 
{deploy_rows = 11, id = 9, scene_name = "006_Arena_SE2021_001", size_col = 7, size_row = 11}
, 
{audio_id = 3106, id = 10, scene_name = "006_Arena_008"}
, 
{audio_id = 3201, id = 11, scene_name = "006_Arena_010"}
}
local __default_values = {audio_id = 3104, deploy_rows = 2, id = 1, scene_name = "006_Arena_000", size_col = 5, size_row = 6}
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

