local recommend_dialogue = {
{action = "wait_1", id = 1}
, 
{action = "wait_2", id = 2, text = 395247}
, 
{action = "login_1", id = 3, text = 218444}
, 
{action = "login_2", id = 4, text = 503255}
, 
{id = 5, text = 295721}
, 
{action = "buy_2", id = 6, text = 337330}
, 
{action = "buy_3", id = 7, text = 441218}
, 
{action = "buy_4", id = 8, text = 422893}
, 
{action = "touch_1", id = 9, text = 374936}
, 
{action = "touch_2", id = 10, text = 141801}
, 
{action = "touch_3", id = 11, text = 165208}
; 
[0] = {action = "normal", text = 147252}
}
local __default_values = {action = "buy_1", id = 0, text = 105942}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(recommend_dialogue) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
config = {
buy = {5, 6, 7, 8}
, 
login = {3, 4}
, 
normal = {0}
, 
touch = {9, 10, 11}
, 
wait = {1, 2}
}
, 
idList = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
}
setmetatable(recommend_dialogue, {__index = __rawdata})
return recommend_dialogue

