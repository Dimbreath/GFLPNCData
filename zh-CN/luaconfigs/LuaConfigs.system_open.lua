-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1}
local __rt_2 = {}
local __rt_3 = {3}
local __rt_4 = {1101}
local __rt_5 = {1103}
local __rt_6 = {4}
local __rt_7 = {1004}
local __rt_8 = {1107}
local __rt_9 = {1104}
local __rt_10 = {1106}
local __rt_11 = {1108}
local __rt_12 = {2106}
local __rt_13 = {2101}
local system_open = {
[100] = {}
, 
[101] = {id = 101}
, 
[102] = {id = 102, pre_condition = __rt_3, pre_para1 = __rt_4}
, 
[200] = {id = 200}
, 
[201] = {id = 201}
, 
[202] = {id = 202}
, 
[203] = {id = 203}
, 
[204] = {id = 204}
, 
[205] = {id = 205, pre_condition = __rt_3, pre_para1 = __rt_5}
, 
[300] = {id = 300}
, 
[301] = {id = 301, pre_condition = __rt_6, pre_para1 = __rt_7, pre_para2 = __rt_1}
, 
[400] = {id = 400}
, 
[401] = {id = 401, screening = true}
, 
[402] = {id = 402}
, 
[403] = {id = 403}
, 
[404] = {id = 404}
, 
[405] = {id = 405, screening = true}
, 
[406] = {id = 406}
, 
[407] = {id = 407, pre_condition = __rt_3, 
pre_para1 = {1110}
}
, 
[408] = {id = 408, pre_condition = __rt_3, pre_para1 = __rt_4}
, 
[409] = {id = 409, pre_condition = __rt_3, pre_para1 = __rt_5}
, 
[410] = {id = 410, pre_condition = __rt_3, pre_para1 = __rt_8}
, 
[411] = {id = 411, pre_condition = __rt_3, pre_para1 = __rt_5}
, 
[500] = {id = 500}
, 
[501] = {id = 501}
, 
[502] = {id = 502, pre_condition = __rt_3, pre_para1 = __rt_9}
, 
[503] = {id = 503, pre_condition = __rt_3, pre_para1 = __rt_10}
, 
[600] = {id = 600, pre_condition = __rt_6, pre_para1 = __rt_7, pre_para2 = __rt_1}
, 
[610] = {id = 610, pre_condition = __rt_3, pre_para1 = __rt_10}
, 
[700] = {id = 700, screening = true}
, 
[800] = {id = 800}
, 
[900] = {id = 900, pre_condition = __rt_6, 
pre_para1 = {1012}
, pre_para2 = __rt_1}
, 
[901] = {id = 901, pre_condition = __rt_6, 
pre_para1 = {1008}
, pre_para2 = __rt_1, screening = true}
, 
[1000] = {id = 1000, screening = true}
, 
[1001] = {id = 1001, screening = true}
, 
[1100] = {id = 1100, pre_condition = __rt_6, 
pre_para1 = {1001}
, 
pre_para2 = {11}
, screening = true}
, 
[1200] = {id = 1200, pre_condition = __rt_3, pre_para1 = __rt_11}
, 
[1201] = {id = 1201, pre_condition = __rt_3, pre_para1 = __rt_12}
, 
[1202] = {id = 1202, pre_condition = __rt_3, pre_para1 = __rt_12}
, 
[1203] = {id = 1203, pre_condition = __rt_3, 
pre_para1 = {3101}
}
, 
[1300] = {id = 1300}
, 
[1400] = {id = 1400, pre_condition = __rt_3, pre_para1 = __rt_13}
, 
[1401] = {id = 1401, pre_condition = __rt_3, pre_para1 = __rt_13}
, 
[1500] = {id = 1500}
, 
[1501] = {id = 1501, pre_condition = __rt_3, pre_para1 = __rt_10}
, 
[1502] = {id = 1502, pre_condition = __rt_3, pre_para1 = __rt_9}
, 
[1600] = {id = 1600}
, 
[1700] = {id = 1700, pre_condition = __rt_3, pre_para1 = __rt_8}
, 
[1701] = {id = 1701, pre_condition = __rt_3, pre_para1 = __rt_8}
, 
[1702] = {id = 1702, pre_condition = __rt_3, pre_para1 = __rt_8}
, 
[1703] = {id = 1703, pre_condition = __rt_3, pre_para1 = __rt_11}
, 
[1800] = {id = 1800}
, 
[1900] = {id = 1900, pre_condition = __rt_3, 
pre_para1 = {1109}
}
, 
[2000] = {id = 2000}
, 
[2100] = {id = 2100, pre_condition = __rt_3, pre_para1 = __rt_11}
, 
[40401] = {id = 40401}
}
local __default_values = {id = 100, pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_2, screening = false, type = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(system_open) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
trigger_guide_list = {[25] = 409, [26] = 1200, [27] = 1401, [28] = 1700, [29] = 1900, [32] = 1202, [33] = 1203, [34] = 900}
}
setmetatable(system_open, {__index = __rawdata})
return system_open

