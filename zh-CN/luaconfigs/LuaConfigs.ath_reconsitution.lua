-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1, 3, 4, 5}
local ath_reconsitution = {
{lock_num = 1, 
quality_weight = {0, 69, 30, 1}
}
, 
{lock_num = 2, 
quality_weight = {0, 0, 75, 25}
}
, 
{lock_num = 3}
; 
[0] = {
quality_weight = {70, 28, 2, 0}
}
}
local __default_values = {lock_num = 0, quality = __rt_1, 
quality_weight = {0, 0, 0, 100}
}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(ath_reconsitution) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(ath_reconsitution, {__index = __rawdata})
return ath_reconsitution

