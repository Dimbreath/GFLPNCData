local sign_activity = {
{}
}
local __default_values = {id = 1, name = 450158}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(sign_activity) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sign_activity, {__index = __rawdata})
return sign_activity

