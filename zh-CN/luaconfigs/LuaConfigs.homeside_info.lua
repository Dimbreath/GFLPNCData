-- params : ...
-- function num : 0 , upvalues : _ENV
local homeside_info = {
{icon = "notice_Mail", info_type = 1, switch_name = 239894, switch_type = 1}
, 
{describe = 127849, icon = "notice_Achievement", id = 2, info_type = 1, switch_name = 237651, switch_type = 2}
, 
{describe = 242569, icon = "notice_OasisBuilding", id = 3}
, 
{describe = 231343, icon = "notice_SectorBuilding", id = 4}
, 
{describe = 241433, icon = "notice_CollectRes", id = 5, switch_name = 413151}
, 
{describe = 80406, icon = "notice_OasisBuilding", id = 6, info_type = 1, switch_name = 70675, switch_type = 3}
, 
{describe = 89936, icon = "notice_SectorBuilding", id = 7, info_type = 1, switch_name = 268102, switch_type = 4}
, 
{describe = 315207, icon = "notice_FrgDungeonRefresh", id = 8, info_type = 1, switch_name = 18753, switch_type = 6}
, 
{describe = 329752, icon = "notice_ResDungeonRefresh", id = 9, switch_name = 131260}
, 
{describe = 236068, icon = "notice_FrgDungeonRefresh", id = 10, switch_name = 105999}
, 
{describe = 379957, id = 11, switch_name = 510413}
, 
{describe = 69205, id = 12, switch_name = 439705}
, 
{describe = 520493, id = 13, info_type = 1, switch_name = 439705, switch_type = 7}
, 
{describe = 458926, icon = "notice_ResDungeonRefresh", id = 14, info_type = 1, switch_name = 493231, switch_type = 6}
}
local __default_values = {describe = 102717, icon = "notice_Factory", id = 1, info_type = 0, switch_name = 14065, switch_type = 0}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(homeside_info) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(homeside_info, {__index = __rawdata})
return homeside_info

