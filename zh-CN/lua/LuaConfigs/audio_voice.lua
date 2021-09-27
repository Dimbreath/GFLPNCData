local __rt_1 = {}
local __rt_2 = {6}
local __rt_3 = {0}
local audio_voice = {
{describe = 379491, is_show = 1, name = "MORNING"}
, 
{describe = 350428, id = 2, is_show = 2, name = "AFTERNOON"}
, 
{describe = 474134, id = 3, is_show = 3, name = "EVENING"}
, 
{describe = 423077, id = 4, is_show = 4, name = "MIDNIGHT"}
, 
{describe = 307943, id = 5, is_show = 5, name = "DIALOGUE1"}
, 
{describe = 113172, id = 6, is_show = 6, name = "DIALOGUE2"}
, 
{describe = "DIALOGUE3", id = 7, name = "DIALOGUE3"}
, 
{describe = 442689, id = 8, is_show = 7, name = "DIALOGUE4"}
, 
{describe = "DIALOGUE5", id = 9, name = "DIALOGUE5"}
, 
{describe = 427119, id = 10, is_show = 8, name = "INTERACT1"}
, 
{describe = 232348, id = 11, is_show = 9, name = "INTERACT2"}
, 
{describe = 37577, id = 12, is_show = 10, name = "INTERACT3"}
, 
{describe = "NEWYEAR", id = 13, name = "NEWYEAR"}
, 
{describe = "VALENTINE", id = 14, name = "VALENTINE"}
, 
{describe = "TANABATA", id = 15, name = "TANABATA"}
, 
{id = 16, name = "ALLHALLOWS"}
, 
{describe = "CHRISTMAS", id = 17, name = "CHRISTMAS"}
, 
{describe = "PLAYERBIRTHDAY", id = 18, name = "PLAYERBIRTHDAY"}
; 
[101] = {describe = 208045, id = 101, is_show = 11, name = "GAIN"}
, 
[102] = {describe = 62926, id = 102, is_show = 12, name = "LEVELUP"}
, 
[103] = {describe = 432664, id = 103, is_show = 13, name = "RANKUP"}
, 
[104] = {describe = "RANKMAX", id = 104, name = "RANKMAX"}
, 
[105] = {describe = 343117, id = 105, is_show = 14, name = "FORMATION"}
, 
[106] = {describe = 382309, id = 106, is_show = 15, name = "BATTLE"}
, 
[107] = {describe = 53739, id = 107, is_show = 16, name = "SKILL"}
, 
[108] = {describe = "MVP1", id = 108, is_show = 17, name = "MVP1"}
, 
[109] = {describe = "MVP2", id = 109, is_show = 18, name = "MVP2"}
, 
[110] = {describe = "DUTY", id = 110, name = "DUTY"}
, 
[111] = {describe = 214099, id = 111, is_show = 19, name = "RETREAT"}
, 
[112] = {describe = 54720, id = 112, name = "RELATIONSHIP1", pre_condition = __rt_2, pre_para1 = __rt_3, pre_para2 = __rt_2}
, 
[113] = {describe = 384237, id = 113, name = "RELATIONSHIP2", pre_condition = __rt_2, pre_para1 = __rt_3, 
pre_para2 = {7}
}
, 
[114] = {describe = 189466, id = 114, name = "RELATIONSHIP3", pre_condition = __rt_2, pre_para1 = __rt_3, 
pre_para2 = {8}
}
, 
[115] = {describe = 518983, id = 115, name = "RELATIONSHIP4", pre_condition = __rt_2, pre_para1 = __rt_3, 
pre_para2 = {9}
}
, 
[116] = {describe = 324212, id = 116, name = "RELATIONSHIP5", pre_condition = __rt_2, pre_para1 = __rt_3, 
pre_para2 = {10}
}
, 
[117] = {describe = "OATH", id = 117, name = "OATH"}
, 
[118] = {describe = 120297, id = 118, is_show = 20, name = "TITLE"}
, 
[140] = {describe = 319339, id = 140}
, 
[141] = {describe = 450835, id = 141, name = "AGREE"}
, 
[142] = {describe = 308809, id = 142, name = "APPRECIATE"}
, 
[143] = {describe = 443615, id = 143, name = "FEELING"}
, 
[144] = {describe = 448691, id = 144, name = "LOWMOOD"}
, 
[145] = {describe = 461636, id = 145, name = "MOOD1"}
, 
[146] = {describe = 108415, id = 146, name = "MOOD2"}
}
local __default_values = {describe = "ALLHALLOWS", id = 1, is_show = 0, name = "ACCEPT", pre_condition = __rt_1, pre_para1 = __rt_1, pre_para2 = __rt_1}
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

