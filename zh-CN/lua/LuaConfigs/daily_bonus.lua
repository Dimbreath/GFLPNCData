local __rt_1 = {1003}
local __rt_2 = {1501}
local __rt_3 = {6001}
local __rt_4 = {1}
local __rt_5 = {2}
local __rt_6 = {1002}
local __rt_7 = {50}
local __rt_8 = {3005}
local __rt_9 = {5002}
local __rt_10 = {8102}
local __rt_11 = {3001}
local daily_bonus = {
{
award_nums = {2000}
}
, 
{
award_ids = {5001}
, 
award_nums = {5}
, day = 2}
, 
{award_ids = __rt_2, 
award_nums = {100}
, day = 3}
, 
{award_ids = __rt_3, day = 4}
, 
{
award_ids = {8101}
, award_nums = __rt_5, day = 5}
, 
{award_ids = __rt_6, award_nums = __rt_7, day = 6}
, 
{award_ids = __rt_8, day = 7}
, 
{
award_nums = {3500}
, day = 8}
, 
{award_ids = __rt_9, award_nums = __rt_5, day = 9}
, 
{
award_nums = {4000}
, day = 10}
, 
{award_ids = __rt_3, award_nums = __rt_5, day = 11}
, 
{award_ids = __rt_10, day = 12}
, 
{award_ids = __rt_6, award_nums = __rt_7, day = 13}
, 
{award_ids = __rt_11, day = 14}
, 
{
award_nums = {5000}
, day = 15}
, 
{award_ids = __rt_9, 
award_nums = {4}
, day = 16}
, 
{award_ids = __rt_2, 
award_nums = {200}
, day = 17}
, 
{award_ids = __rt_3, 
award_nums = {3}
, day = 18}
, 
{award_ids = __rt_10, award_nums = __rt_5, day = 19}
, 
{award_ids = __rt_6, award_nums = __rt_7, day = 20}
, 
{award_ids = __rt_8, award_nums = __rt_5, day = 21}
, 
{
award_nums = {6000}
, day = 22}
, 
{award_ids = __rt_9, 
award_nums = {6}
, day = 23}
, 
{
award_nums = {7000}
, day = 24}
, 
{
award_ids = {6002}
, day = 25}
, 
{
award_ids = {8103}
, day = 26}
, 
{award_ids = __rt_6, award_nums = __rt_7, day = 27}
, 
{award_ids = __rt_11, day = 28}
, 
{
award_nums = {8000}
, day = 29}
, 
{award_ids = __rt_9, 
award_nums = {8}
, day = 30}
, 
{award_ids = __rt_2, 
award_nums = {300}
, day = 31}
}
local __default_values = {award_ids = __rt_1, award_nums = __rt_4, day = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(daily_bonus) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(daily_bonus, {__index = __rawdata})
return daily_bonus

