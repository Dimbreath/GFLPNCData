-- params : ...
-- function num : 0 , upvalues : _ENV
local ath_area = {
{name2 = 63594, name3 = "SURVIVABILITY"}
, 
{id = 2, name1 = "B"}
, 
{id = 3, name1 = "C", name2 = 483221, name3 = "SPECIFICITY"}
, 
{id = 4, name1 = "ALL", name2 = 76110, name3 = "ALL AREA"}
}
local __default_values = {id = 1, name1 = "A", name2 = 43453, name3 = "AGGRESSIVITY"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(ath_area) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(ath_area, {__index = __rawdata})
return ath_area

-- params : ...
-- function num : 0 , upvalues : _ENV
local ath_area = {
    {name2 = 63594, name3 = "SURVIVABILITY"}, {id = 2, name1 = "B"},
    {id = 3, name1 = "C", name2 = 483221, name3 = "SPECIFICITY"},
    {id = 4, name1 = "ALL", name2 = 76110, name3 = "ALL AREA"}
}
local __default_values = {
    id = 1,
    name1 = "A",
    name2 = 43453,
    name3 = "AGGRESSIVITY"
}
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

