-- params : ...
-- function num : 0 , upvalues : _ENV
local guide = {
{
step_list = {100, 101, 102, 103}
}
, 
{id = 2, 
step_list = {201, 202}
}
, 
{id = 3, 
step_list = {301}
}
, 
{id = 4, 
step_list = {401, 402, 403}
}
, 
{id = 5, priority = 2, 
step_list = {501}
}
, 
{id = 6, 
step_list = {600, 601, 602, 603, 604, 605}
}
, 
{id = 7, 
step_list = {700, 701, 702, 703, 704, 705}
}
, 
{id = 8, 
step_list = {800, 801}
}
, 
{id = 9, 
step_list = {900, 901}
}
, 
{id = 10, 
step_list = {1000, 1001}
}
, 
{id = 11, 
step_list = {1101, 1102}
}
, 
{id = 12, 
step_list = {1200}
}
, 
{id = 13, priority = 2, 
step_list = {1321, 1351, 1302, 1303, 1305, 1306}
}
, 
{id = 14, priority = 2, 
step_list = {1400}
}
, 
{id = 15, 
step_list = {1500, 1501, 1502, 1503, 1504}
}
, 
{id = 16, 
step_list = {1600, 1601, 1602, 1603, 1604}
}
, 
{id = 17, 
step_list = {1700}
}
, 
{id = 18, 
step_list = {1800, 1802}
}
, 
{id = 19, 
step_list = {1900}
}
, 
{id = 20, priority = 2, 
step_list = {2000, 2002, 2003, 2004, 2005}
}
, 
{id = 21, 
step_list = {2100}
}
, 
{id = 22, priority = 2, 
step_list = {2200, 2201, 2202, 2203}
}
, 
{id = 23, priority = 2, 
step_list = {2301, 2302, 2303, 2304, 2305, 2306}
}
, 
{id = 24, 
step_list = {2401, 2402}
}
, 
{id = 25, 
step_list = {2501, 2502, 2503, 2504, 2505, 2506, 2507, 2508}
}
, 
{id = 26, 
step_list = {2600, 2601, 2602, 2603, 2604, 2605, 2606, 2607, 2608, 2609}
}
, 
{id = 27, 
step_list = {2701, 2702, 2703, 2704, 2705}
}
, 
{id = 28, 
step_list = {2801, 2802, 2803, 2804, 2805}
}
, 
{id = 29, 
step_list = {2901, 2902}
}
; 
[901] = {id = 901, 
step_list = {90101}
}
, 
[1000] = {id = 1000, 
step_list = {100001, 100002}
}
, 
[1001] = {id = 1001, 
step_list = {100101, 100102}
}
, 
[1011] = {id = 1011, 
step_list = {101101}
}
, 
[1012] = {id = 1012, 
step_list = {101201, 101202}
}
, 
[1013] = {id = 1013, 
step_list = {101301, 101302}
}
, 
[1301] = {id = 1301, 
step_list = {1352, 1302, 1303, 1305, 1306}
}
, 
[1401] = {id = 1401, 
step_list = {140101, 140103}
}
, 
[1501] = {id = 1501, priority = 2, 
step_list = {1402, 1497, 150101, 150102}
}
, 
[1502] = {id = 1502, 
step_list = {150103, 150102}
}
, 
[2001] = {id = 2001, 
step_list = {2001, 2003, 2004, 2005}
}
, 
[2301] = {id = 2301, 
step_list = {2300, 2303, 2304, 2305, 2306}
}
, 
[10012] = {id = 10012, 
step_list = {1001201, 1001202}
}
, 
[10013] = {id = 10013, 
step_list = {1201, 1202}
}
, 
[10020] = {id = 10020, 
step_list = {200001, 200002, 200003, 200004}
}
, 
[10022] = {id = 10022, 
step_list = {1002201, 1002202, 2202, 2203}
}
, 
[20000] = {guide_type = 1, id = 20000}
, 
[20001] = {guide_type = 1, id = 20001, 
step_list = {1, 2, 5}
}
, 
[20002] = {guide_type = 1, id = 20002, 
step_list = {1, 2, 7, 4}
}
, 
[20003] = {guide_type = 1, id = 20003, 
step_list = {1, 2, 8}
}
}
local __default_values = {guide_type = 0, id = 1, priority = 1, 
step_list = {1, 2, 3, 4}
}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(guide) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(guide, {__index = __rawdata})
return guide

