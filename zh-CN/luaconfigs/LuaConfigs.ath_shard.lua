-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1008}
local __rt_2 = {1008, 1009}
local ath_shard = {
[3] = {
{
shardNumList = {6}
}
, 
{
shardNumList = {7}
, size = 2}
; 
[4] = {size = 4}
, 
[8] = {
shardNumList = {12}
, size = 8}
}
, 
[4] = {
{quality = 4, 
shardNumList = {13}
}
, 
{quality = 4, 
shardNumList = {15}
, size = 2}
; 
[4] = {quality = 4, 
shardNumList = {20}
, size = 4}
, 
[8] = {quality = 4, 
shardNumList = {25}
, size = 8}
}
, 
[5] = {
{quality = 5, shardIdList = __rt_2, 
shardNumList = {39, 1}
}
, 
{quality = 5, shardIdList = __rt_2, 
shardNumList = {45, 1}
, size = 2}
; 
[4] = {quality = 5, shardIdList = __rt_2, 
shardNumList = {60, 1}
, size = 4}
, 
[8] = {quality = 5, shardIdList = __rt_2, 
shardNumList = {75, 1}
, size = 8}
}
}
local __default_values = {quality = 3, shardIdList = __rt_1, 
shardNumList = {10}
, size = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(ath_shard) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(ath_shard, {__index = __rawdata})
return ath_shard

