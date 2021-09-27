local month_card = {
{}
}
local __default_values = {
daily_award_ids = {1002}
, 
daily_award_nums = {80}
, duration_days = 30, 
first_award_ids = {1000}
, 
first_award_nums = {300}
, id = 1, max_days = 60, price = 100001}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(month_card) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(month_card, {__index = __rawdata})
return month_card

