-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {4000, 10}
local __rt_2 = {8000, 20}
local __rt_3 = {12000, 30}
local __rt_4 = {15000, 40}
local __rt_5 = {}
local __rt_6 = {countList = __rt_5}
local hero_skill_level = {
{
{countList = __rt_1, 
itemIdList = {1003, 1504}
}
, 
{countList = __rt_2, 
itemIdList = {1003, 1509}
}
, 
{
itemIdList = {1003, 1514}
}
, 
{countList = __rt_4, 
itemIdList = {1003, 1519}
}
, __rt_6}
, 
{
{countList = __rt_1, 
itemIdList = {1003, 1503}
}
, 
{countList = __rt_2, 
itemIdList = {1003, 1508}
}
, 
{
itemIdList = {1003, 1513}
}
, 
{countList = __rt_4, 
itemIdList = {1003, 1518}
}
, __rt_6}
, 
{
{countList = __rt_1, 
itemIdList = {1003, 1505}
}
, 
{countList = __rt_2, 
itemIdList = {1003, 1510}
}
, 
{
itemIdList = {1003, 1515}
}
, 
{countList = __rt_4, 
itemIdList = {1003, 1520}
}
, __rt_6}
, 
{
{countList = __rt_1, 
itemIdList = {1003, 1502}
}
, 
{countList = __rt_2, 
itemIdList = {1003, 1507}
}
, 
{
itemIdList = {1003, 1512}
}
, 
{countList = __rt_4, 
itemIdList = {1003, 1517}
}
, __rt_6}
, 
{
{countList = __rt_1, 
itemIdList = {1003, 1501}
}
, 
{countList = __rt_2, 
itemIdList = {1003, 1506}
}
, 
{
itemIdList = {1003, 1511}
}
, 
{countList = __rt_4, 
itemIdList = {1003, 1516}
}
, __rt_6}
}
local __default_values = {countList = __rt_3, itemIdList = __rt_5}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(hero_skill_level) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base, 
allSkillUpItemIdList = {1003, 1504, 1509, 1514, 1519, 1503, 1508, 1513, 1518, 1505, 1510, 1515, 1520, 1502, 1507, 1512, 1517, 1501, 1506, 1511, 1516}
}
setmetatable(hero_skill_level, {__index = __rawdata})
return hero_skill_level

