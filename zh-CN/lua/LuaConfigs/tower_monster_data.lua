local tower_monster_data = {
[20000] = {}
, 
[20001] = {monster_id = 20001}
, 
[20002] = {monster_id = 20002}
, 
[20003] = {monster_id = 20003}
, 
[20004] = {monster_id = 20004}
, 
[20005] = {monster_id = 20005}
, 
[20006] = {monster_id = 20006}
, 
[20007] = {monster_id = 20007}
, 
[20008] = {monster_id = 20008}
, 
[20009] = {monster_id = 20009}
, 
[20010] = {monster_id = 20010}
, 
[20011] = {monster_id = 20011}
, 
[20012] = {monster_id = 20012}
, 
[20013] = {monster_id = 20013}
, 
[20014] = {monster_id = 20014}
, 
[20015] = {monster_id = 20015}
, 
[20016] = {monster_id = 20016}
, 
[20017] = {monster_id = 20017}
, 
[20018] = {monster_id = 20018}
, 
[20019] = {monster_id = 20019}
, 
[20020] = {monster_id = 20020}
, 
[20021] = {monster_id = 20021}
, 
[20022] = {monster_id = 20022}
, 
[20023] = {monster_id = 20023}
, 
[20024] = {monster_id = 20024}
, 
[20025] = {monster_id = 20025}
, 
[20026] = {monster_id = 20026}
, 
[20027] = {monster_id = 20027}
, 
[20028] = {monster_id = 20028}
, 
[20029] = {monster_id = 20029}
, 
[20030] = {monster_id = 20030}
, 
[20031] = {monster_id = 20031}
, 
[20032] = {monster_id = 20032}
, 
[20033] = {monster_id = 20033}
, 
[20034] = {monster_id = 20034}
, 
[20035] = {monster_id = 20035}
, 
[20036] = {monster_id = 20036}
, 
[20037] = {monster_id = 20037}
, 
[20038] = {monster_id = 20038}
, 
[20039] = {monster_id = 20039}
, 
[20040] = {monster_id = 20040}
, 
[20041] = {monster_id = 20041}
, 
[20042] = {monster_id = 20042}
, 
[20043] = {monster_id = 20043}
, 
[20044] = {monster_id = 20044}
, 
[20045] = {monster_id = 20045}
, 
[20046] = {monster_id = 20046}
, 
[20047] = {monster_id = 20047}
, 
[20048] = {monster_id = 20048}
, 
[20049] = {monster_id = 20049}
, 
[30002] = {coin_gain_formula = 10168, monster_id = 30002}
, 
[50001] = {coin_gain_formula = 10168, monster_id = 50001}
, 
[50002] = {coin_gain_formula = 10168, monster_id = 50002}
, 
[50003] = {coin_gain_formula = 10168, monster_id = 50003}
, 
[50005] = {coin_gain_formula = 10168, monster_id = 50005}
, 
[50009] = {coin_gain_formula = 10168, monster_id = 50009}
, 
[50010] = {coin_gain_formula = 10168, monster_id = 50010}
, 
[50011] = {coin_gain_formula = 10168, monster_id = 50011}
, 
[50013] = {coin_gain_formula = 10168, monster_id = 50013}
, 
[50015] = {coin_gain_formula = 10168, monster_id = 50015}
, 
[50021] = {coin_gain_formula = 10168, monster_id = 50021}
, 
[50037] = {coin_gain_formula = 10168, monster_id = 50037}
, 
[50040] = {coin_gain_formula = 10168, monster_id = 50040}
, 
[50048] = {coin_gain_formula = 10168, monster_id = 50048}
}
local __default_values = {coin_gain_formula = 1008, monster_id = 20000}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(tower_monster_data) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(tower_monster_data, {__index = __rawdata})
return tower_monster_data

