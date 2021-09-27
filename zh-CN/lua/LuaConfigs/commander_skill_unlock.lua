local __rt_1 = {""}
local __rt_2 = {1}
local __rt_3 = {3}
local __rt_4 = {}
local __rt_5 = {"CommanderSkill_0_3"}
local __rt_6 = {
{pre_condition = __rt_3, 
pre_para1 = {1102}
, pre_para2 = __rt_4}
}
local __rt_7 = {"CommanderSkill_0_9"}
local __rt_8 = {"CommanderSkill_0_2"}
local __rt_9 = {
{pre_condition = __rt_3, 
pre_para1 = {1105}
, pre_para2 = __rt_4}
}
local __rt_10 = {"CommanderSkill_0_5"}
local __rt_11 = {
{pre_condition = __rt_3, 
pre_para1 = {1109}
, pre_para2 = __rt_4}
}
local __rt_12 = {"CommanderSkill_0_8"}
local __rt_13 = {
{pre_condition = __rt_3, 
pre_para1 = {2103}
, pre_para2 = __rt_4}
}
local __rt_14 = {
{pre_condition = __rt_3, 
pre_para1 = {2107}
, pre_para2 = __rt_4}
}
local __rt_15 = {
{pre_condition = __rt_3, 
pre_para1 = {3101}
, pre_para2 = __rt_4}
}
local __rt_16 = {
{pre_condition = __rt_3, 
pre_para1 = {2111}
, pre_para2 = __rt_4}
}
local commander_skill_unlock = {
{
[5011] = {
unlockPreConditionList = {
{pre_condition = __rt_3, 
pre_para1 = {100101}
, pre_para2 = __rt_4}
}
}
, 
[5012] = {describe_base = 107688, 
levelDescDic = {264664}
, levelIconList = __rt_5}
, 
[5013] = {describe_base = 107688, 
levelDescDic = {496660}
, levelIconList = __rt_7}
, 
[5021] = {place = 2}
, 
[5022] = {describe_base = 13811, 
levelDescDic = {182610}
, levelIconList = __rt_8, place = 2, unlockPreConditionList = __rt_9}
, 
[5023] = {describe_base = 302881, 
levelDescDic = {407660}
, levelIconList = __rt_5, place = 2, unlockPreConditionList = __rt_9}
, 
[5031] = {place = 3, 
unlockPreConditionList = {
{pre_condition = __rt_3, 
pre_para1 = {100104}
, pre_para2 = __rt_4}
}
}
, 
[5032] = {describe_base = 223249, 
levelDescDic = {262194}
, levelIconList = __rt_10, place = 3, unlockPreConditionList = __rt_11}
, 
[5033] = {describe_base = 420748, 
levelDescDic = {307527}
, levelIconList = __rt_12, place = 3, unlockPreConditionList = __rt_11}
}
, 
{
[5111] = {unlockPreConditionList = __rt_13}
, 
[5112] = {describe_base = 234442, 
levelDescDic = {121107}
, levelIconList = __rt_5, unlockPreConditionList = __rt_14}
, 
[5113] = {describe_base = 234442, 
levelDescDic = {89900}
, levelIconList = __rt_7, unlockPreConditionList = __rt_14}
, 
[5131] = {place = 3, unlockPreConditionList = __rt_13}
, 
[5132] = {describe_base = 384118, 
levelDescDic = {429365}
, levelIconList = __rt_10, place = 3, unlockPreConditionList = __rt_15}
, 
[5133] = {describe_base = 384118, 
levelDescDic = {202308}
, levelIconList = __rt_12, place = 3, unlockPreConditionList = __rt_15}
, 
[5141] = {place = 2, unlockPreConditionList = __rt_13}
, 
[5142] = {describe_base = 13811, 
levelDescDic = {248433}
, levelIconList = __rt_8, place = 2, unlockPreConditionList = __rt_16}
, 
[5143] = {describe_base = 302881, 
levelDescDic = {90663}
, levelIconList = __rt_5, place = 2, unlockPreConditionList = __rt_16}
}
}
local __default_values = {describe_base = "", is_ultimate = false, levelDescDic = __rt_1, levelIconList = __rt_1, place = 1, skill_type = 1, unlockList = __rt_2, unlockPreConditionList = __rt_6}
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
{[5011] = 1, [5012] = 1, [5013] = 1, [5021] = 1, [5022] = 1, [5023] = 1, [5031] = 1, [5032] = 1, [5033] = 1}
}
, 
{
{[5111] = 1, [5112] = 1, [5113] = 1, [5131] = 1, [5132] = 1, [5133] = 1, [5141] = 1, [5142] = 1, [5143] = 1}
}
}
}
setmetatable(commander_skill_unlock, {__index = __rawdata})
return commander_skill_unlock

