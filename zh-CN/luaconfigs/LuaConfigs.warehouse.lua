-- params : ...
-- function num : 0 , upvalues : _ENV
local warehouse = {
{
itemDic = {}
, name = 377238}
, 
{icon = "warehouse_page_2", id = 2, name = 386406}
, 
{icon = "warehouse_page_3", id = 3, 
itemDic = {[5001] = true, [5002] = true, [5007] = true, [8084] = true, [8085] = true, [8086] = true, [8087] = true, [8088] = true}
}
, 
{icon = "warehouse_page_4", id = 4, 
itemDic = {[2501] = true, [2502] = true, [2503] = true, [2504] = true, [2505] = true, [2506] = true, [2507] = true, [2508] = true, [2509] = true, [2510] = true, [2511] = true, [2512] = true, [2513] = true, [2514] = true, [2515] = true, [2516] = true, [2517] = true, [2518] = true, [2519] = true, [2520] = true, [2521] = true, [2522] = true, [2523] = true, [2524] = true, [2525] = true, [2526] = true, [2527] = true, [2528] = true, [2531] = true, [2534] = true, [2535] = true, [2536] = true, [2537] = true, [2538] = true, [2539] = true}
, name = 60812}
, 
{icon = "warehouse_page_5", id = 5, 
itemDic = {[1501] = true, [1502] = true, [1801] = true, [1802] = true, [1803] = true, [1804] = true, [1805] = true, [1806] = true, [1807] = true, [1808] = true, [1809] = true, [1810] = true, [1811] = true, [1812] = true, [1813] = true, [1814] = true, [1815] = true, [1816] = true, [1817] = true, [1818] = true, [1819] = true, [1820] = true, [1821] = true, [1822] = true, [1823] = true, [1824] = true, [1825] = true}
, name = 371287}
}
local __default_values = {icon = "warehouse_page_1", id = 1, 
itemDic = {[1001] = true, [1002] = true, [1003] = true, [1004] = true, [1006] = true, [1008] = true, [1009] = true, [1012] = true, [1015] = true, [1016] = true, [1101] = true, [1102] = true, [1103] = true, [1107] = true, [1108] = true, [1109] = true, [1113] = true, [1114] = true, [1115] = true, [1500] = true, [3001] = true, [3005] = true, [3100] = true, [3101] = true, [3102] = true, [3103] = true, [3104] = true, [3105] = true, [3106] = true, [3107] = true, [3108] = true, [3109] = true, [3110] = true, [3111] = true, [3112] = true, [3113] = true, [3114] = true, [5005] = true, [6001] = true, [6002] = true, [6003] = true}
, name = 185947}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(warehouse) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warehouse, {__index = __rawdata})
return warehouse

