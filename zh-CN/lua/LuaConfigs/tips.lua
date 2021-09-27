local __rt_1 = {"1", "2"}
local tips = {
{path = "weekly"}
, 
{
content = {"1"}
, id = 2}
, 
{
content = {"2"}
, id = 3}
, 
{
content = {"3"}
, id = 4}
, 
{
content = {"4"}
, id = 5}
, 
{id = 6, path = "support"}
, 
{
content = {"1", "2", "3"}
, id = 7, path = "daily"}
, 
{
content = {"1", "2", "3", "4"}
, id = 8, path = "dorm"}
, 
{
content = {"5", "6", "7", "8"}
, id = 9, path = "dorm"}
, 
{
content = {"1", "2", "3", "7"}
, id = 10, path = "algorithm"}
, 
{
content = {"4", "5", "6"}
, id = 11, path = "algorithm"}
}
local __default_values = {content = __rt_1, id = 1, path = "level"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(tips) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(tips, {__index = __rawdata})
return tips

