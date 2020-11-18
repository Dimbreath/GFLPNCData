-- params : ...
-- function num : 0 , upvalues : _ENV
local chip_tag = {
{tag = 486174}
, 
{id = 2, tag = 89171}
, 
{id = 3, tag = 383560}
, 
{id = 4, tag = 6189}
, 
{id = 5, tag = 418675}
, 
{id = 6, tag = 492181}
, 
{id = 7, tag = 88940}
, 
{id = 8, tag = 261240}
, 
{id = 9, tag = 319223}
, 
{id = 10, tag = 451619}
, 
{id = 11, tag = 274718}
, 
{id = 12, tag = 44073}
, 
{id = 13, tag = 300230}
, 
{id = 14, tag = 455650}
, 
{id = 15, tag = 75457}
, 
{id = 16, tag = 75752}
, 
{id = 17, tag = 338221}
, 
{id = 18, tag = 234394}
, 
{id = 19, tag = 322510}
, 
{id = 20, tag = 38021}
, 
{id = 21, tag = 69181}
, 
{id = 22, tag = 90647}
, 
{id = 23, tag = 398534}
, 
{id = 24, tag = 344243}
, 
{id = 25, tag = 484005}
, 
{id = 26, tag = 470442}
, 
{id = 27, tag = 282599}
, 
{id = 28, tag = 195920}
, 
{id = 29, tag = 182327}
, 
{id = 30, tag = 78607}
, 
{id = 31}
}
local __default_values = {id = 1, tag = 116789}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(chip_tag) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(chip_tag, {__index = __rawdata})
return chip_tag

