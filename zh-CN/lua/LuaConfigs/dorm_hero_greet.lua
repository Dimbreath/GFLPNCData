local dorm_hero_greet = {
[1001] = {}
, 
[1002] = {hero_id = 1002}
, 
[1003] = {hero_id = 1003}
, 
[1004] = {hero_id = 1004}
, 
[1005] = {hero_id = 1005}
, 
[1006] = {hero_id = 1006}
, 
[1007] = {hero_id = 1007}
, 
[1008] = {hero_id = 1008}
, 
[1009] = {hero_id = 1009}
, 
[1010] = {hero_id = 1010}
, 
[1011] = {hero_id = 1011}
, 
[1012] = {hero_id = 1012}
, 
[1013] = {hero_id = 1013}
, 
[1014] = {hero_id = 1014}
, 
[1015] = {hero_id = 1015}
, 
[1016] = {hero_id = 1016}
, 
[1017] = {hero_id = 1017}
, 
[1018] = {hero_id = 1018}
, 
[1019] = {hero_id = 1019}
, 
[1020] = {hero_id = 1020}
, 
[1021] = {hero_id = 1021}
, 
[1022] = {hero_id = 1022}
, 
[1023] = {hero_id = 1023}
, 
[1024] = {hero_id = 1024}
, 
[1025] = {hero_id = 1025}
, 
[1026] = {hero_id = 1026}
, 
[1027] = {hero_id = 1027}
, 
[1028] = {hero_id = 1028}
, 
[1029] = {hero_id = 1029}
, 
[1030] = {hero_id = 1030}
, 
[1031] = {hero_id = 1031}
, 
[1032] = {hero_id = 1032}
, 
[1033] = {hero_id = 1033}
, 
[1034] = {hero_id = 1034}
, 
[1035] = {hero_id = 1035}
, 
[1036] = {hero_id = 1036}
, 
[1037] = {hero_id = 1037}
, 
[1038] = {hero_id = 1038}
, 
[1039] = {hero_id = 1039}
, 
[1040] = {hero_id = 1040}
}
local __default_values = {hero_action = "Dorm_Talk", hero_id = 1001, loop_time = 2.5}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dorm_hero_greet) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_hero_greet, {__index = __rawdata})
return dorm_hero_greet

