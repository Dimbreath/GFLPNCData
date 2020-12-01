-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1006}
local __rt_2 = {5}
local __rt_3 = {1006, 1601}
local __rt_4 = {30, 3}
local __rt_5 = {1006, 1602}
local __rt_6 = {200, 10}
local hero_rank = {
{rare = 1, repeat_extra_trans_id = __rt_1, repeat_extra_trans_num = __rt_2}
, 
{rank = 2, rare = 1, repeat_extra_trans_id = __rt_1, repeat_extra_trans_num = __rt_2, star = 2, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 1000}
, 
{itemId = 1601, num = 10}
}
}
, 
{rank = 3, rare = 1, repeat_extra_trans_id = __rt_3, repeat_extra_trans_num = __rt_4, star = 3, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 2000}
}
, upgrade_star_frag_cost = 30}
, 
{rank = 4, rare = 2, repeat_extra_trans_id = __rt_3, repeat_extra_trans_num = __rt_4, star = 4, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 3000}
, 
{itemId = 1601, num = 30}
}
}
, 
{rank = 5, rare = 2, star = 5, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 4000}
}
, upgrade_star_frag_cost = 80}
, 
{rank = 6, star = 6, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 5000}
, 
{itemId = 1602, num = 10}
}
}
, 
{rank = 7, star = 7, ultimateskill_level = 2, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 7500}
}
, upgrade_star_frag_cost = 120}
, 
{rank = 8, star = 8, ultimateskill_level = 3, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 10000}
, 
{itemId = 1602, num = 50}
}
}
, 
{rank = 9, star = 9, ultimateskill_level = 4, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 20000}
}
, upgrade_star_frag_cost = 150}
, 
{rank = 10, star = 10, ultimateskill_level = 5, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 25000}
, 
{itemId = 1603, num = 30}
}
}
}
local __default_values = {rank = 1, rare = 3, repeat_extra_trans_id = __rt_5, repeat_extra_trans_num = __rt_6, skill_level_max = 5, star = 1, ultimateskill_level = 1, 
upgrade_star_extra_cost = {
{itemId = 1003, num = 0}
}
, upgrade_star_frag_cost = 0}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(hero_rank) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxRank = 10, maxRare = 3, maxSkillLevel = 5, maxStar = 10}
setmetatable(hero_rank, {__index = __rawdata})
return hero_rank

-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1006}
local __rt_2 = {5}
local __rt_3 = {1006, 1601}
local __rt_4 = {30, 3}
local __rt_5 = {1006, 1602}
local __rt_6 = {200, 10}
local hero_rank = {
    {rare = 1, repeat_extra_trans_id = __rt_1, repeat_extra_trans_num = __rt_2},
    {
        rank = 2,
        rare = 1,
        repeat_extra_trans_id = __rt_1,
        repeat_extra_trans_num = __rt_2,
        star = 2,
        upgrade_star_extra_cost = {
            {itemId = 1003, num = 1000}, {itemId = 1601, num = 10}
        }
    }, {
        rank = 3,
        rare = 1,
        repeat_extra_trans_id = __rt_3,
        repeat_extra_trans_num = __rt_4,
        star = 3,
        upgrade_star_extra_cost = {{itemId = 1003, num = 2000}},
        upgrade_star_frag_cost = 30
    }, {
        rank = 4,
        rare = 2,
        repeat_extra_trans_id = __rt_3,
        repeat_extra_trans_num = __rt_4,
        star = 4,
        upgrade_star_extra_cost = {
            {itemId = 1003, num = 3000}, {itemId = 1601, num = 30}
        }
    }, {
        rank = 5,
        rare = 2,
        star = 5,
        upgrade_star_extra_cost = {{itemId = 1003, num = 4000}},
        upgrade_star_frag_cost = 80
    }, {
        rank = 6,
        star = 6,
        upgrade_star_extra_cost = {
            {itemId = 1003, num = 5000}, {itemId = 1602, num = 10}
        }
    }, {
        rank = 7,
        star = 7,
        ultimateskill_level = 2,
        upgrade_star_extra_cost = {{itemId = 1003, num = 7500}},
        upgrade_star_frag_cost = 120
    }, {
        rank = 8,
        star = 8,
        ultimateskill_level = 3,
        upgrade_star_extra_cost = {
            {itemId = 1003, num = 10000}, {itemId = 1602, num = 50}
        }
    }, {
        rank = 9,
        star = 9,
        ultimateskill_level = 4,
        upgrade_star_extra_cost = {{itemId = 1003, num = 20000}},
        upgrade_star_frag_cost = 150
    }, {
        rank = 10,
        star = 10,
        ultimateskill_level = 5,
        upgrade_star_extra_cost = {
            {itemId = 1003, num = 25000}, {itemId = 1603, num = 30}
        }
    }
}
local __default_values = {
    rank = 1,
    rare = 3,
    repeat_extra_trans_id = __rt_5,
    repeat_extra_trans_num = __rt_6,
    skill_level_max = 5,
    star = 1,
    ultimateskill_level = 1,
    upgrade_star_extra_cost = {{itemId = 1003, num = 0}},
    upgrade_star_frag_cost = 0
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(hero_rank) do setmetatable(v, base) end
local __rawdata = {
    __basemetatable = base,
    maxRank = 10,
    maxRare = 3,
    maxSkillLevel = 5,
    maxStar = 10
}
setmetatable(hero_rank, {__index = __rawdata})
return hero_rank

