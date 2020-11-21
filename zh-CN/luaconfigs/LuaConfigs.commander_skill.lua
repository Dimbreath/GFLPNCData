-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local commander_skill = {{}}
local __default_values = {
    color = 1,
    commander_id = 1,
    describe = 422645,
    icon = "CommanderSkillSeries_1",
    name = 455399,
    pre_condition = __rt_1,
    pre_para1 = __rt_1,
    pre_para2 = __rt_1
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(commander_skill) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(commander_skill, {__index = __rawdata})
return commander_skill

