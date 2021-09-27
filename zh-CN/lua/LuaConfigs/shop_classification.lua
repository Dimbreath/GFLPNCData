local shop_classification = {
{icon = "Icon_recharge", name = 123697, 
sub_ids = {801}
}
, 
{icon = "Icon_pack", id = 2, name = 491765, 
sub_ids = {901}
}
, 
{icon = "Icon_furniture", id = 3, name = 313098}
, 
{icon = "Icon_skin", id = 4, name = 421882, 
sub_ids = {701}
}
, 
{id = 5, name = 60812, 
sub_ids = {403}
}
, 
{icon = "Icon_item", id = 6, 
sub_ids = {204, 1002, 1003, 1004}
}
, 
{icon = "Icon_special", id = 7, name = 218266, 
sub_ids = {203}
}
}
local __default_values = {icon = "Icon_fragments", id = 1, name = 117630, name_en = "", 
sub_ids = {101}
}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(shop_classification) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
showShopDic = {[101] = true, [203] = true, [204] = true, [403] = true, [701] = true, [801] = true, [901] = true, [1002] = true, [1003] = true, [1004] = true}
}
setmetatable(shop_classification, {__index = __rawdata})
return shop_classification

