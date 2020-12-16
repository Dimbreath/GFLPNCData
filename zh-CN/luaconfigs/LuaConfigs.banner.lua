-- params : ...
-- function num : 0 , upvalues : _ENV
local banner = {
{jump = "https://wj.qq.com/s2/7619728/8185"}
, 
{id = 2, pic = "survey"}
, 
{id = 3, jump = "https://wj.qq.com/s2/7619728/8185"}
, 
{id = 4, pic = "survey"}
}
local __default_values = {channel = 0, id = 1, jump = "https://wj.qq.com/s2/7609377/6c5b", pic = "bug_feedback", type = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(banner) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(banner, {__index = __rawdata})
return banner

