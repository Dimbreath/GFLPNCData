-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1}
local __rt_2 = {}
local __rt_3 = {3}
local __rt_4 = {1101}
local __rt_5 = {1102}
local __rt_6 = {1103}
local __rt_7 = {1106}
local __rt_8 = {1110}
local __rt_9 = {2108}
local __rt_10 = {1107}
local __rt_11 = {1104}
local __rt_12 = {2104}
local __rt_13 = {4101}
local __rt_14 = {1111}
local system_open = {
[100] = {pre_condition = __rt_1}
, 
[101] = {id = 101, pre_condition = __rt_1}
, 
[102] = {id = 102, pre_para1 = __rt_4}
, 
[200] = {id = 200, pre_condition = __rt_1}
, 
[201] = {id = 201, pre_para1 = __rt_5}
, 
[202] = {id = 202, pre_condition = __rt_1}
, 
[203] = {id = 203, pre_condition = __rt_1}
, 
[204] = {id = 204, pre_condition = __rt_1}
, 
[205] = {id = 205, pre_para1 = __rt_6}
, 
[300] = {id = 300, pre_condition = __rt_1}
, 
[301] = {id = 301, 
pre_condition = {4}
, 
pre_para1 = {1002}
, pre_para2 = __rt_1}
, 
[400] = {id = 400, pre_condition = __rt_1}
, 
[401] = {id = 401, pre_condition = __rt_1, screening = true}
, 
[402] = {id = 402, pre_condition = __rt_1}
, 
[403] = {id = 403, pre_para1 = __rt_7}
, 
[404] = {id = 404, 
pre_para1 = {2103}
}
, 
[405] = {id = 405, pre_condition = __rt_1, screening = true}
, 
[406] = {id = 406, pre_condition = __rt_1}
, 
[407] = {id = 407, pre_para1 = __rt_8}
, 
[408] = {id = 408, pre_para1 = __rt_4}
, 
[409] = {id = 409, pre_para1 = __rt_6}
, 
[410] = {id = 410, pre_para1 = __rt_8}
, 
[411] = {id = 411, pre_para1 = __rt_5}
, 
[412] = {id = 412, 
pre_para1 = {1108}
}
, 
[500] = {id = 500, pre_condition = __rt_1}
, 
[501] = {id = 501, pre_condition = __rt_1}
, 
[502] = {id = 502, pre_para1 = __rt_6}
, 
[503] = {id = 503, pre_para1 = __rt_9}
, 
[504] = {id = 504, pre_para1 = __rt_10}
, 
[600] = {id = 600, pre_para1 = __rt_4}
, 
[610] = {id = 610, pre_para1 = __rt_11}
, 
[700] = {id = 700, pre_condition = __rt_1, screening = true}
, 
[800] = {id = 800, pre_condition = __rt_1}
, 
[900] = {id = 900, 
pre_para1 = {3101}
}
, 
[901] = {id = 901, pre_condition = __rt_2, pre_para1 = __rt_2, screening = true}
, 
[1000] = {id = 1000, pre_condition = __rt_1, screening = true}
, 
[1001] = {id = 1001, pre_condition = __rt_1, screening = true}
, 
[1100] = {id = 1100, pre_condition = __rt_1, 
pre_para1 = {99}
, screening = true}
, 
[1200] = {id = 1200, pre_para1 = __rt_12}
, 
[1201] = {id = 1201, pre_para1 = __rt_13}
, 
[1202] = {id = 1202, pre_condition = __rt_1, screening = true}
, 
[1203] = {id = 1203, pre_para1 = __rt_13}
, 
[1204] = {id = 1204, pre_para1 = __rt_13}
, 
[1300] = {id = 1300, pre_para1 = __rt_5}
, 
[1400] = {id = 1400, pre_para1 = __rt_14}
, 
[1401] = {id = 1401, pre_para1 = __rt_14}
, 
[1500] = {id = 1500, pre_condition = __rt_1}
, 
[1501] = {id = 1501, pre_para1 = __rt_7}
, 
[1502] = {id = 1502, pre_para1 = __rt_11}
, 
[1600] = {id = 1600, pre_condition = __rt_1}
, 
[1700] = {id = 1700, pre_para1 = __rt_10}
, 
[1701] = {id = 1701, pre_para1 = __rt_10}
, 
[1702] = {id = 1702, pre_para1 = __rt_10}
, 
[1703] = {id = 1703, pre_para1 = __rt_12}
, 
[1704] = {id = 1704, 
pre_para1 = {3110}
}
, 
[1705] = {id = 1705, pre_para1 = __rt_10}
, 
[1706] = {id = 1706, pre_para1 = __rt_10}
, 
[1707] = {id = 1707, pre_para1 = __rt_10}
, 
[1708] = {id = 1708, pre_para1 = __rt_10}
, 
[1709] = {id = 1709, pre_para1 = __rt_10}
, 
[1710] = {id = 1710, pre_para1 = __rt_9}
, 
[1711] = {id = 1711, pre_para1 = __rt_9}
, 
[1712] = {id = 1712, pre_para1 = __rt_9}
, 
[1713] = {id = 1713, pre_para1 = __rt_9}
, 
[1714] = {id = 1714, pre_para1 = __rt_9}
, 
[1800] = {id = 1800, pre_para1 = __rt_8}
, 
[1801] = {id = 1801, pre_para1 = __rt_12, screening = true}
, 
[1900] = {id = 1900, 
pre_para1 = {1109}
}
, 
[2000] = {id = 2000, pre_condition = __rt_1}
, 
[2100] = {id = 2100, pre_para1 = __rt_12}
, 
[2200] = {id = 2200, 
pre_para1 = {2106}
}
, 
[2300] = {id = 2300, pre_para1 = __rt_11, 
trigger = {1, 1, 1, 1, 1, 1}
, 
trigger_para1 = {100100, 100101, 100102, 100103, 100104, 100105}
}
, 
[40201] = {id = 40201, pre_para1 = __rt_7}
, 
[40401] = {id = 40401, pre_para1 = __rt_9}
}
local __default_values = {id = 100, pre_condition = __rt_3, pre_para1 = __rt_1, pre_para2 = __rt_2, screening = false, trigger = __rt_2, trigger_para1 = __rt_2, trigger_para2 = __rt_2, type = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(system_open) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(system_open, {__index = __rawdata})
return system_open

