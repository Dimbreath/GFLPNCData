local __rt_1 = {21}
local __rt_2 = {75}
local __rt_3 = {}
local __rt_4 = {100}
local __rt_5 = {5}
local __rt_6 = {30}
local __rt_7 = {14}
local __rt_8 = {50}
local __rt_9 = {20}
local __rt_10 = {25}
local __rt_11 = {150}
local ath_suit = {
{
{attrIdList = __rt_1, attrValueList = __rt_2}
, 
{describe = 67407, num = 3}
}
, 
{
{attrIdList = __rt_1, attrValueList = __rt_2, id = 2}
, 
{describe = 120529, id = 2, num = 3}
}
, 
{
{
attrIdList = {23}
, attrValueList = __rt_4, describe = 109394, id = 3}
, 
{describe = 349370, id = 3, num = 3}
}
, 
{
{
attrIdList = {17}
, attrValueList = __rt_4, describe = 67775, id = 4}
, 
{describe = 464220, id = 4, num = 3}
}
, 
{
{attrIdList = __rt_5, attrValueList = __rt_6, describe = 323549, id = 5}
, 
{describe = 460273, id = 5, num = 3}
}
, 
{
{attrIdList = __rt_7, attrValueList = __rt_8, describe = 255001, id = 6}
, 
{describe = 66378, id = 6, num = 3}
}
, 
{
{attrIdList = __rt_9, attrValueList = __rt_8, describe = 77652, id = 7}
, 
{describe = 180787, id = 7, num = 3}
}
, 
{
{
attrIdList = {24}
, attrValueList = __rt_8, describe = 435522, id = 8}
, 
{describe = 63936, id = 8, num = 3}
}
, 
{
{attrIdList = __rt_10, attrValueList = __rt_9, describe = 328626, id = 9}
, 
{describe = 480566, id = 9, num = 3}
}
, 
{
{
attrIdList = {19}
, attrValueList = __rt_8, describe = 352332, id = 10}
, 
{describe = 486571, id = 10, num = 3}
}
, 
{
{
attrIdList = {202}
, attrValueList = __rt_11, describe = 117971, id = 11}
}
, 
{
{
attrIdList = {203}
, attrValueList = __rt_11, describe = 29024, id = 12}
}
, 
{
{
attrIdList = {9}
, attrValueList = __rt_4, describe = 227414, id = 13}
}
, 
{
{attrIdList = __rt_10, attrValueList = __rt_9, describe = 328626, id = 14}
}
, 
{
{
attrIdList = {226}
, attrValueList = __rt_11, describe = 312386, id = 15}
}
, 
{
{
attrIdList = {10}
, 
attrValueList = {200}
, describe = 242447, id = 16}
}
, 
{
{
attrIdList = {204}
, attrValueList = __rt_11, describe = 225681, id = 17}
}
, 
{
{attrIdList = __rt_7, attrValueList = __rt_8, describe = 255001, id = 18}
}
, 
{
{attrIdList = __rt_5, attrValueList = __rt_6, describe = 323549, id = 19}
}
, 
{
{
attrIdList = {7}
, 
attrValueList = {80}
, describe = 445485, id = 20}
}
}
local __default_values = {attrIdList = __rt_3, attrValueList = __rt_3, describe = 167754, id = 1, num = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(ath_suit) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base, 
suitParamDic = {
{icon = "suit_01", name = 139582}
, 
{icon = "suit_02", name = 340881}
, 
{icon = "suit_03", name = 423152}
, 
{icon = "suit_04", name = 301926}
, 
{icon = "suit_05", name = 49418}
, 
{icon = "suit_06", name = 340194}
, 
{icon = "suit_07", name = 504968}
, 
{icon = "suit_08", name = 431605}
, 
{icon = "suit_09", name = 489782}
, 
{icon = "suit_10", name = 104671}
, 
{icon = "suit_11", name = 147724}
, 
{icon = "suit_12", name = 77978}
, 
{icon = "suit_13", name = 21460}
, 
{icon = "suit_14", name = 360467}
, 
{icon = "suit_15", name = 441570}
, 
{icon = "suit_16", name = 317420}
, 
{icon = "suit_17", name = 171668}
, 
{icon = "suit_18", name = 23412}
, 
{icon = "suit_19", name = 173758}
, 
{icon = "suit_20", name = 520631}
}
}
setmetatable(ath_suit, {__index = __rawdata})
return ath_suit

