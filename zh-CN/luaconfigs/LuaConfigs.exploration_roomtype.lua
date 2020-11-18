-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {1, 1, 1}
local exploration_roomtype = {
{
color = {0.9137, 0.5569, 0.0431}
, id = 1, title = 399082}
, 
{
color = {0.149, 0.949, 0.251}
, icon = "ICON_Room_empty", id = 2}
, 
{icon = "ICON_Room_enemy", id = 3, title = 165461}
, 
{
color = {0.9059, 0.7804, 0.3451}
, icon = "ICON_Room_item", id = 4, title = 248668}
, 
{
color = {0.3059, 0.7255, 0.902}
, icon = "ICON_Room_store", id = 5, title = 37428}
, 
{
color = {0.9725, 0.4118, 0.8627}
, icon = "ICON_Room_elite", id = 6, title = 155560}
, 
{
color = {0.6078, 0.2196, 0.8902}
, icon = "ICON_Room_challenge", id = 7, title = 4301}
, 
{
color = {0.902, 0.4824, 0.3059}
, icon = "ICON_Room_event", id = 8, title = 276001}
, 
{
color = {0.7922, 0.902, 0.3059}
, icon = "ICON_Room_recoveIry", id = 9, title = 482816}
, 
{
color = {0.2392, 0.7059, 0.6588}
, icon = "ICON_Room_chip", id = 10, title = 346090}
; 
[0] = {icon = "ICON_Room_start", title = 407683}
}
local __default_values = {color = __rt_1, icon = "ICON_Room_boss", id = 0, title = 108362}
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

