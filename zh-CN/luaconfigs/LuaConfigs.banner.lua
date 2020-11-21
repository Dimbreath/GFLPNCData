-- params : ...
-- function num : 0 , upvalues : _ENV
local banner = {{}, {id = 2, pic = "survey"}}
local __default_values = {
    active = true,
    id = 1,
    jump = "https://www.wenjuan.com/s/UZBZJvaKzD/",
    pic = "bug_feedback",
    type = 1
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(banner) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(banner, {__index = __rawdata})
return banner

