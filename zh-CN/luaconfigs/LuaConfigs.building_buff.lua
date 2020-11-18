-- params : ...
-- function num : 0 , upvalues : _ENV
local building_buff = {
[3] = {buff_text = 110117, id = 3}
, 
[4] = {buff_text = 439906, id = 4}
, 
[5] = {buff_text = 518207, id = 5}
, 
[6] = {buff_text = 371008, id = 6}
, 
[7] = {buff_text = 3788, id = 7}
, 
[8] = {buff_text = 399801, id = 8}
, 
[9] = {buff_text = 344898, id = 9}
, 
[10] = {buff_text = 236848}
, 
[11] = {buff_text = 432036, id = 11}
, 
[12] = {buff_text = 471889, id = 12}
, 
[13] = {buff_text = 391554, id = 13}
, 
[14] = {id = 14}
, 
[15] = {buff_text = 79346, id = 15}
, 
[16] = {buff_text = 178627, id = 16}
, 
[17] = {buff_text = 295025, id = 17}
, 
[20] = {buff_text = 269269, id = 20}
, 
[21] = {buff_text = 308241, id = 21}
}
local __default_values = {buff_text = 108051, id = 10}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(building_buff) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(building_buff, {__index = __rawdata})
return building_buff

