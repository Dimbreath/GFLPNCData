-- params : ...
-- function num : 0 , upvalues : _ENV
local building_buff = {
[3] = {buff_text = 495012, id = 3}
, 
[4] = {id = 4}
, 
[5] = {buff_text = 126790, id = 5}
, 
[6] = {buff_text = 163695, id = 6}
, 
[7] = {buff_text = 386512, id = 7}
, 
[8] = {buff_text = 414808, id = 8}
, 
[9] = {buff_text = 88649, id = 9}
, 
[10] = {buff_text = 394087}
, 
[11] = {buff_text = 518515, id = 11}
, 
[12] = {buff_text = 366000, id = 12}
, 
[13] = {buff_text = 288769, id = 13}
, 
[14] = {buff_text = 172602, id = 14}
, 
[15] = {buff_text = 264313, id = 15}
, 
[16] = {buff_text = 293874, id = 16}
, 
[17] = {buff_text = 446416, id = 17}
, 
[20] = {buff_text = 320215, id = 20}
, 
[21] = {buff_text = 291952, id = 21}
, 
[24] = {buff_text = 401991, id = 24}
, 
[25] = {id = 25}
, 
[26] = {buff_text = 493482, id = 26}
, 
[27] = {buff_text = 440406, id = 27}
, 
[2223] = {buff_text = 122534, id = 2223}
}
local __default_values = {buff_text = 416607, id = 10}
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

