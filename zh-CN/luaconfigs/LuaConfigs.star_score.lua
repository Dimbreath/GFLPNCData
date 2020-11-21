-- params : ...
-- function num : 0 , upvalues : _ENV
local star_score = {
    {score = 5}, {rank_id = 2}, {rank_id = 3, score = 20},
    {rank_id = 4, score = 30}, {rank_id = 5, score = 45},
    {rank_id = 6, score = 67}, {rank_id = 7, score = 100},
    {rank_id = 8, score = 150}, {rank_id = 9, score = 220},
    {rank_id = 10, score = 290}, {rank_id = 11, score = 360},
    {rank_id = 12, score = 430}, {rank_id = 13, score = 500},
    {rank_id = 14, score = 570}, {rank_id = 15, score = 640}
}
local __default_values = {rank_id = 1, score = 10}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(star_score) do setmetatable(v, base) end
local __rawdata = {__basemetatable = base}
setmetatable(star_score, {__index = __rawdata})
return star_score

