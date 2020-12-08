-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {200}
local __rt_2 = {}
local __rt_3 = {14}
local __rt_4 = {100}
local __rt_5 = {25}
local ath_suit = {
{
{
attrIdList = {21}
, attrValueList = __rt_1, describe = 38056}
, 
{describe = 168935, num = 3}
}
, 
{
{
attrIdList = {22}
, attrValueList = __rt_1, describe = 493857, id = 2}
, 
{describe = 268486, id = 2, num = 3}
}
, 
{
{
attrIdList = {23}
, 
attrValueList = {80}
, describe = 396198, id = 3}
, 
{describe = 292361, id = 3, num = 3}
}
, 
{
{attrIdList = __rt_3, attrValueList = __rt_4, describe = 4119, id = 4}
, 
{describe = 65583, id = 4, num = 3}
}
, 
{
{
attrIdList = {17}
, 
attrValueList = {250}
, describe = 120647, id = 5}
, 
{describe = 189535, id = 5, num = 3}
}
, 
{
{
attrIdList = {5}
, 
attrValueList = {90}
, describe = 478375, id = 6}
, 
{describe = 461618, id = 6, num = 3}
}
, 
{
{
attrIdList = {20}
, attrValueList = __rt_4, describe = 414342, id = 7}
, 
{describe = 253591, id = 7, num = 3}
}
, 
{
{
attrIdList = {24}
, attrValueList = __rt_4, describe = 272880, id = 8}
, 
{describe = 291064, id = 8, num = 3}
}
, 
{
{attrIdList = __rt_5, 
attrValueList = {50}
, describe = 143895, id = 9}
, 
{describe = 336149, id = 9, num = 3}
}
, 
{
{
attrIdList = {19}
, attrValueList = __rt_4, describe = 186350, id = 10}
, 
{describe = 134781, id = 10, num = 3}
}
, 
{
{
attrIdList = {202}
, attrValueList = __rt_1, describe = 262325, id = 11}
}
, 
{
{
attrIdList = {203}
, attrValueList = __rt_1, describe = 173378, id = 12}
}
, 
{
{
attrIdList = {9}
, attrValueList = __rt_4, describe = 227414, id = 13}
}
, 
{
{attrIdList = __rt_5, 
attrValueList = {30}
, describe = 267049, id = 14}
}
, 
{
{
attrIdList = {226}
, attrValueList = __rt_1, describe = 46110, id = 15}
}
, 
{
{
attrIdList = {10}
, 
attrValueList = {300}
, describe = 78916, id = 16}
}
, 
{
{
attrIdList = {204}
, attrValueList = __rt_1, describe = 370035, id = 17}
}
, 
{
{attrIdList = __rt_3, 
attrValueList = {60}
, describe = 299995, id = 18}
}
, 
{
{
attrIdList = {212}
, attrValueList = __rt_1, id = 19}
}
, 
{
{
attrIdList = {7}
, attrValueList = __rt_4, describe = 522658, id = 20}
}
}
local __default_values = {attrIdList = __rt_2, attrValueList = __rt_2, describe = 108444, id = 1, num = 2}
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

