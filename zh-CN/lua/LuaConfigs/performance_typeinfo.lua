local __rt_1 = {}
local __rt_2 = {489733, 2597, 405618}
local performance_typeinfo = {
{name = "resolution", 
option_group_name = {157873, 405618, 2597, 489733}
}
, 
{id = 2, name = "texture_limit", 
option_group_name = {405618, 2597, 489733}
}
, 
{id = 3, name = "frame_rate", 
option_group_name = {"30", "60"}
, warning = true}
, 
{id = 4, name = "dyn_shadow"}
, 
{id = 5, warning = true}
, 
{id = 6, name = "effect_quality", option_group_name = __rt_2}
, 
{id = 7, name = "model_quality", option_group_name = __rt_2}
, 
{id = 8, name = "outline"}
, 
{id = 9, name = "post_effect", 
option_group_name = {410728, 489733, 2597, 405618}
}
, 
{id = 10, name = "mode", 
option_group_name = {198406, 438513, 450891, 27053, 230316, 210042}
}
, 
{id = 11, name = "mumu_frame_rate", 
option_group_name = {"30", "60", "120"}
}
}
local __default_values = {id = 1, name = "anti_aliasing", option_group_name = __rt_1, warning = false}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(performance_typeinfo) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
name_index = {anti_aliasing = 5, dyn_shadow = 4, effect_quality = 6, frame_rate = 3, mode = 10, model_quality = 7, mumu_frame_rate = 11, outline = 8, post_effect = 9, resolution = 1, texture_limit = 2}
}
setmetatable(performance_typeinfo, {__index = __rawdata})
return performance_typeinfo

