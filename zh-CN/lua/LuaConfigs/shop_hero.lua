local __rt_1 = {5, 10, 15, 20, 25}
local __rt_2 = {1, 1, 1, 1, 1}
local __rt_3 = {9}
local __rt_4 = {1}
local __rt_5 = {25, 50, 75, 100, -1}
local shop_hero = {
[403] = {
{page = 405}
, 
{goods_shelves = 2, hero = 1002, itemId = 2502, 
pre_para1 = {1002}
}
, 
{goods_shelves = 3, hero = 1003, itemId = 2503, page = 403, 
pre_para1 = {1003}
}
, 
{goods_shelves = 4, hero = 1004, itemId = 2504, page = 402, 
pre_para1 = {1004}
}
, 
{goods_shelves = 5, hero = 1005, itemId = 2505, page = 401, 
pre_para1 = {1005}
}
, 
{goods_shelves = 6, hero = 1006, itemId = 2506, page = 402, 
pre_para1 = {1006}
}
, 
{goods_shelves = 7, hero = 1007, itemId = 2507, page = 403, 
pre_para1 = {1007}
}
, 
{goods_shelves = 8, hero = 1008, itemId = 2508, page = 405, 
pre_para1 = {1008}
}
, 
{goods_shelves = 9, hero = 1009, itemId = 2509, 
pre_para1 = {1009}
}
, 
{goods_shelves = 10, hero = 1010, itemId = 2510, page = 401, 
pre_para1 = {1010}
}
, 
{goods_shelves = 11, hero = 1011, itemId = 2511, page = 401, 
pre_para1 = {1011}
}
, 
{goods_shelves = 12, hero = 1012, itemId = 2512, page = 402, 
pre_para1 = {1012}
}
, 
{goods_shelves = 13, hero = 1013, itemId = 2513, page = 403, 
pre_para1 = {1013}
}
, 
{goods_shelves = 14, hero = 1014, itemId = 2514, page = 405, 
pre_para1 = {1014}
}
, 
{goods_shelves = 15, hero = 1015, itemId = 2515, page = 405, 
pre_para1 = {1015}
}
, 
{goods_shelves = 16, hero = 1016, itemId = 2516, 
pre_para1 = {1016}
}
, 
{goods_shelves = 17, hero = 1017, itemId = 2517, 
pre_para1 = {1017}
}
, 
{goods_shelves = 18, hero = 1018, itemId = 2518, page = 405, 
pre_para1 = {1018}
}
, 
{goods_shelves = 19, hero = 1019, itemId = 2519, page = 403, 
pre_para1 = {1019}
}
, 
{goods_shelves = 20, hero = 1020, itemId = 2520, page = 401, 
pre_para1 = {1020}
}
, 
{goods_shelves = 21, hero = 1021, itemId = 2521, 
pre_para1 = {1021}
}
, 
{goods_shelves = 22, hero = 1022, itemId = 2522, page = 403, 
pre_para1 = {1022}
}
, 
{goods_shelves = 23, hero = 1023, itemId = 2523, page = 401, 
pre_para1 = {1023}
}
, 
{goods_shelves = 24, hero = 1024, itemId = 2524, page = 402, 
pre_para1 = {1024}
}
, 
{goods_shelves = 25, hero = 1025, itemId = 2525, page = 402, 
pre_para1 = {1025}
}
, 
{goods_shelves = 26, hero = 1026, itemId = 2526, page = 405, 
pre_para1 = {1026}
}
, 
{goods_shelves = 27, hero = 1027, itemId = 2527, page = 401, 
pre_para1 = {1027}
}
, 
{goods_shelves = 28, hero = 1028, itemId = 2528, page = 403, 
pre_para1 = {1028}
}
, 
{goods_shelves = 29, hero = 1029, itemId = 2529, 
pre_para1 = {1029}
}
, 
{goods_shelves = 30, hero = 1030, itemId = 2530, 
pre_para1 = {1030}
}
, 
{goods_shelves = 31, hero = 1031, itemId = 2531, page = 405, 
pre_para1 = {1031}
}
, 
{goods_shelves = 32, hero = 1032, itemId = 2532, page = 402, 
pre_para1 = {1032}
}
, 
{goods_shelves = 33, hero = 1033, itemId = 2533, 
pre_para1 = {1033}
}
, 
{goods_shelves = 34, hero = 1034, itemId = 2534, 
pre_para1 = {1034}
}
, 
{goods_shelves = 35, hero = 1035, itemId = 2535, page = 405, 
pre_para1 = {1035}
}
, 
{goods_shelves = 36, hero = 1036, itemId = 2536, page = 402, 
pre_para1 = {1036}
}
, 
{goods_shelves = 37, hero = 1037, itemId = 2537, page = 402, 
pre_para1 = {1037}
}
, 
{goods_shelves = 38, hero = 1038, itemId = 2538, 
pre_para1 = {1038}
}
, 
{goods_shelves = 39, hero = 1039, itemId = 2539, page = 403, 
pre_para1 = {1039}
}
, 
{goods_shelves = 40, hero = 1040, itemId = 2540, 
pre_para1 = {1040}
}
}
}
local __default_values = {currencyId = 1006, currencyNums = __rt_1, goods_shelves = 1, hero = 1001, itemId = 2501, itemNums = __rt_2, page = 404, pre_condition = __rt_3, 
pre_para1 = {1001}
, pre_para2 = __rt_4, shop_id = 403, times = __rt_5}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(shop_hero) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base, 
fragId2ShopInfo = {
[2501] = {
resourceIds = {1006}
, shelfId = 1, shopId = 403}
, 
[2502] = {
resourceIds = {1006}
, shelfId = 2, shopId = 403}
, 
[2503] = {
resourceIds = {1006}
, shelfId = 3, shopId = 403}
, 
[2504] = {
resourceIds = {1006}
, shelfId = 4, shopId = 403}
, 
[2505] = {
resourceIds = {1006}
, shelfId = 5, shopId = 403}
, 
[2506] = {
resourceIds = {1006}
, shelfId = 6, shopId = 403}
, 
[2507] = {
resourceIds = {1006}
, shelfId = 7, shopId = 403}
, 
[2508] = {
resourceIds = {1006}
, shelfId = 8, shopId = 403}
, 
[2509] = {
resourceIds = {1006}
, shelfId = 9, shopId = 403}
, 
[2510] = {
resourceIds = {1006}
, shelfId = 10, shopId = 403}
, 
[2511] = {
resourceIds = {1006}
, shelfId = 11, shopId = 403}
, 
[2512] = {
resourceIds = {1006}
, shelfId = 12, shopId = 403}
, 
[2513] = {
resourceIds = {1006}
, shelfId = 13, shopId = 403}
, 
[2514] = {
resourceIds = {1006}
, shelfId = 14, shopId = 403}
, 
[2515] = {
resourceIds = {1006}
, shelfId = 15, shopId = 403}
, 
[2516] = {
resourceIds = {1006}
, shelfId = 16, shopId = 403}
, 
[2517] = {
resourceIds = {1006}
, shelfId = 17, shopId = 403}
, 
[2518] = {
resourceIds = {1006}
, shelfId = 18, shopId = 403}
, 
[2519] = {
resourceIds = {1006}
, shelfId = 19, shopId = 403}
, 
[2520] = {
resourceIds = {1006}
, shelfId = 20, shopId = 403}
, 
[2521] = {
resourceIds = {1006}
, shelfId = 21, shopId = 403}
, 
[2522] = {
resourceIds = {1006}
, shelfId = 22, shopId = 403}
, 
[2523] = {
resourceIds = {1006}
, shelfId = 23, shopId = 403}
, 
[2524] = {
resourceIds = {1006}
, shelfId = 24, shopId = 403}
, 
[2525] = {
resourceIds = {1006}
, shelfId = 25, shopId = 403}
, 
[2526] = {
resourceIds = {1006}
, shelfId = 26, shopId = 403}
, 
[2527] = {
resourceIds = {1006}
, shelfId = 27, shopId = 403}
, 
[2528] = {
resourceIds = {1006}
, shelfId = 28, shopId = 403}
, 
[2529] = {
resourceIds = {1006}
, shelfId = 29, shopId = 403}
, 
[2530] = {
resourceIds = {1006}
, shelfId = 30, shopId = 403}
, 
[2531] = {
resourceIds = {1006}
, shelfId = 31, shopId = 403}
, 
[2532] = {
resourceIds = {1006}
, shelfId = 32, shopId = 403}
, 
[2533] = {
resourceIds = {1006}
, shelfId = 33, shopId = 403}
, 
[2534] = {
resourceIds = {1006}
, shelfId = 34, shopId = 403}
, 
[2535] = {
resourceIds = {1006}
, shelfId = 35, shopId = 403}
, 
[2536] = {
resourceIds = {1006}
, shelfId = 36, shopId = 403}
, 
[2537] = {
resourceIds = {1006}
, shelfId = 37, shopId = 403}
, 
[2538] = {
resourceIds = {1006}
, shelfId = 38, shopId = 403}
, 
[2539] = {
resourceIds = {1006}
, shelfId = 39, shopId = 403}
, 
[2540] = {
resourceIds = {1006}
, shelfId = 40, shopId = 403}
}
}
setmetatable(shop_hero, {__index = __rawdata})
return shop_hero

