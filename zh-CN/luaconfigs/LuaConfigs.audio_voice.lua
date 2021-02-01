-- params : ...
-- function num : 0 , upvalues : _ENV
local audio_voice = {
{name = "MORNING"}
, 
{id = 2}
, 
{id = 3, name = "EVENING"}
, 
{id = 4, name = "MIDNIGHT"}
, 
{id = 5, name = "DIALOGUE1"}
, 
{id = 6, name = "DIALOGUE2"}
, 
{id = 7, name = "DIALOGUE3"}
, 
{id = 8, name = "DIALOGUE4"}
, 
{id = 9, name = "DIALOGUE5"}
, 
{id = 10, name = "INTERACT1"}
, 
{id = 11, name = "INTERACT2"}
, 
{id = 12, name = "INTERACT3"}
, 
{id = 13, name = "NEWYEAR"}
, 
{id = 14, name = "VALENTINE"}
, 
{id = 15, name = "TANABATA"}
, 
{id = 16, name = "ALLHALLOWS"}
, 
{id = 17, name = "CHRISTMAS"}
, 
{id = 18, name = "PLAYERBIRTHDAY"}
; 
[101] = {id = 101, name = "GAIN"}
, 
[102] = {id = 102, name = "LEVELUP"}
, 
[103] = {id = 103, name = "RANKUP"}
, 
[104] = {id = 104, name = "RANKMAX"}
, 
[105] = {id = 105, name = "FORMATION"}
, 
[106] = {id = 106, name = "BATTLE"}
, 
[107] = {id = 107, name = "SKILL"}
, 
[108] = {id = 108, name = "MVP1"}
, 
[109] = {id = 109, name = "MVP2"}
, 
[110] = {id = 110, name = "DUTY"}
, 
[111] = {id = 111, name = "RETREAT"}
, 
[112] = {id = 112, name = "RELATIONSHIP1"}
, 
[113] = {id = 113, name = "RELATIONSHIP2"}
, 
[114] = {id = 114, name = "RELATIONSHIP3"}
, 
[115] = {id = 115, name = "RELATIONSHIP4"}
, 
[116] = {id = 116, name = "RELATIONSHIP5"}
, 
[117] = {id = 117, name = "OATH"}
, 
[118] = {id = 118, name = "TITLE"}
}
local __default_values = {id = 1, name = "AFTERNOON"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(audio_voice) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(audio_voice, {__index = __rawdata})
return audio_voice

