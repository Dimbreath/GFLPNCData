-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1, 3, 4, 5}
local ath_reconsitution = {
{lock_num = 1, 
quality_weight = {30, 30, 32, 8}
}
, 
{lock_num = 2, 
quality_weight = {30, 32, 32, 6}
}
, 
{lock_num = 3, 
quality_weight = {32, 32, 32, 4}
}
, 
{lock_num = 4, 
quality_weight = {33, 33, 33, 2}
}
; 
[0] = {}
}
local __default_values = {lock_num = 0, quality = __rt_1, 
quality_weight = {30, 30, 30, 10}
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

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1, 3, 4, 5}
local ath_reconsitution = {
    {lock_num = 1, quality_weight = {30, 30, 32, 8}},
    {lock_num = 2, quality_weight = {30, 32, 32, 6}},
    {lock_num = 3, quality_weight = {32, 32, 32, 4}},
    {lock_num = 4, quality_weight = {33, 33, 33, 2}},
    [0] = {}
}
local __default_values = {
    lock_num = 0,
    quality = __rt_1,
    quality_weight = {30, 30, 30, 10}
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(ath_reconsitution) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(ath_reconsitution, {__index = __rawdata})
return ath_reconsitution

