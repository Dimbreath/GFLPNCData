-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local event_jump = {
{describe = 300225}
, 
{describe = 140821, id = 2}
, 
{describe = 498804, id = 3}
, 
{
choiceGetNew = {dataID = 10161, dataNum = 1}
, id = 4}
, 
{
choiceGetNew = {dataID = 10217, dataNum = 1}
, describe = 64316, id = 5}
, 
{describe = 52746, id = 6}
, 
{describe = 452612, id = 7}
, 
{describe = 199067, id = 8}
, 
{
choiceGetNew = {dataID = 10216, dataNum = 1}
, describe = 62797, id = 9}
}
local __default_values = {choiceGetNew = __rt_1, choice_color = false, describe = 105454, icon = "event_icon_func", id = 1, jump = true}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(event_jump) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(event_jump, {__index = __rawdata})
return event_jump

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local event_jump = {
    {describe = 300225}, {describe = 140821, id = 2},
    {describe = 498804, id = 3},
    {choiceGetNew = {dataID = 10161, dataNum = 1}, id = 4},
    {choiceGetNew = {dataID = 10217, dataNum = 1}, describe = 64316, id = 5},
    {describe = 52746, id = 6}, {describe = 452612, id = 7},
    {describe = 199067, id = 8},
    {choiceGetNew = {dataID = 10216, dataNum = 1}, describe = 62797, id = 9}
}
local __default_values = {
    choiceGetNew = __rt_1,
    choice_color = false,
    describe = 105454,
    icon = "event_icon_func",
    id = 1,
    jump = true
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(event_jump) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(event_jump, {__index = __rawdata})
return event_jump

