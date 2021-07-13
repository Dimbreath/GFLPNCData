-- params : ...
-- function num : 0 , upvalues : _ENV
local weekly_challenge_score = {
{const_show = true, intro = 251215, title = 464870, unit_score = 5}
, 
{const_show = true, id = 2, intro = 335844, title = 93063}
, 
{const_show = true, id = 3, intro = 368880, unit_score = 50}
, 
{const_show = true, id = 4, title = 3606, unit_score = 5}
, 
{const_show = true, id = 5, intro = 433685, title = 334878, unit_score = 10}
, 
{const_show = true, id = 6, intro = 112001, title = 13194, unit_score = 15}
; 
[8] = {id = 8, intro = 408238, title = 176355, unit_score = 100}
, 
[10] = {check_type = 2, check_value = 100, id = 10, intro = 58494, title = 216254, unit_score = 50}
, 
[11] = {check_type = 2, check_value = 5, id = 11, intro = 364508, title = 230506}
, 
[12] = {check_type = 2, check_value = 5, id = 12, intro = 157450, title = 162730}
, 
[13] = {check_type = 2, check_value = 3000, id = 13, intro = 165321, title = 212829}
, 
[14] = {check_type = 2, check_value = 5, id = 14, intro = 350451, title = 69517}
, 
[15] = {check_type = 2, check_value = 3, id = 15, intro = 508877, title = 230912, unit_score = 50}
, 
[16] = {check_type = 3, check_value = 5, id = 16, intro = 444801, title = 184065}
, 
[17] = {check_type = 3, check_value = 1800, id = 17, intro = 187100, title = 299464, unit_score = 50}
, 
[18] = {check_type = 4, check_value = 100, id = 18, intro = 402667, title = 499723, unit_score = 3}
}
local __default_values = {check_type = 1, check_value = 0, const_show = false, id = 1, intro = 102413, max_score = 9000, title = 116344, unit_score = 25}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(weekly_challenge_score) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(weekly_challenge_score, {__index = __rawdata})
return weekly_challenge_score

