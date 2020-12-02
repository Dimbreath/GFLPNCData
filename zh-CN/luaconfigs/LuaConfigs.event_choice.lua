-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local __rt_2 = {
{dataID = 1, dataNum = -1}
}
local __rt_3 = {dataID = 1, dataNum = 30}
local __rt_4 = {dataID = 1, dataNum = 40}
local __rt_5 = {dataID = 510, dataNum = 1}
local __rt_6 = {dataID = 1, dataNum = 15}
local __rt_7 = {dataID = 10015, dataNum = 1}
local __rt_8 = {dataID = 10011, dataNum = 1}
local __rt_9 = {__rt_4}
local __rt_10 = {__rt_3}
local event_choice = {
{condition = 1}
, 
{choice_color = true, condition = 1, id = 2}
, 
{
auto_choice_arg = {700}
, auto_choice_type = 1, describe = 336702, event_exit = false, icon = "event_icon_recover", id = 3}
, 
{choice_color = true, id = 4}
, 
{choice_color = true, describe = 91076, icon = "event_icon_close", id = 5}
, 
{
auto_choice_arg = {200}
, auto_choice_type = 2, describe = 388756, event_exit = false, icon = "event_icon_recover", id = 6}
, 
{
choiceDeductList = {
{dataID = 3, dataNum = 50}
}
, condition = 1, event_exit = false, id = 7}
, 
{choice_color = true, id = 8}
, 
{event_exit = false, id = 9}
, 
{choice_color = true, id = 10}
, 
{choiceDeductList = __rt_2, condition = 2, describe = 126286, event_exit = false, icon = "event_icon_stronger", id = 11}
, 
{
choiceGetNew = {dataID = 10125, dataNum = 1}
, describe = 344098, event_exit = false, icon = "event_icon_stronger", id = 12}
, 
{
choiceGetNew = {dataID = 10128, dataNum = 1}
, describe = 303634, event_exit = false, icon = "event_icon_stronger", id = 13}
, 
{describe = 441035, event_exit = false, icon = "event_icon_stronger", id = 14}
, 
{choice_color = true, id = 15}
, 
{choiceGetNew = __rt_3, describe = 496973, event_exit = false, icon = "event_icon_cache", id = 16}
, 
{describe = 97724, id = 17}
, 
{
choiceGetNew = {dataID = 1, dataNum = 50}
, describe = 58360, event_exit = false, id = 18}
, 
{describe = 446483, event_exit = false, id = 19}
, 
{describe = 463593, icon = "event_icon_cache", id = 20}
, 
{choiceGetNew = __rt_4, describe = 54644, icon = "event_icon_cache", id = 21}
, 
{describe = 486995, icon = "event_icon_cache", id = 22}
, 
{describe = 13150, icon = "event_icon_discount", id = 23}
, 
{
choiceGetNew = {dataID = 10095, dataNum = 1}
, describe = 25844, icon = "event_icon_stronger", id = 24}
, 
{choiceGetNew = __rt_5, describe = 127648, id = 25}
, 
{choiceGetNew = __rt_6, describe = 97609, id = 26}
, 
{
choiceDeductList = {__rt_5}
, condition = 1, describe = 28991, id = 27}
, 
{choiceGetNew = __rt_3, describe = 498768, id = 28}
, 
{
choiceGetNew = {dataID = 1, dataNum = 25}
, describe = 524247, icon = "event_icon_cache", id = 29}
, 
{describe = 309660, icon = "event_icon_func", id = 30}
, 
{describe = 250570, event_exit = false, id = 31}
, 
{choiceDeductList = __rt_2, describe = 11915, id = 32}
, 
{describe = 190518, id = 33}
, 
{describe = 148882, event_exit = false, icon = "event_icon_func", id = 34}
, 
{describe = 155606, icon = "event_icon_func", id = 35}
, 
{describe = 24140, icon = "event_icon_close", id = 36}
, 
{choice_color = true, id = 37}
, 
{describe = 148882, icon = "event_icon_func", id = 38}
, 
{describe = 155606, icon = "event_icon_func", id = 39}
, 
{choiceGetNew = __rt_6, id = 40}
, 
{
choiceGetNew = {dataID = 10002, dataNum = 1}
, describe = 188252, id = 41}
, 
{
choiceGetNew = {dataID = 10016, dataNum = 1}
, describe = 121460, id = 42}
, 
{
choiceGetNew = {dataID = 10004, dataNum = 1}
, describe = 107006, id = 43}
, 
{
choiceGetNew = {dataID = 10008, dataNum = 1}
, describe = 331026, id = 44}
, 
{
choiceGetNew = {dataID = 10003, dataNum = 1}
, describe = 511731, id = 45}
, 
{
choiceGetNew = {dataID = 10017, dataNum = 1}
, describe = 429068, id = 46}
, 
{
choiceGetNew = {dataID = 10009, dataNum = 1}
, describe = 276499, id = 47}
, 
{
choiceGetNew = {dataID = 10001, dataNum = 1}
, describe = 504168, id = 48}
, 
{
choiceGetNew = {dataID = 10024, dataNum = 1}
, describe = 226870, id = 49}
, 
{
choiceGetNew = {dataID = 10026, dataNum = 1}
, describe = 177778, id = 50}
, 
{
choiceGetNew = {dataID = 10010, dataNum = 1}
, describe = 252529, id = 51}
, 
{
choiceGetNew = {dataID = 10012, dataNum = 1}
, describe = 393725, id = 52}
, 
{choiceGetNew = __rt_7, describe = 455670, id = 53}
, 
{
choiceGetNew = {dataID = 10021, dataNum = 1}
, describe = 500406, id = 54}
, 
{choiceGetNew = __rt_8, describe = 207306, id = 55}
, 
{choiceGetNew = __rt_8, describe = 207306, id = 56}
, 
{
choiceGetNew = {dataID = 10020, dataNum = 1}
, describe = 256802, id = 57}
, 
{choiceGetNew = __rt_7, describe = 455670, id = 58}
, 
{describe = 106202, icon = "event_icon_resurrection", id = 59}
, 
{
choiceGetNew = {dataID = 1, dataNum = 80}
, describe = 382480, icon = "event_icon_cache", id = 60}
, 
{choiceDeductList = __rt_9, condition = 1, describe = 270537, event_exit = false, icon = "event_icon_func", id = 61}
, 
{choice_color = true, id = 62}
, 
{describe = "", event_exit = false, id = 63}
, 
{describe = 237755, event_exit = false, icon = "event_icon_func", id = 64}
, 
{describe = 129387, icon = "event_icon_func", id = 65}
, 
{describe = 141082, icon = "event_icon_func", id = 66}
, 
{describe = 153209, event_exit = false, icon = "event_icon_recover", id = 67}
, 
{
choiceGetNew = {dataID = 10, dataNum = 80000}
, describe = 455644, icon = "event_icon_ultimate", id = 68}
, 
{condition = 1, describe = 280906, event_exit = false, icon = "event_icon_func", id = 69}
, 
{
choiceDeductList = {
{dataID = 1, dataNum = 20}
}
, condition = 1, describe = 300859, event_exit = false, icon = "event_icon_func", id = 70}
, 
{
choiceGetNew = {dataID = 1, dataNum = 60}
, describe = 218562, icon = "event_icon_cache", id = 71}
, 
{describe = 129387, icon = "event_icon_func", id = 72}
, 
{describe = 285909, event_exit = false, icon = "event_icon_recover", id = 73}
, 
{describe = 106579, icon = "event_icon_func", id = 74}
, 
{describe = 129387, icon = "event_icon_func", id = 75}
, 
{choiceGetNew = __rt_3, describe = 496973, icon = "event_icon_cache", id = 76}
, 
{choice_color = true, describe = 91076, icon = "event_icon_close", id = 77}
, 
{condition = 1, describe = 389918, event_exit = false, icon = "event_icon_func", id = 78}
, 
{choiceDeductList = __rt_9, condition = 1, describe = 266454, event_exit = false, icon = "event_icon_recover", id = 79}
, 
{condition = 1, describe = 201747, event_exit = false, icon = "event_icon_func", id = 80}
, 
{choiceDeductList = __rt_9, condition = 1, describe = 266454, event_exit = false, icon = "event_icon_recover", id = 81}
, 
{condition = 1, describe = 13576, event_exit = false, icon = "event_icon_func", id = 82}
, 
{choiceDeductList = __rt_9, condition = 1, describe = 266454, event_exit = false, icon = "event_icon_recover", id = 83}
, 
{choiceDeductList = __rt_10, condition = 1, describe = 111117, icon = "event_icon_func", id = 84}
, 
{choiceDeductList = __rt_10, condition = 1, describe = 111117, icon = "event_icon_func", id = 85}
, 
{condition = 1, describe = 503845, icon = "event_icon_func", id = 86}
, 
{condition = 1, describe = 503845, icon = "event_icon_func", id = 87}
, 
{choiceDeductList = __rt_10, condition = 1, describe = 415519, icon = "event_icon_recover", id = 88}
, 
{describe = 518523, icon = "event_icon_cache", id = 89}
, 
{describe = 15717, icon = "event_icon_cache", id = 90}
, 
{describe = 269322, icon = "event_icon_func", id = 91}
, 
{describe = 38038, event_exit = false, icon = "event_icon_back", id = 92}
}
local __default_values = {auto_choice_arg = __rt_1, auto_choice_type = 0, choiceDeductList = __rt_1, choice_color = false, condition = 0, describe = 417562, event_exit = true, icon = "", id = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(event_choice) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(event_choice, {__index = __rawdata})
return event_choice

