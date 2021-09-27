local lottery = {
{
[101] = {lottery_id = 1, reward_type = 101}
, 
[102] = {lottery_id = 1, reward_type = 102}
, 
[103] = {lottery_id = 1, reward_type = 103}
}
, 
{
[201] = {reward_type = 201}
, 
[202] = {reward_type = 202}
, 
[203] = {reward_type = 203}
, 
[204] = {reward_type = 204}
}
; 
[4] = {
[401] = {lottery_id = 4, reward_type = 401}
, 
[402] = {lottery_id = 4, reward_type = 402}
, 
[403] = {lottery_id = 4, reward_type = 403}
}
, 
[5] = {
[501] = {lottery_id = 5, reward_type = 501}
, 
[502] = {lottery_id = 5, reward_type = 502}
, 
[503] = {lottery_id = 5, reward_type = 503}
}
, 
[6] = {
[601] = {lottery_id = 6, reward_type = 601}
, 
[602] = {lottery_id = 6, reward_type = 602}
, 
[603] = {lottery_id = 6, reward_type = 603}
}
, 
[7] = {
[0] = {lottery_id = 7}
}
}
local __default_values = {lottery_id = 2, reward_type = 0}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(lottery) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(lottery, {__index = __rawdata})
return lottery

