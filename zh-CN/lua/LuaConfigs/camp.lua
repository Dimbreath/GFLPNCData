local camp = {
{camp_audio = 4004, camp_video_path = "energy", name = 387183}
, 
{icon = "2_camp", id = 2}
, 
{camp_audio = 4001, camp_video_path = "dna", icon = "3_camp", id = 3, name = 28609}
, 
{camp_audio = 4003, camp_video_path = "cyber", icon = "4_camp", id = 4, name = 11829}
, 
{camp_audio = 4002, camp_video_path = "global", icon = "5_camp", id = 5, name = 444397}
}
local __default_values = {camp_audio = 4000, camp_video_path = "42lab", icon = "1_camp", id = 1, name = "42LAB"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(camp) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(camp, {__index = __rawdata})
return camp

