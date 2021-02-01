-- params : ...
-- function num : 0 , upvalues : _ENV
local system_jump = {
{jump_arg = 101, sys_open_id = 610}
, 
{id = 2, jump_arg = 203, sys_open_id = 610}
, 
{id = 3, jump_arg = 204, sys_open_id = 610}
, 
{id = 4, sys_open_id = 600}
, 
{id = 5, sys_open_id = 600}
, 
{id = 6, sys_open_id = 1300}
, 
{id = 7, sys_open_id = 500}
, 
{id = 8, sys_open_id = 400}
, 
{id = 9, sys_open_id = 300}
, 
{id = 10, sys_open_id = 900}
, 
{id = 11, jump_arg = 4, sys_open_id = 1501}
, 
{id = 12, jump_arg = 5, sys_open_id = 1501}
, 
{id = 13, jump_arg = 1, sys_open_id = 1500}
, 
{id = 14, jump_arg = 2, sys_open_id = 1500}
, 
{id = 15, jump_arg = 601}
, 
{id = 16, jump_arg = 602}
, 
{id = 17, jump_arg = 603}
, 
{id = 18, jump_arg = 604}
, 
{id = 19, jump_arg = 605}
, 
{id = 20, sys_open_id = 610}
; 
[100] = {id = 100, jump_arg = 1001, sys_open_id = 0}
, 
[101] = {id = 101, jump_arg = 1, sys_open_id = 0}
, 
[102] = {content = "%s", id = 102, jump_arg = 1001, sys_open_id = 1400, title = 18753}
, 
[103] = {content = "%s", id = 103, jump_arg = 1701, sys_open_id = 1700, title = 131260}
, 
[104] = {content = "%s", id = 104, jump_arg = 1703, sys_open_id = 1703, title = 105999}
}
local __default_values = {content = "", id = 1, jump_arg = 0, sys_open_id = 101, title = ""}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(system_jump) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(system_jump, {__index = __rawdata})
return system_jump

