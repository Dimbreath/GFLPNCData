-- params : ...
-- function num : 0 , upvalues : _ENV
local ath_affix_pool = {
{affix_para = 2, pool_id = 1, upper_limit = 700}
, 
{affix_para = 202, id = 2, optimize_id = 2, pool_id = 1, upper_limit = 120}
, 
{affix_para = 3, id = 3, optimize_id = 3, pool_id = 1, upper_limit = 80}
, 
{affix_para = 4, id = 4, optimize_id = 5, pool_id = 1}
, 
{affix_para = 204, id = 5, optimize_id = 6, pool_id = 1, upper_limit = 130}
, 
{id = 6, optimize_id = 7, pool_id = 1}
, 
{affix_para = 7, id = 7, optimize_id = 9, pool_id = 1, upper_limit = 50}
, 
{affix_para = 2, id = 8, pool_id = 2, upper_limit = 700}
, 
{affix_para = 3, id = 9, optimize_id = 3, pool_id = 2, upper_limit = 80}
, 
{affix_para = 203, id = 10, optimize_id = 4, pool_id = 2, upper_limit = 120}
, 
{affix_para = 4, id = 11, optimize_id = 5, pool_id = 2}
, 
{id = 12, optimize_id = 7, pool_id = 2}
, 
{affix_para = 212, id = 13, optimize_id = 8, pool_id = 2, upper_limit = 130}
, 
{affix_para = 9, id = 14, optimize_id = 11, pool_id = 2, upper_limit = 50}
, 
{affix_para = 10, id = 15, optimize_id = 12, pool_id = 2, upper_limit = 170}
, 
{affix_para = 2, id = 16, upper_limit = 700}
, 
{affix_para = 202, id = 17, optimize_id = 2, upper_limit = 120}
, 
{affix_para = 3, id = 18, optimize_id = 3, upper_limit = 80}
, 
{affix_para = 203, id = 19, optimize_id = 4, upper_limit = 120}
, 
{affix_para = 4, id = 20, optimize_id = 5}
, 
{id = 21, optimize_id = 7}
, 
{affix_para = 7, id = 22, optimize_id = 9, upper_limit = 50}
, 
{affix_para = 9, id = 23, optimize_id = 11, upper_limit = 50}
, 
{affix_para = 10, id = 24, optimize_id = 12, upper_limit = 170}
}
local __default_values = {affix_para = 12, affix_type = 1, id = 1, optimize_id = 1, pool_id = 3, upper_limit = 40}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(ath_affix_pool) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(ath_affix_pool, {__index = __rawdata})
return ath_affix_pool

