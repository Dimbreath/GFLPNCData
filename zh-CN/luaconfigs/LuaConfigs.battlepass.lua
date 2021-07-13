-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1003}
local __rt_2 = {1}
local __rt_3 = {5005}
local __rt_4 = {3}
local __rt_5 = {2}
local __rt_6 = {4}
local __rt_7 = {5}
local __rt_8 = {6}
local __rt_9 = {7}
local __rt_10 = {8}
local __rt_11 = {9}
local __rt_12 = {10}
local __rt_13 = {11}
local __rt_14 = {12}
local __rt_15 = {13}
local __rt_16 = {14}
local __rt_17 = {15}
local __rt_18 = {16}
local __rt_19 = {17}
local __rt_20 = {18}
local __rt_21 = {19}
local __rt_22 = {20}
local __rt_23 = {21}
local __rt_24 = {22}
local __rt_25 = {23}
local __rt_26 = {24}
local __rt_27 = {25}
local __rt_28 = {1002}
local battlepass = {
{
{base_item_nums = __rt_2, level = 1, senior_item_nums = __rt_4}
, 
{level = 2, senior_item_nums = __rt_6}
, 
{base_item_nums = __rt_4, level = 3, senior_item_nums = __rt_7}
, 
{base_item_nums = __rt_6, level = 4, senior_item_nums = __rt_8}
, 
{base_item_nums = __rt_7, level = 5, senior_item_nums = __rt_9, tag = true}
, 
{base_item_nums = __rt_8, level = 6, senior_item_nums = __rt_10}
, 
{base_item_nums = __rt_9, level = 7, senior_item_nums = __rt_11}
, 
{base_item_nums = __rt_10, level = 8, senior_item_nums = __rt_12}
, 
{base_item_nums = __rt_11, level = 9, senior_item_nums = __rt_13}
, 
{base_item_nums = __rt_12, senior_item_nums = __rt_14, tag = true}
, 
{base_item_nums = __rt_13, level = 11, senior_item_nums = __rt_15}
, 
{base_item_nums = __rt_14, level = 12, senior_item_nums = __rt_16}
, 
{base_item_nums = __rt_15, level = 13, senior_item_nums = __rt_17}
, 
{base_item_nums = __rt_16, level = 14, senior_item_nums = __rt_18}
, 
{base_item_nums = __rt_17, level = 15, senior_item_nums = __rt_19, tag = true}
, 
{base_item_nums = __rt_18, level = 16, senior_item_nums = __rt_20}
, 
{base_item_nums = __rt_19, level = 17, senior_item_nums = __rt_21}
, 
{base_item_nums = __rt_20, level = 18, senior_item_nums = __rt_22}
, 
{base_item_nums = __rt_21, level = 19, senior_item_nums = __rt_23}
, 
{base_item_nums = __rt_22, level = 20, senior_item_nums = __rt_24, tag = true}
, 
{base_item_nums = __rt_23, level = 21, senior_item_nums = __rt_25}
, 
{base_item_nums = __rt_24, level = 22, senior_item_nums = __rt_26}
, 
{base_item_nums = __rt_25, level = 23, senior_item_nums = __rt_27}
, 
{base_item_nums = __rt_26, level = 24, 
senior_item_nums = {26}
}
, 
{base_item_nums = __rt_27, level = 25, 
senior_item_nums = {27}
, tag = true}
}
, 
{
[2] = {
base_item_ids = {5002}
, base_item_nums = __rt_7, exp = 0, id = 2, level = 2, senior_item_ids = __rt_28, 
senior_item_nums = {200}
}
, 
[4] = {
base_item_ids = {3005}
, exp = 0, id = 2, level = 4, senior_item_ids = __rt_28, 
senior_item_nums = {400}
}
, 
[6] = {
base_item_ids = {8103}
, base_item_nums = __rt_2, exp = 0, id = 2, level = 6, senior_item_ids = __rt_28, 
senior_item_nums = {600}
}
, 
[8] = {base_item_ids = __rt_3, base_item_nums = __rt_7, exp = 0, id = 2, level = 8, senior_item_ids = __rt_28, 
senior_item_nums = {800}
}
, 
[10] = {
base_item_ids = {5007}
, base_item_nums = __rt_4, exp = 0, id = 2, senior_item_ids = __rt_28}
, 
[12] = {
base_item_ids = {6002}
, exp = 0, id = 2, level = 12, senior_item_ids = __rt_28, 
senior_item_nums = {1200}
}
, 
[15] = {
base_item_ids = {8018}
, exp = 0, id = 2, level = 15, senior_item_ids = __rt_28, 
senior_item_nums = {1400}
}
, 
[18] = {
base_item_ids = {1818}
, base_item_nums = __rt_12, exp = 0, id = 2, level = 18, senior_item_ids = __rt_28, 
senior_item_nums = {1600}
}
, 
[22] = {
base_item_ids = {1502}
, base_item_nums = __rt_4, exp = 0, id = 2, level = 22, senior_item_ids = __rt_28, 
senior_item_nums = {2400}
}
, 
[25] = {
base_item_ids = {8019}
, base_item_nums = __rt_2, exp = 0, id = 2, level = 25, senior_item_ids = __rt_28, 
senior_item_nums = {3200}
}
}
}
local __default_values = {base_item_ids = __rt_1, base_item_nums = __rt_5, exp = 150, id = 1, level = 10, senior_item_ids = __rt_3, 
senior_item_nums = {1000}
, tag = false}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(battlepass) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base, 
max_level = {25, 25}
, 
tag_items = {
{
item_ids = {5005}
, 
item_nums = {85}
}
, 
{
item_ids = {}
, 
item_nums = {}
}
}
, 
tag_levels = {
{5, 10, 15, 20, 25}
, 
{}
}
}
setmetatable(battlepass, {__index = __rawdata})
return battlepass

