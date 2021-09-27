local __rt_1 = {}
local chip_tag = {
{
chip_list = {10127, 10141, 10143, 10246}
, influence = 1, tag_name = 183261}
, 
{
chip_list = {10022, 10137, 10280, 10281}
, id = 2, influence = 1, tag_icon = "ICON_tag_buff_2", tag_name = 144047}
, 
{
chip_list = {10136, 10204, 10218, 10251}
, id = 3, influence = 1, tag_icon = "ICON_tag_buff_3", tag_name = 379924}
, 
{
chip_list = {10206, 10207, 10221, 10222}
, id = 4, influence = 3, tag_icon = "ICON_tag_buff_4", tag_name = 436523}
, 
{
chip_list = {10015, 10061, 10120, 10286}
, id = 5, influence = 3, tag_icon = "ICON_tag_buff_5", tag_name = 198709}
, 
{
chip_list = {10128, 10157, 10220, 10287}
, id = 6, influence = 3, tag_icon = "ICON_tag_buff_6", tag_name = 245094}
, 
{
chip_list = {10147, 10224, 10225, 10247}
, id = 7, influence = 2, tag_icon = "ICON_tag_buff_7", tag_name = 298311}
, 
{
chip_list = {10209, 10211, 10226, 10289}
, id = 8, influence = 2, tag_icon = "ICON_tag_buff_8"}
, 
{
chip_list = {10074, 10123, 10223, 10288}
, id = 9, influence = 2, tag_icon = "ICON_tag_buff_9", tag_name = 394586}
, 
{
chip_list = {10066, 10124, 10138, 10290}
, id = 10, influence = 4, tag_icon = "ICON_tag_buff_10", tag_name = 277757}
, 
{
chip_list = {10149, 10150, 10151, 10227}
, id = 11, influence = 4, tag_icon = "ICON_tag_buff_11", tag_name = 339375}
, 
{
chip_list = {10135, 10228, 10230, 10231}
, id = 12, influence = 4, tag_icon = "ICON_tag_buff_12", tag_name = 452851}
, 
{
chip_list = {10234, 10248, 10250, 10292}
, id = 13, influence = 5, tag_icon = "ICON_tag_buff_13", tag_name = 495344}
, 
{
chip_list = {10139, 10140, 10232, 10274}
, id = 14, influence = 5, tag_icon = "ICON_tag_buff_14", tag_name = 387502}
, 
{
chip_list = {10152, 10154, 10254, 10291}
, id = 15, influence = 5, tag_icon = "ICON_tag_buff_15", tag_name = 270389}
, 
{
chip_list = {10215, 10238, 10239, 10240, 10279}
, chip_max_count = 5, id = 16, tag_icon = "ICON_tag_buff_16", tag_name = 362212}
, 
{
chip_list = {10133, 10165, 10167, 10293, 10294}
, chip_max_count = 5, id = 17, tag_icon = "ICON_tag_buff_17", tag_name = 402578}
, 
{
chip_list = {10076, 10193, 10212, 10213, 10295}
, chip_max_count = 5, id = 18, tag_icon = "ICON_tag_buff_18", tag_name = 387945}
, 
{chip_max_count = 0, id = 19, tag_icon = "ICON_tag_buff_19", tag_name = 441190}
, 
{chip_max_count = 0, id = 20, tag_icon = "ICON_tag_buff_20", tag_name = 299950}
, 
{chip_max_count = 0, id = 21, tag_icon = "ICON_tag_buff_21", tag_name = 469835}
, 
{chip_max_count = 0, id = 22, tag_icon = "ICON_tag_buff_22", tag_name = 449895}
, 
{chip_max_count = 0, id = 23, tag_icon = "ICON_tag_buff_23", tag_name = 484211}
, 
{
chip_list = {10260, 10261}
, chip_max_count = 2, id = 24, influence = 2, suit_max = 2, tag_icon = "ICON_tag_buff_24", tag_name = 443022}
, 
{
chip_list = {10262, 10263, 10264, 10265}
, id = 25, influence = 3, tag_icon = "ICON_tag_buff_25", tag_name = 228407}
, 
{
chip_list = {10266, 10267, 10268, 10269}
, id = 26, influence = 2, tag_icon = "ICON_tag_buff_26", tag_name = 504819}
, 
{
chip_list = {10270, 10271, 10272, 10273}
, id = 27, influence = 4, tag_icon = "ICON_tag_buff_27", tag_name = 385230}
, 
{
chip_list = {10275, 10276, 10277, 10278}
, id = 28, influence = 5, tag_icon = "ICON_tag_buff_28", tag_name = 69431}
, 
{
chip_list = {10282, 10283, 10284, 10285}
, id = 29, influence = 1, tag_icon = "ICON_tag_buff_29", tag_name = 291360}
}
local __default_values = {chip_list = __rt_1, chip_max_count = 4, id = 1, influence = 6, suit_max = 4, tag_icon = "ICON_tag_buff_1", tag_name = 135898}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(chip_tag) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
tag_suits = {
{
{chip_id = 30002, number = 2}
, 
{chip_id = 30003, number = 4}
}
, 
{
{chip_id = 30000, number = 2}
, 
{chip_id = 30001, number = 4}
}
, 
{
{chip_id = 30004, number = 2}
, 
{chip_id = 30005, number = 4}
}
, 
{
{chip_id = 30006, number = 2}
, 
{chip_id = 30007, number = 4}
}
, 
{
{chip_id = 30010, number = 2}
, 
{chip_id = 30011, number = 4}
}
, 
{
{chip_id = 30030, number = 2}
, 
{chip_id = 30031, number = 4}
}
, 
{
{chip_id = 30008, number = 2}
, 
{chip_id = 30009, number = 4}
}
, 
{
{chip_id = 30034, number = 2}
, 
{chip_id = 30035, number = 4}
}
, 
{
{chip_id = 30032, number = 2}
, 
{chip_id = 30033, number = 4}
}
, 
{
{chip_id = 30036, number = 2}
, 
{chip_id = 30037, number = 4}
}
, 
{
{chip_id = 30038, number = 2}
, 
{chip_id = 30039, number = 4}
}
, 
{
{chip_id = 30012, number = 2}
, 
{chip_id = 30013, number = 4}
}
, 
{
{chip_id = 30014, number = 2}
, 
{chip_id = 30015, number = 4}
}
, 
{
{chip_id = 30016, number = 2}
, 
{chip_id = 30017, number = 4}
}
, 
{
{chip_id = 30040, number = 2}
, 
{chip_id = 30041, number = 4}
}
, 
{
{chip_id = 30018, number = 2}
, 
{chip_id = 30019, number = 4}
}
, 
{
{chip_id = 30042, number = 2}
, 
{chip_id = 30043, number = 4}
}
, 
{
{chip_id = 30044, number = 2}
, 
{chip_id = 30045, number = 4}
}
, 
{
{chip_id = 15037, number = 2}
, 
{chip_id = 15038, number = 4}
}
, 
{
{chip_id = 15039, number = 2}
, 
{chip_id = 15040, number = 4}
}
, 
{
{chip_id = 15041, number = 2}
, 
{chip_id = 15042, number = 4}
}
, 
{
{chip_id = 15043, number = 2}
, 
{chip_id = 15044, number = 4}
}
, 
{
{chip_id = 15045, number = 2}
, 
{chip_id = 15046, number = 4}
}
, 
{
{chip_id = 15047, number = 2}
}
, 
{
{chip_id = 30022, number = 2}
, 
{chip_id = 30023, number = 4}
}
, 
{
{chip_id = 30025, number = 2}
, 
{chip_id = 30024, number = 4}
}
, 
{
{chip_id = 30026, number = 2}
, 
{chip_id = 30027, number = 4}
}
, 
{
{chip_id = 30028, number = 2}
, 
{chip_id = 30029, number = 4}
}
, 
{
{chip_id = 30020, number = 2}
, 
{chip_id = 30021, number = 4}
}
}
}
setmetatable(chip_tag, {__index = __rawdata})
return chip_tag

