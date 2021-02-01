-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {25}
local __rt_2 = {1007}
local __rt_3 = {}
local __rt_4 = {3}
local __rt_5 = {20}
local __rt_6 = {1201}
local __rt_7 = {22}
local __rt_8 = {16}
local __rt_9 = {1}
local init_logic = {
{logic = __rt_1, 
para2 = {340}
}
, 
{id = 2, logic = __rt_4, 
para2 = {100}
}
; 
[4] = {id = 4, logic = __rt_4, 
para1 = {3005}
, para2 = __rt_5}
, 
[5] = {id = 5, logic = __rt_1, para1 = __rt_6, 
para2 = {232}
}
, 
[6] = {id = 6, logic = __rt_4, para1 = __rt_6, 
para2 = {500}
}
, 
[7] = {id = 7, logic = __rt_7, para1 = __rt_8, 
para2 = {1000}
}
, 
[8] = {id = 8, logic = __rt_7, 
para1 = {8}
, para2 = __rt_5}
, 
[9] = {id = 9, 
logic = {21}
, 
para1 = {6}
, para2 = __rt_3}
, 
[10] = {id = 10, para1 = __rt_9}
, 
[11] = {id = 11, 
para1 = {2}
}
, 
[12] = {id = 12, para1 = __rt_4}
, 
[13] = {id = 13, 
para1 = {4}
}
}
local __default_values = {id = 1, logic = __rt_8, para1 = __rt_2, para2 = __rt_9, para3 = __rt_3}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(init_logic) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(init_logic, {__index = __rawdata})
return init_logic

