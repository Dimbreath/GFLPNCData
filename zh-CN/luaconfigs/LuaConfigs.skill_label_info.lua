-- params : ...
-- function num : 0 , upvalues : _ENV
local skill_label_info = {
{describe = 140459, icon = "ICON_LBuff_16", name = 208885}
, 
{describe = 16732, icon_color = 1, id = 2, name = 161689}
, 
{id = 3}
, 
{describe = 432168, icon_color = 1, id = 4, name = 472814}
, 
{describe = 273527, icon = "ICON_LBuff_6", id = 5, name = 500473}
, 
{describe = 50630, icon_color = 3, id = 6, name = 20088}
, 
{describe = 303440, icon_color = 3, id = 7, name = 281507}
, 
{describe = 420922, id = 8, name = 383560}
, 
{describe = 82047, icon = "ICON_LBuff_24", icon_color = 3, id = 9, name = 487624}
, 
{describe = 297193, id = 10, name = 351229}
, 
{describe = 455648, id = 11, name = 35058}
, 
{describe = 134373, id = 12, name = 167717}
, 
{describe = 187072, icon = "ICON_LBuff_26", id = 13, name = 267011}
, 
{describe = 453161, id = 14, name = 364305}
, 
{describe = 292321, id = 15, name = 62411}
, 
{describe = 299721, id = 16, name = 196416}
, 
{describe = 206699, id = 17, name = 94102}
, 
{describe = 339219, icon_color = 1, id = 18, name = 401265}
, 
{describe = 219606, icon = "ICON_LBuff_1", id = 19, name = 327685}
, 
{describe = 160592, id = 20, name = 103404}
, 
{describe = 499775, icon_color = 1, id = 21, name = 255313}
, 
{describe = 413812, id = 22, name = 360397}
, 
{describe = 40490, icon = "ICON_LBuff_3", id = 23, name = 510086}
, 
{describe = 299727, icon = "ICON_LBuff_8", icon_color = 1, id = 24, name = 317646}
, 
{describe = 36947, icon = "ICON_LBuff_9", icon_color = 1, id = 25, name = 213597}
, 
{describe = 270746, icon = "ICON_LBuff_10", id = 26, name = 352367}
, 
{describe = 445981, icon = "ICON_LBuff_15", id = 27, name = 45989}
, 
{describe = 67359, id = 28, name = 412619}
, 
{describe = 388180, icon = "ICON_LBuff_8", icon_color = 1, id = 29, name = 356386}
, 
{describe = 136679, icon = "ICON_LBuff_33", icon_color = 3, id = 30, name = 498107}
}
local __default_values = {describe = 102693, icon = "", icon_color = 2, id = 1, name = 103005}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(skill_label_info) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(skill_label_info, {__index = __rawdata})
return skill_label_info

