-- params : ...
-- function num : 0 , upvalues : _ENV
local audio_voice_point = {
{
vo_list = {5, 6}
}
, 
{id = 2, 
vo_list = {8}
}
, 
{id = 3}
, 
{id = 4, 
vo_list = {106}
}
, 
{id = 5, 
vo_list = {108, 109}
}
, 
{id = 6, 
vo_list = {110}
}
}
local __default_values = {id = 1, 
vo_list = {105}
}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(audio_voice_point) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(audio_voice_point, {__index = __rawdata})
return audio_voice_point

