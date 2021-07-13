-- params : ...
-- function num : 0 , upvalues : _ENV
local skinTheme = {
{}
, 
{id = 2, name = 469118}
, 
{id = 3, name = 49794}
}
local __default_values = {id = 1, name = 442396, pic = "SkinTheme0"}
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

