-- params : ...
-- function num : 0 , upvalues : _ENV
local dungeon_material_count = {
[1501] = {colorCount = 10}
, 
[1502] = {colorCount = 10, id = 1502}
, 
[1503] = {colorCount = 10, id = 1503}
, 
[1504] = {colorCount = 10, id = 1504}
, 
[1505] = {colorCount = 10, id = 1505}
, 
[1506] = {id = 1506}
, 
[1507] = {id = 1507}
, 
[1508] = {id = 1508}
, 
[1509] = {id = 1509}
, 
[1510] = {id = 1510}
, 
[1511] = {colorCount = 30, id = 1511}
, 
[1512] = {colorCount = 30, id = 1512}
, 
[1513] = {colorCount = 30, id = 1513}
, 
[1514] = {colorCount = 30, id = 1514}
, 
[1515] = {colorCount = 30, id = 1515}
, 
[1516] = {colorCount = 40, id = 1516}
, 
[1517] = {colorCount = 40, id = 1517}
, 
[1518] = {colorCount = 40, id = 1518}
, 
[1519] = {colorCount = 40, id = 1519}
, 
[1520] = {colorCount = 40, id = 1520}
, 
[1801] = {id = 1801}
, 
[1802] = {id = 1802}
, 
[1803] = {id = 1803}
, 
[1804] = {id = 1804}
, 
[1805] = {id = 1805}
, 
[1806] = {colorCount = 30, id = 1806}
, 
[1807] = {colorCount = 30, id = 1807}
, 
[1808] = {colorCount = 30, id = 1808}
, 
[1809] = {colorCount = 30, id = 1809}
, 
[1810] = {colorCount = 30, id = 1810}
, 
[1811] = {colorCount = 40, id = 1811}
, 
[1812] = {colorCount = 40, id = 1812}
, 
[1813] = {colorCount = 40, id = 1813}
, 
[1814] = {colorCount = 40, id = 1814}
, 
[1815] = {colorCount = 40, id = 1815}
, 
[1816] = {colorCount = 50, id = 1816}
, 
[1817] = {colorCount = 50, id = 1817}
, 
[1818] = {colorCount = 50, id = 1818}
, 
[1819] = {colorCount = 50, id = 1819}
, 
[1820] = {colorCount = 50, id = 1820}
, 
[1821] = {colorCount = 60, id = 1821}
, 
[1822] = {colorCount = 60, id = 1822}
, 
[1823] = {colorCount = 60, id = 1823}
, 
[1824] = {colorCount = 60, id = 1824}
, 
[1825] = {colorCount = 60, id = 1825}
}
local __default_values = {colorCount = 20, id = 1501}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dungeon_material_count) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dungeon_material_count, {__index = __rawdata})
return dungeon_material_count

