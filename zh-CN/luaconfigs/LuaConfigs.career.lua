-- params : ...
-- function num : 0 , upvalues : _ENV
local career = {
{name = 66324}
, 
{icon = "career_2", id = 2, name = 359819}
, 
{icon = "career_3", id = 3}
, 
{icon = "career_4", id = 4, name = 83178}
, 
{icon = "career_5", id = 5, name = 388173}
}
local __default_values = {icon = "career_1", id = 1, name = 326679}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(career) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(career, {__index = __rawdata})
return career

-- params : ...
-- function num : 0 , upvalues : _ENV
local career = {
    {name = 66324}, {icon = "career_2", id = 2, name = 359819},
    {icon = "career_3", id = 3}, {icon = "career_4", id = 4, name = 83178},
    {icon = "career_5", id = 5, name = 388173}
}
local __default_values = {icon = "career_1", id = 1, name = 326679}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(career) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(career, {__index = __rawdata})
return career

