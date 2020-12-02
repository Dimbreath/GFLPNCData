-- params : ...
-- function num : 0 , upvalues : _ENV
local player_firstName = {
{first_name = 53962}
, 
{first_name = 496703, id = 2}
, 
{first_name = 209992, id = 3}
, 
{first_name = 38119, id = 4}
, 
{first_name = 418931, id = 5}
, 
{first_name = 387734, id = 6}
, 
{first_name = 252420, id = 7}
, 
{first_name = 228785, id = 8}
, 
{first_name = 494809, id = 9}
, 
{first_name = 206689, id = 10}
, 
{id = 11}
, 
{first_name = 284628, id = 12}
, 
{first_name = 23209, id = 13}
, 
{first_name = 176231, id = 14}
}
local __default_values = {first_name = 127734, id = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(player_firstName) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(player_firstName, {__index = __rawdata})
return player_firstName

