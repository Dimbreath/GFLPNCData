-- params : ...
-- function num : 0 , upvalues : _ENV
local ath_area = {
    {name2 = 63594}, {id = 2, name1 = "B"},
    {id = 3, name1 = "C", name2 = 483221}
}
local __default_values = {id = 1, name1 = "A", name2 = 43453}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(ath_area) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(ath_area, {__index = __rawdata})
return ath_area

