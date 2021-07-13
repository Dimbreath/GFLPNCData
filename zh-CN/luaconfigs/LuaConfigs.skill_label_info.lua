-- params : ...
-- function num : 0 , upvalues : _ENV
local skill_label_info = {
{describe = 230680, icon = "ICON_LBuff_16", name = 208885}
, 
{describe = 218481, icon_color = 1, id = 2, name = 161689}
, 
{describe = 435428, id = 3, name = 103005}
, 
{describe = 432168, icon_color = 1, id = 4, name = 472814}
, 
{describe = 364303, icon = "ICON_LBuff_6", id = 5, name = 500473}
, 
{describe = 50630, icon_color = 3, id = 6, name = 20088}
, 
{describe = 426071, icon_color = 3, id = 7, name = 281507}
, 
{describe = 168720, id = 8, name = 383560}
, 
{describe = 143682, icon = "ICON_LBuff_40", id = 9, name = 99653}
, 
{describe = 481422, id = 10, name = 128432}
, 
{describe = 90315, id = 11, name = 35058}
, 
{describe = 262479, id = 12, name = 167717}
, 
{describe = 86492, id = 13, name = 267011}
, 
{describe = 361578, id = 14, name = 364305}
, 
{describe = 442174, id = 15, name = 62411}
, 
{describe = 140161, id = 16, name = 196416}
, 
{describe = 358124, id = 17, name = 94102}
, 
{describe = 339219, icon_color = 1, id = 18, name = 401265}
, 
{describe = 189045, icon = "ICON_LBuff_1", id = 19, name = 491958}
, 
{describe = 142810, id = 20, name = 103404}
, 
{describe = 257925, icon_color = 1, id = 21, name = 255313}
, 
{describe = 413812, id = 22, name = 360397}
, 
{describe = 387704, icon = "ICON_LBuff_3", id = 23, name = 149253}
, 
{describe = 299727, icon = "ICON_LBuff_8", icon_color = 1, id = 24, name = 196261}
, 
{describe = 49596, icon = "ICON_LBuff_9", icon_color = 1, id = 25, name = 213597}
, 
{describe = 402101, icon = "ICON_LBuff_10", id = 26, name = 352367}
, 
{describe = 177555, icon = "ICON_LBuff_15", id = 27, name = 45989}
, 
{describe = 87332, id = 28, name = 412619}
, 
{describe = 385460, icon = "ICON_LBuff_8", icon_color = 1, id = 29, name = 356386}
, 
{describe = 136679, icon = "ICON_LBuff_33", icon_color = 3, id = 30, name = 498107}
, 
{describe = 41564, icon_color = 1, id = 31, name = 251996}
, 
{describe = 480724, id = 32, name = 53620}
, 
{describe = 364767, id = 33, name = 392362}
, 
{describe = 45744, icon_color = 3, id = 34, name = 234624}
, 
{describe = 432188, icon_color = 1, id = 35, name = 428991}
, 
{describe = 409325, icon_color = 3, id = 36, name = 56544}
, 
{describe = 266236, icon_color = 3, id = 37, name = 236208}
, 
{describe = 485311, icon_color = 3, id = 38, name = 113218}
, 
{describe = 173426, icon_color = 3, id = 39, name = 131479}
, 
{describe = 507896, icon_color = 3, id = 40, name = 101715}
, 
{describe = 384680, icon_color = 3, id = 41, name = 39872}
, 
{describe = 196642, icon_color = 1, id = 42, name = 417914}
, 
{describe = 4366, icon_color = 3, id = 43, name = 101823}
, 
{describe = 77832, icon_color = 1, id = 44, name = 319706}
, 
{describe = 220237, icon_color = 1, id = 45, name = 386981}
, 
{describe = 412953, icon_color = 3, id = 46, name = 338221}
, 
{describe = 346687, icon_color = 3, id = 47, name = 70162}
, 
{describe = 432072, icon_color = 3, id = 48, name = 181771}
, 
{describe = 286482, icon = "ICON_LBuff_19", id = 49}
, 
{icon_color = 3, id = 50, name = 335760}
, 
{describe = 257366, icon_color = 1, id = 51, name = 274665}
, 
{describe = 450031, icon_color = 1, id = 52, name = 452571}
, 
{describe = 330869, icon_color = 1, id = 53, name = 419839}
, 
{describe = 472465, icon_color = 1, id = 54, name = 465663}
, 
{describe = 432984, icon_color = 1, id = 55, name = 26063}
, 
{describe = 256364, icon_color = 1, id = 56, name = 98750}
, 
{describe = 520235, icon_color = 1, id = 57, name = 283154}
}
local __default_values = {describe = 103478, icon = "", icon_color = 2, id = 1, name = 101323}
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

