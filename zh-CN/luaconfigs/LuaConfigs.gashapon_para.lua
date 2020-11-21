-- params : ...
-- function num : 0 , upvalues : _ENV
local gashapon_para = {
    {}, {costId1 = 3005, costId2 = 3005, costNum1 = 288, costNum2 = 2880}
}
local __default_values = {
    cd = 0,
    costId1 = 3001,
    costId2 = 3001,
    costNum1 = 1,
    costNum2 = 10
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(gashapon_para) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(gashapon_para, {__index = __rawdata})
return gashapon_para

