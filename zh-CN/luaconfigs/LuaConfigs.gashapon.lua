-- params : ...
-- function num : 0 , upvalues : _ENV
local gashapon = {
{
[101] = {}
, 
[102] = {reward_type = 102}
, 
[103] = {reward_type = 103}
}
, 
{
[201] = {gashapon_id = 2, reward_type = 201}
, 
[202] = {gashapon_id = 2, reward_type = 202}
, 
[203] = {gashapon_id = 2, reward_type = 203}
}
}
local __default_values = {gashapon_id = 1, reward_type = 101}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(gashapon) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(gashapon, {__index = __rawdata})
return gashapon

