-- params : ...
-- function num : 0 , upvalues : _ENV
local mail = {
[102] = {}
, 
[103] = {entry = 103}
, 
[112] = {entry = 112}
, 
[113] = {entry = 113}
, 
[114] = {entry = 114, type = 1}
, 
[115] = {entry = 115, type = 1}
, 
[116] = {entry = 116}
, 
[117] = {entry = 117}
, 
[118] = {entry = 118}
, 
[119] = {entry = 119}
, 
[120] = {entry = 120}
, 
[121] = {entry = 121}
, 
[122] = {entry = 122}
, 
[123] = {entry = 123}
}
local __default_values = {entry = 102, type = 0}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(mail) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(mail, {__index = __rawdata})
return mail

