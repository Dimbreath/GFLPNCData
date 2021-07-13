-- params : ...
-- function num : 0 , upvalues : _ENV
local __rt_1 = {}
local skin = {
[300201] = {describe = 187181, name = 169808, src_id_pic = "anna_p2"}
, 
[300202] = {describe = 230714, id = 300202, name = 161463, src_id_icon = "ICON_Item_300202", src_id_pic = "anna_p3", theme = 3}
, 
[300302] = {describe = 114048, heroId = 1003, id = 300302, name = 74675, src_id_icon = "ICON_Item_300302", src_id_pic = "sol_p3", theme = 3}
, 
[300402] = {describe = 308760, heroId = 1004, id = 300402, name = 16959, src_id_icon = "ICON_Item_300402", src_id_pic = "simo_p3", theme = 3}
, 
[300502] = {describe = 247775, heroId = 1005, id = 300502, name = 471104, src_id_icon = "ICON_Item_300502", src_id_pic = "croque_p3", theme = 3}
, 
[300701] = {describe = 486083, heroId = 1007, id = 300701, name = 26565, src_id_icon = "ICON_Item_300701", src_id_pic = "chelsea_p2"}
, 
[300702] = {describe = 249640, heroId = 1007, id = 300702, name = 112238, src_id_icon = "ICON_Item_300702", src_id_pic = "chelsea_p3"}
, 
[300901] = {describe = 192667, heroId = 1009, id = 300901, name = 66954, src_id_icon = "ICON_Item_300901", src_id_pic = "mai_p2"}
, 
[300902] = {describe = 146501, heroId = 1009, id = 300902, name = 135067, src_id_icon = "ICON_Item_300902", src_id_pic = "mai_p3"}
, 
[301001] = {heroId = 1010, id = 301001, name = 12266, src_id_icon = "ICON_Item_301001", src_id_pic = "evelyn_p2"}
, 
[301002] = {describe = 279886, heroId = 1010, id = 301002, name = 37194, src_id_icon = "ICON_Item_301002", src_id_pic = "evelyn_p3"}
, 
[301101] = {describe = 388609, heroId = 1011, id = 301101, name = 125847, src_id_icon = "ICON_Item_301101", src_id_pic = "camellia_p2"}
, 
[301102] = {describe = 311368, heroId = 1011, id = 301102, name = 140945, src_id_icon = "ICON_Item_301102", src_id_pic = "camellia_p3", theme = 3}
, 
[301201] = {describe = 401232, heroId = 1012, id = 301201, name = 162892, src_id_icon = "ICON_Item_301201", src_id_pic = "max_p2"}
, 
[301202] = {describe = 224525, heroId = 1012, id = 301202, name = 238731, src_id_icon = "ICON_Item_301202", src_id_pic = "max_p3", theme = 3}
, 
[301301] = {describe = 400242, heroId = 1013, id = 301301, name = 379484, src_id_icon = "ICON_Item_301301", src_id_pic = "betty_p2"}
, 
[301302] = {describe = 454363, heroId = 1013, id = 301302, name = 441338, src_id_icon = "ICON_Item_301302", src_id_pic = "betty_p3", theme = 3}
, 
[301501] = {describe = 407111, heroId = 1015, id = 301501, name = 449077, src_id_icon = "ICON_Item_301501", src_id_pic = "panakeia_p2"}
, 
[301502] = {describe = 249897, heroId = 1015, id = 301502, name = 279149, src_id_icon = "ICON_Item_301502", src_id_pic = "panakeia_p3", theme = 3}
, 
[301601] = {describe = 226040, heroId = 1016, id = 301601, name = 88049, src_id_icon = "ICON_Item_301601", src_id_pic = "banxsy_p2"}
, 
[301602] = {describe = 167177, heroId = 1016, id = 301602, name = 318063, src_id_icon = "ICON_Item_301602", src_id_pic = "banxsy_p3", theme = 3}
, 
[301701] = {describe = 497426, heroId = 1017, id = 301701, name = 323848, src_id_icon = "ICON_Item_301701", src_id_pic = "angela_p2"}
, 
[301801] = {describe = 149837, heroId = 1018, id = 301801, name = 52801, src_id_icon = "ICON_Item_301801", src_id_pic = "florence_p2"}
, 
[302001] = {describe = 67890, heroId = 1020, id = 302001, src_id_icon = "ICON_Item_302001", src_id_pic = "yanny_p2"}
, 
[302101] = {describe = 321953, heroId = 1021, id = 302101, name = 387268, src_id_icon = "ICON_Item_302101", src_id_pic = "groove_p2"}
, 
[302201] = {describe = 484401, heroId = 1022, id = 302201, name = 244133, src_id_icon = "ICON_Item_302201", src_id_pic = "aki_p2"}
, 
[302202] = {describe = 297585, heroId = 1022, id = 302202, name = 118386, src_id_icon = "ICON_Item_302202", src_id_pic = "aki_p3", theme = 3}
, 
[302301] = {describe = 52847, heroId = 1023, id = 302301, name = 13633, src_id_icon = "ICON_Item_302301", src_id_pic = "bonee_p2"}
, 
[302302] = {describe = 484889, heroId = 1023, id = 302302, name = 280997, src_id_icon = "ICON_Item_302302", src_id_pic = "bonee_p3", theme = 3}
, 
[302401] = {describe = 113381, heroId = 1024, id = 302401, name = 155070, src_id_icon = "ICON_Item_302401", src_id_pic = "earhart_p2"}
, 
[302402] = {describe = 403656, heroId = 1024, id = 302402, name = 13498, src_id_icon = "ICON_Item_302402", src_id_pic = "earhart_p3", theme = 3}
, 
[303101] = {describe = 493857, heroId = 1031, id = 303101, name = 409651, src_id_icon = "ICON_Item_303101", src_id_pic = "imhotep_p2"}
, 
[303401] = {describe = 361700, heroId = 1034, id = 303401, name = 313007, src_id_icon = "ICON_Item_303401"}
, 
[303402] = {describe = 287842, heroId = 1034, id = 303402, name = 265708, src_id_icon = "ICON_Item_303402", src_id_pic = "abigail_p3", theme = 3}
, 
[303501] = {describe = 504051, heroId = 1035, id = 303501, name = 470074, src_id_icon = "ICON_Item_303501", src_id_pic = "jessie_p2"}
, 
[303502] = {describe = 35452, heroId = 1035, id = 303502, name = 220370, src_id_icon = "ICON_Item_303502", src_id_pic = "jessie_p3", theme = 3}
, 
[303601] = {describe = 391797, heroId = 1036, id = 303601, name = 429431, src_id_icon = "ICON_Item_303601", src_id_pic = "lam_p2"}
, 
[303602] = {describe = 271252, heroId = 1036, id = 303602, name = 312774, src_id_icon = "ICON_Item_303602", src_id_pic = "lam_p3", theme = 3}
, 
[303701] = {describe = 473746, heroId = 1037, id = 303701, name = 471207, src_id_icon = "ICON_Item_303701", src_id_pic = "hubble_p2"}
, 
[303702] = {describe = 85487, heroId = 1037, id = 303702, name = 136627, src_id_icon = "ICON_Item_303702", src_id_pic = "hubble_p3", theme = 3}
, 
[303801] = {describe = 365282, heroId = 1038, id = 303801, name = 16387, src_id_icon = "ICON_Item_303801", src_id_pic = "sakuya_p2"}
, 
[303802] = {describe = 521210, heroId = 1038, id = 303802, name = 328201, src_id_icon = "ICON_Item_303802", src_id_pic = "sakuya_p3"}
}
local __default_values = {condition = 502, condition_para = __rt_1, describe = 102446, heroId = 1002, id = 300201, jumpId = 0, name = 111422, src_id_icon = "ICON_Item_300201", src_id_model = "", src_id_pic = "abigail_p2", theme = 2}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(skin) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(skin, {__index = __rawdata})
return skin

