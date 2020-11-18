-- params : ...
-- function num : 0 , upvalues : _ENV
local audio_category = {
{}
, 
{aisac = "Aisac_SFXVolume", category = "Category_SFXVolume", id = 2}
, 
{aisac = "Aisac_VoiceVolume", category = "Category_VoiceVolume", id = 3}
}
local __default_values = {aisac = "Aisac_MusicVolume", category = "Category_MusicVolume", id = 1}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(audio_category) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(audio_category, {__index = __rawdata})
return audio_category

