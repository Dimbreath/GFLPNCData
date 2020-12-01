-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {3000, 10, 5}
local __rt_3 = {6000, 15, 4}
local __rt_4 = {10000, 20, 4}
local __rt_5 = {}
local __rt_6 = {countList = __rt_5, itemIdList = __rt_5}
local hero_skill_level = {
{__rt_1, 
{countList = __rt_2, 
itemIdList = {1003, 5003, 1504}
}
, 
{countList = __rt_3, 
itemIdList = {1003, 5003, 1509}
}
, 
{countList = __rt_4, 
itemIdList = {1003, 5003, 1514}
}
, __rt_6}
, 
{__rt_1, 
{countList = __rt_2, 
itemIdList = {1003, 5003, 1503}
}
, 
{countList = __rt_3, 
itemIdList = {1003, 5003, 1508}
}
, 
{countList = __rt_4, 
itemIdList = {1003, 5003, 1513}
}
, __rt_6}
, 
{__rt_1, 
{countList = __rt_2, 
itemIdList = {1003, 5003, 1505}
}
, 
{countList = __rt_3, 
itemIdList = {1003, 5003, 1510}
}
, 
{countList = __rt_4, 
itemIdList = {1003, 5003, 1515}
}
, __rt_6}
, 
{__rt_1, 
{countList = __rt_2, 
itemIdList = {1003, 5003, 1502}
}
, 
{countList = __rt_3, 
itemIdList = {1003, 5003, 1507}
}
, 
{countList = __rt_4, 
itemIdList = {1003, 5003, 1512}
}
, __rt_6}
, 
{__rt_1, 
{countList = __rt_2, 
itemIdList = {1003, 5003, 1501}
}
, 
{countList = __rt_3, 
itemIdList = {1003, 5003, 1506}
}
, 
{countList = __rt_4, 
itemIdList = {1003, 5003, 1511}
}
, __rt_6}
}
local __default_values = {
countList = {1000, 5}
, 
itemIdList = {1003, 5003}
}
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
allSkillUpItemIdList = {1003, 5003, 1504, 1509, 1514, 1503, 1508, 1513, 1505, 1510, 1515, 1502, 1507, 1512, 1501, 1506, 1511}
}
setmetatable(hero_skill_level, {__index = __rawdata})
return hero_skill_level

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {3000, 10, 5}
local __rt_3 = {6000, 15, 4}
local __rt_4 = {10000, 20, 4}
local __rt_5 = {}
local __rt_6 = {countList = __rt_5, itemIdList = __rt_5}
local hero_skill_level = {
    {
        __rt_1, {countList = __rt_2, itemIdList = {1003, 5003, 1504}},
        {countList = __rt_3, itemIdList = {1003, 5003, 1509}},
        {countList = __rt_4, itemIdList = {1003, 5003, 1514}}, __rt_6
    }, {
        __rt_1, {countList = __rt_2, itemIdList = {1003, 5003, 1503}},
        {countList = __rt_3, itemIdList = {1003, 5003, 1508}},
        {countList = __rt_4, itemIdList = {1003, 5003, 1513}}, __rt_6
    }, {
        __rt_1, {countList = __rt_2, itemIdList = {1003, 5003, 1505}},
        {countList = __rt_3, itemIdList = {1003, 5003, 1510}},
        {countList = __rt_4, itemIdList = {1003, 5003, 1515}}, __rt_6
    }, {
        __rt_1, {countList = __rt_2, itemIdList = {1003, 5003, 1502}},
        {countList = __rt_3, itemIdList = {1003, 5003, 1507}},
        {countList = __rt_4, itemIdList = {1003, 5003, 1512}}, __rt_6
    }, {
        __rt_1, {countList = __rt_2, itemIdList = {1003, 5003, 1501}},
        {countList = __rt_3, itemIdList = {1003, 5003, 1506}},
        {countList = __rt_4, itemIdList = {1003, 5003, 1511}}, __rt_6
    }
}
local __default_values = {countList = {1000, 5}, itemIdList = {1003, 5003}}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(hero_skill_level) do
    for k1, v1 in pairs(v) do setmetatable(v1, base) end
end
local __rawdata = {
    __basemetatable = base,
    allSkillUpItemIdList = {
        1003, 5003, 1504, 1509, 1514, 1503, 1508, 1513, 1505, 1510, 1515, 1502,
        1507, 1512, 1501, 1506, 1511
    }
}
setmetatable(hero_skill_level, {__index = __rawdata})
return hero_skill_level

