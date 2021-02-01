-- params : ...
-- function num : 0 , upvalues : _ENV
local audio_voice_hero = {
[1001] = {}
, 
[1002] = {id = 1002}
, 
[1003] = {id = 1003}
, 
[1004] = {id = 1004}
, 
[1005] = {id = 1005}
, 
[1006] = {id = 1006}
, 
[1007] = {id = 1007}
, 
[1008] = {id = 1008}
, 
[1009] = {id = 1009}
, 
[1010] = {id = 1010}
, 
[1012] = {id = 1012}
, 
[1013] = {id = 1013}
, 
[1014] = {id = 1014}
, 
[1016] = {id = 1016}
, 
[1017] = {id = 1017}
, 
[1018] = {id = 1018}
, 
[1020] = {id = 1020}
, 
[1021] = {id = 1021}
, 
[1022] = {id = 1022}
, 
[1023] = {id = 1023}
, 
[1026] = {id = 1026}
, 
[1027] = {id = 1027}
, 
[1031] = {id = 1031}
, 
[1034] = {id = 1034}
, 
[1035] = {id = 1035}
, 
[1036] = {id = 1036}
, 
[1037] = {id = 1037}
, 
[1038] = {id = 1038}
, 
[1039] = {id = 1039}
}
local __default_values = {id = 1001}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(audio_voice_hero) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
totalVoiceHeroIdList = {1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1012, 1013, 1014, 1016, 1017, 1018, 1020, 1021, 1022, 1023, 1026, 1027, 1031, 1034, 1035, 1036, 1037, 1038, 1039}
}
setmetatable(audio_voice_hero, {__index = __rawdata})
return audio_voice_hero

