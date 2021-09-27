local portrait_card = {
[410001] = {name = 438632}
, 
[410002] = {icon = "UserInfo_1", id = 410002, name = 425640}
, 
[410003] = {icon = "UserInfo_2", id = 410003, name = 435926}
, 
[410004] = {icon = "UserInfo_3", id = 410004, name = 334425}
, 
[410005] = {icon = "UserInfo_4", id = 410005, name = 390072}
, 
[410006] = {icon = "UserInfo_5", id = 410006, name = 354726}
, 
[410007] = {icon = "UserInfo_6", id = 410007}
}
local __default_values = {icon = "UserInfo_0", id = 410001, is_hide = false, name = 127091}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(portrait_card) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(portrait_card, {__index = __rawdata})
return portrait_card

