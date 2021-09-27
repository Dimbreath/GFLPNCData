local shop_recommend = {
{imgIcon = "UI_ShopRecommendNovicePack1", 
jump_arg = {901, 1}
, type = 1}
; 
[3] = {id = 3, imgIcon = "UI_ShopRecommendNovicePack2", 
jump_arg = {901, 2}
, type = 2}
, 
[4] = {id = 4, imgIcon = "UI_ShopRecommendPack", 
jump_arg = {901}
, type = 3}
, 
[5] = {id = 5, imgIcon = "UI_ShopRecommendMonthly", 
jump_arg = {901, 0, 501}
}
, 
[6] = {id = 6, jump_target = 109}
}
local __default_values = {id = 1, imgIcon = "UI_ShopRecommendGrowth", 
jump_arg = {1002}
, jump_target = 105, type = 99}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(shop_recommend) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(shop_recommend, {__index = __rawdata})
return shop_recommend

