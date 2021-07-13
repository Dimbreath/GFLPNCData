-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {""}
local __rt_2 = {1}
local __rt_3 = {20}
local commander_skill_unlock = {
{
[5001] = {place = 1}
, 
[5002] = {describe_base = 234442, 
levelDescDic = {121107, 381534, 200614}
, 
levelIconList = {"CommanderSkill_0_3", "CommanderSkill_0_13", "CommanderSkill_0_10"}
, place = 1, 
unlockList = {6, 11, 16}
}
, 
[5003] = {describe_base = 84236, 
levelDescDic = {457249, 516861, 405865}
, 
levelIconList = {"CommanderSkill_0_9", "CommanderSkill_0_3", "CommanderSkill_0_7"}
, place = 1, 
unlockList = {2, 5, 14}
}
, 
[5005] = {place = 2, 
unlockList = {3}
}
, 
[5006] = {describe_base = 13811, 
levelDescDic = {248433, 233034, 232396}
, 
levelIconList = {"CommanderSkill_0_2", "CommanderSkill_0_13", "CommanderSkill_0_6"}
, place = 2, 
unlockList = {4, 9, 15}
}
, 
[5007] = {describe_base = 302881, 
levelDescDic = {109840, 76190, 350300}
, 
levelIconList = {"CommanderSkill_0_3", "CommanderSkill_0_13", "CommanderSkill_0_1"}
, place = 2, 
unlockList = {5, 12, 18}
}
, 
[5009] = {place = 3}
, 
[5010] = {describe_base = 396244, 
levelDescDic = {65774, 349556, 246154}
, 
levelIconList = {"CommanderSkill_0_5", "CommanderSkill_0_4", "CommanderSkill_0_11"}
, place = 3, 
unlockList = {6, 10, 17}
}
, 
[5011] = {describe_base = 396244, 
levelDescDic = {280994, 116661, 61503}
, 
levelIconList = {"CommanderSkill_0_8", "CommanderSkill_0_4", "CommanderSkill_0_12"}
, place = 3, 
unlockList = {7, 13, 19}
}
, 
[5012] = {is_ultimate = true, place = 3, unlockList = __rt_3}
, 
[5014] = {
levelIconList = {"5"}
, skill_type = 2, 
unlockList = {10}
}
, 
[5015] = {skill_type = 2, unlockList = __rt_3}
, 
[5017] = {
levelIconList = {"2"}
, skill_type = 2, 
unlockList = {5}
}
, 
[5020] = {
levelIconList = {"14"}
, skill_type = 2, 
unlockList = {15}
}
}
}
local __default_values = {describe_base = "", is_ultimate = false, levelDescDic = __rt_1, levelIconList = __rt_1, place = 0, skill_type = 1, unlockList = __rt_2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(commander_skill_unlock) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base, 
treeLevelSkillCfg = {
{
{[5001] = 1, [5009] = 1}
, 
{[5003] = 1}
, 
{[5005] = 1}
, 
{[5006] = 1}
, 
{[5003] = 2, [5007] = 1, [5017] = 1}
, 
{[5002] = 1, [5010] = 1}
, 
{[5011] = 1}
; 
[9] = {[5006] = 2}
, 
[10] = {[5010] = 2, [5014] = 1}
, 
[11] = {[5002] = 2}
, 
[12] = {[5007] = 2}
, 
[13] = {[5011] = 2}
, 
[14] = {[5003] = 3}
, 
[15] = {[5006] = 3, [5020] = 1}
, 
[16] = {[5002] = 3}
, 
[17] = {[5010] = 3}
, 
[18] = {[5007] = 3}
, 
[19] = {[5011] = 3}
, 
[20] = {[5012] = 1, [5015] = 1}
}
}
}
setmetatable(commander_skill_unlock, {__index = __rawdata})
return commander_skill_unlock

