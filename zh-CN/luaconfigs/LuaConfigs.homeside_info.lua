-- params : ...
-- function num : 0 , upvalues : _ENV
local homeside_info = {
{icon = "notice_Mail"}
, 
{describe = 127849, icon = "notice_Achievement", id = 2}
, 
{describe = 242569, id = 3}
, 
{describe = 231343, icon = "notice_SectorBuilding", id = 4}
, 
{describe = 241433, icon = "notice_CollectRes", id = 5}
, 
{describe = 80406, id = 6}
, 
{describe = 384104, icon = "notice_SectorBuilding", id = 7}
, 
{describe = 315207, icon = "notice_FrgDungeonRefresh", id = 8}
, 
{describe = 329752, icon = "notice_ResDungeonRefresh", id = 9}
}
local __default_values = {describe = 102717, icon = "notice_OasisBuilding", id = 1}
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

