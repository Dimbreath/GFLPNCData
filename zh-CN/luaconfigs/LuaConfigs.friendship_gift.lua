-- params : ...
-- function num : 0 , upvalues : _ENV
local friendship_gift = {
    [3100] = {gift_base = 20, gift_like = 30},
    [3101] = {gift_base = 15, gift_dislike = 8, gift_like = 20, id = 3101},
    [3102] = {gift_dislike = 6, id = 3102}
}
local __default_values = {
    gift_base = 10,
    gift_dislike = 10,
    gift_like = 15,
    id = 3100
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(friendship_gift) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(friendship_gift, {__index = __rawdata})
return friendship_gift

