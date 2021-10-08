local portrait_frame = {
[400001] = {achieve = 1, achieve_name = 325556, locked = 1, name = 325556, type = 1, type_name = 325556}
, 
[400002] = {icon = "UsertHeadFrame_1", id = 400002, name = 162139}
, 
[400003] = {icon = "UsertHeadFrame_2", id = 400003, name = 493547}
, 
[400004] = {icon = "UsertHeadFrame_3", id = 400004}
, 
[400005] = {icon = "UsertHeadFrame_4", id = 400005, name = 145840}
, 
[400006] = {achieve = 3, achieve_name = 276417, icon = "UsertHeadFrame_5", id = 400006, name = 523409, type = 3, type_name = 298575}
}
local __default_values = {achieve = 2, achieve_name = 504769, icon = "UsertHeadFrame_0", id = 400001, is_hide = false, locked = 0, name = 140516, type = 2, type_name = 465779}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(portrait_frame) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
typeCount = {1, 4, 1; [0] = 1}
, 
types = {325556, 465779, 298575; [0] = 178435}
}
setmetatable(portrait_frame, {__index = __rawdata})
return portrait_frame

