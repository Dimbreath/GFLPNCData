local __rt_1 = {}
local __rt_2 = {10}
local __rt_3 = {11}
local __rt_4 = {12}
local __rt_5 = {touch_1 = __rt_2, touch_2 = __rt_3, touch_3 = __rt_4}
local __rt_6 = {9}
local __rt_7 = {
wait_1 = {5}
, 
wait_2 = {6}
, wait_3 = __rt_6}
local __rt_8 = {
idle_1 = {8}
}
local __rt_9 = {
touch_1 = {10, 11, 12}
}
local __rt_10 = {
wait_1 = {5, 6}
, wait_2 = __rt_6}
local skin_live2d = {
[1001] = {idle = "", idleIds = __rt_1, wait = "wait_1=5|wait_2=6|wait_3=9", waitIds = __rt_7}
, 
[300101] = {id = 300101, idle = "", idleIds = __rt_1, wait = "wait_1=5|wait_2=6|wait_3=9", waitIds = __rt_7}
, 
[300201] = {id = 300201, idle = "", idleIds = __rt_1, wait = "wait_1=5|wait_2=6|wait_3=9", waitIds = __rt_7}
, 
[300202] = {id = 300202, touch = "touch_1=10|touch_2=11|touch_3=12|touch_4=10", 
touchIds = {touch_1 = __rt_2, touch_2 = __rt_3, touch_3 = __rt_4, touch_4 = __rt_2}
, wait = "wait_1=5|wait_2=6|wait_3=9", waitIds = __rt_7}
, 
[300502] = {id = 300502, wait = "wait_1=5|wait_2=6|wait_3=9", waitIds = __rt_7}
, 
[301101] = {id = 301101, touch = "touch_1=10|touch_1=11|touch_1=12", touchIds = __rt_9}
, 
[301301] = {id = 301301}
, 
[301302] = {id = 301302, wait = "wait_1=5|wait_2=6|wait_3=9", waitIds = __rt_7}
, 
[301501] = {id = 301501, idle = "", idleIds = __rt_1, touch = "touch_1=10|touch_1=11|touch_1=12", touchIds = __rt_9}
, 
[301502] = {id = 301502, wait = "wait_1=5|wait_2=6|wait_3=9", waitIds = __rt_7}
, 
[301601] = {id = 301601, wait = "wait_1=5|wait_2=6|wait_3=9", waitIds = __rt_7}
, 
[301602] = {id = 301602, wait = "wait_1=5|wait_2=6|wait_3=9", waitIds = __rt_7}
, 
[301801] = {id = 301801, wait = "wait_1=5|wait_2=6|wait_3=9", waitIds = __rt_7}
, 
[302302] = {id = 302302}
, 
[302401] = {id = 302401, idle = "", idleIds = __rt_1, touch = "touch_1=10|touch_1=11|touch_1=12", touchIds = __rt_9}
, 
[303101] = {id = 303101, idle = "", idleIds = __rt_1, wait = "wait_1=5|wait_1=6|wait_1=8|wait_2=9", 
waitIds = {
wait_1 = {5, 6, 8}
, wait_2 = __rt_6}
}
, 
[303201] = {id = 303201, idle = "", idleIds = __rt_1, touch = "touch_1=10|touch_1=11|touch_1=12", touchIds = __rt_9}
, 
[303402] = {id = 303402}
, 
[303502] = {id = 303502, idle = "", idleIds = __rt_1, touch = "touch_1=10|touch_1=11|touch_1=12", touchIds = __rt_9}
, 
[303602] = {id = 303602, idle = "", idleIds = __rt_1, touch = "touch_1=10|touch_1=11|touch_1=12", touchIds = __rt_9}
, 
[303801] = {id = 303801, idle = "", idleIds = __rt_1, touch = "touch_1=10|touch_1=11|touch_1=12", touchIds = __rt_9}
}
local __default_values = {id = 1001, idle = "idle_1=8", idleIds = __rt_8, login_evening = 3, login_morning = 1, login_night = 4, login_noon = 2, mouth_shape = 1, touch = "touch_1=10|touch_2=11|touch_3=12", touchIds = __rt_5, wait = "wait_1=5|wait_1=6|wait_2=9", waitIds = __rt_10}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(skin_live2d) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(skin_live2d, {__index = __rawdata})
return skin_live2d

