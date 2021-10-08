local skinTheme = {
{id = 1, name = 442396}
, 
{id = 2, name = 469118}
, 
{id = 3, name = 42619}
, 
{id = 4, name = 438702, pic = "SkinTheme4"}
, 
{id = 5, name = 518452, pic = "SkinTheme5"}
; 
[0] = {}
}
local __default_values = {id = 0, name = "", pic = "SkinTheme0"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(skinTheme) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(skinTheme, {__index = __rawdata})
return skinTheme

