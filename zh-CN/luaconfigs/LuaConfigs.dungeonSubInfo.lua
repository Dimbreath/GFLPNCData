-- params : ...
-- function num : 0 , upvalues : _ENV
local dungeonSubInfo = {
{}
, 
{icon = "matDg_skill", name_en = "SKILL TRAINING", stage_type = 2, text = 510297}
}
local __default_values = {icon = "matDg_limit", name_en = "POTENTIAL TRAINING", stage_type = 1, text = 472181}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dungeonSubInfo) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dungeonSubInfo, {__index = __rawdata})
return dungeonSubInfo

