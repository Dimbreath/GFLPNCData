local __rt_1 = {1, 1, 1}
local __rt_2 = {0.149, 0.949, 0.251}
local __rt_3 = {0.3059, 0.7255, 0.902}
local __rt_4 = {0.7922, 0.902, 0.3059}
local exploration_roomtype = {
{
color = {0.9137, 0.5569, 0.0431}
, icon = "ICON_Room_boss", id = 1, priority = 2, real_logic = 1, title = 399082}
, 
{id = 2, priority = 11, real_logic = 0, title = 108362}
, 
{color = __rt_1, icon = "ICON_Room_enemy", id = 3, priority = 9, real_logic = 1, title = 165461}
, 
{
color = {0.9059, 0.7804, 0.3451}
, icon = "ICON_Room_item", id = 4, priority = 4, real_logic = 4, title = 248668}
, 
{color = __rt_3, icon = "ICON_Room_store", id = 5, priority = 8, real_logic = 3, title = 386204}
, 
{
color = {0.9725, 0.4118, 0.8627}
, icon = "ICON_Room_elite", id = 6, priority = 6, real_logic = 1, title = 155560}
, 
{
color = {0.6078, 0.2196, 0.8902}
, icon = "ICON_Room_challenge", id = 7, priority = 7, real_logic = 1, title = 4301}
, 
{
color = {0.902, 0.4824, 0.3059}
, icon = "ICON_Room_event", id = 8, title = 276001}
, 
{color = __rt_4, icon = "ICON_Room_recoveIry", id = 9, priority = 3}
, 
{
color = {0.2392, 0.7059, 0.6588}
, icon = "ICON_Room_chip", id = 10, priority = 10, real_logic = 2, title = 346090}
, 
{
color = {0.8, 0.3373, 0.2745}
, icon = "ICON_Room_spevent", id = 11, title = 193455}
, 
{color = __rt_3, icon = "ICON_Room_assist", id = 12, title = 5100}
, 
{color = __rt_4, icon = "ICON_Room_recoveIry", id = 13, priority = 3}
; 
[0] = {color = __rt_1, icon = "ICON_Room_start", priority = 1, real_logic = 0, title = 407683}
, 
[100] = {id = 100, priority = 100, real_logic = 0, title = 278851}
}
local __default_values = {color = __rt_2, icon = "ICON_Room_empty", id = 0, priority = 5, real_logic = 5, title = 482816}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(exploration_roomtype) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_roomtype, {__index = __rawdata})
return exploration_roomtype

