-- params : ...
-- function num : 0 , upvalues : _ENV
local chip_tag = {
{
chip_list = {10127, 10141, 10143, 10246}
, tag_name = 183261}
, 
{
chip_list = {10018, 10022, 10134, 10137}
, id = 2, tag_icon = "ICON_tag_buff_2", tag_name = 144047}
, 
{
chip_list = {10136, 10204, 10218, 10251}
, id = 3, tag_icon = "ICON_tag_buff_3", tag_name = 379924}
, 
{
chip_list = {10206, 10207, 10221, 10222}
, id = 4, tag_icon = "ICON_tag_buff_4", tag_name = 436523}
, 
{
chip_list = {10015, 10061, 10120, 10142}
, id = 5, tag_icon = "ICON_tag_buff_5", tag_name = 198709}
, 
{
chip_list = {10128, 10144, 10157, 10220}
, id = 6, tag_icon = "ICON_tag_buff_6", tag_name = 245094}
, 
{
chip_list = {10147, 10224, 10225, 10247}
, id = 7, tag_icon = "ICON_tag_buff_7", tag_name = 298311}
, 
{
chip_list = {10209, 10210, 10211, 10226}
, id = 8, tag_icon = "ICON_tag_buff_8"}
, 
{id = 9, tag_icon = "ICON_tag_buff_9", tag_name = 394586}
, 
{
chip_list = {10066, 10124, 10131, 10138}
, id = 10, tag_icon = "ICON_tag_buff_10", tag_name = 277757}
, 
{
chip_list = {10149, 10150, 10151, 10227}
, id = 11, tag_icon = "ICON_tag_buff_11", tag_name = 339375}
, 
{
chip_list = {10135, 10228, 10230, 10231}
, id = 12, tag_icon = "ICON_tag_buff_12", tag_name = 452851}
, 
{
chip_list = {10234, 10248, 10249, 10250}
, id = 13, tag_icon = "ICON_tag_buff_13", tag_name = 495344}
, 
{
chip_list = {10125, 10139, 10232, 10252}
, id = 14, tag_icon = "ICON_tag_buff_14", tag_name = 387502}
, 
{
chip_list = {10140, 10152, 10253, 10254}
, id = 15, tag_icon = "ICON_tag_buff_15", tag_name = 270389}
, 
{
chip_list = {10214, 10215, 10238, 10239, 10240}
, chip_max_count = 5, id = 16, tag_icon = "ICON_tag_buff_16", tag_name = 94868}
, 
{
chip_list = {10133, 10164, 10165, 10166, 10167}
, chip_max_count = 5, id = 17, tag_icon = "ICON_tag_buff_17", tag_name = 402578}
, 
{
chip_list = {10076, 10119, 10193, 10212, 10213}
, chip_max_count = 5, id = 18, tag_icon = "ICON_tag_buff_18", tag_name = 387945}
, 
{
chip_list = {10169, 10170, 10171, 10173}
, id = 19, tag_icon = "ICON_tag_buff_19", tag_name = 441190}
, 
{
chip_list = {10176, 10180, 10181, 10183}
, id = 20, tag_icon = "ICON_tag_buff_20", tag_name = 299950}
, 
{
chip_list = {10188, 10190, 10191, 10194}
, id = 21, tag_icon = "ICON_tag_buff_21", tag_name = 469835}
, 
{
chip_list = {10198, 10199, 10200, 10201}
, id = 22, tag_icon = "ICON_tag_buff_22", tag_name = 449895}
, 
{
chip_list = {10241, 10242, 10243, 10244}
, id = 23, tag_icon = "ICON_tag_buff_23", tag_name = 484211}
}
local __default_values = {
chip_list = {10002, 10074, 10123, 10223}
, chip_max_count = 4, id = 1, suit_max = 4, tag_icon = "ICON_tag_buff_1", tag_name = 135898}
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
{chip_id = 15001, number = 2, suit_info = 471285}
, 
{chip_id = 15002, number = 4, suit_info = 122270}
}
, 
{
{chip_id = 15003, number = 2, suit_info = 471285}
, 
{chip_id = 15004, number = 4, suit_info = 122270}
}
, 
{
{chip_id = 15005, number = 2, suit_info = 471285}
, 
{chip_id = 15006, number = 4, suit_info = 122270}
}
, 
{
{chip_id = 15007, number = 2, suit_info = 471285}
, 
{chip_id = 15008, number = 4, suit_info = 137796}
}
, 
{
{chip_id = 15009, number = 2, suit_info = 471285}
, 
{chip_id = 15010, number = 4, suit_info = 137796}
}
, 
{
{chip_id = 15011, number = 2, suit_info = 471285}
, 
{chip_id = 15012, number = 4, suit_info = 137796}
}
, 
{
{chip_id = 15013, number = 2, suit_info = 471285}
, 
{chip_id = 15014, number = 4, suit_info = 328970}
}
, 
{
{chip_id = 15015, number = 2, suit_info = 471285}
, 
{chip_id = 15016, number = 4, suit_info = 328970}
}
, 
{
{chip_id = 15017, number = 2, suit_info = 471285}
, 
{chip_id = 15018, number = 4, suit_info = 328970}
}
, 
{
{chip_id = 15019, number = 2, suit_info = 471285}
, 
{chip_id = 15020, number = 4, suit_info = 451920}
}
, 
{
{chip_id = 15021, number = 2, suit_info = 471285}
, 
{chip_id = 15022, number = 4, suit_info = 451920}
}
, 
{
{chip_id = 15023, number = 2, suit_info = 471285}
, 
{chip_id = 15024, number = 4, suit_info = 451920}
}
, 
{
{chip_id = 15025, number = 2, suit_info = 471285}
, 
{chip_id = 15026, number = 4, suit_info = 34430}
}
, 
{
{chip_id = 15027, number = 2, suit_info = 471285}
, 
{chip_id = 15028, number = 4, suit_info = 34430}
}
, 
{
{chip_id = 15029, number = 2, suit_info = 471285}
, 
{chip_id = 15030, number = 4, suit_info = 34430}
}
, 
{
{chip_id = 15031, number = 2, suit_info = 471285}
, 
{chip_id = 15032, number = 4, suit_info = 78518}
}
, 
{
{chip_id = 15033, number = 2, suit_info = 471285}
, 
{chip_id = 15034, number = 4, suit_info = 78518}
}
, 
{
{chip_id = 15035, number = 2, suit_info = 471285}
, 
{chip_id = 15036, number = 4, suit_info = 78518}
}
, 
{
{chip_id = 15037, number = 2, suit_info = 471285}
, 
{chip_id = 15038, number = 4, suit_info = 505207}
}
, 
{
{chip_id = 15039, number = 2, suit_info = 471285}
, 
{chip_id = 15040, number = 4, suit_info = 505207}
}
, 
{
{chip_id = 15041, number = 2, suit_info = 471285}
, 
{chip_id = 15042, number = 4, suit_info = 505207}
}
, 
{
{chip_id = 15043, number = 2, suit_info = 471285}
, 
{chip_id = 15044, number = 4, suit_info = 505207}
}
, 
{
{chip_id = 15045, number = 2, suit_info = 471285}
, 
{chip_id = 15046, number = 4, suit_info = 505207}
}
}
}
setmetatable(chip_tag, {__index = __rawdata})
return chip_tag

