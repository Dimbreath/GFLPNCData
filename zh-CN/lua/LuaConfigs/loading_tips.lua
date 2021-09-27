local __rt_1 = {}
local loading_tips = {
[3] = {id = 3, text = 95193}
, 
[4] = {id = 4, text = 481068}
, 
[5] = {id = 5, text = 56503}
, 
[6] = {id = 6, text = 413589}
, 
[7] = {id = 7, text = 195815}
, 
[8] = {id = 8, text = 519767}
, 
[9] = {id = 9}
, 
[10] = {text = 200845}
, 
[11] = {id = 11, text = 112978}
, 
[12] = {id = 12, text = 25815}
, 
[13] = {id = 13, text = 263307}
, 
[14] = {id = 14, text = 9926}
, 
[15] = {id = 15, text = 379395}
, 
[16] = {id = 16, text = 98951}
, 
[17] = {id = 17, pic_path = "LoadingBG/LoadingImg_17", text = 458091, title = "42Lab"}
, 
[18] = {id = 18, pic_path = "LoadingBG/LoadingImg_18", text = 393802, title = 387183}
, 
[19] = {id = 19, pic_path = "LoadingBG/LoadingImg_19", text = 28627, title = 444397}
, 
[20] = {id = 20, pic_path = "LoadingBG/LoadingImg_20", text = 329470, title = 11829}
, 
[21] = {id = 21, pic_path = "LoadingBG/LoadingImg_21", text = 380974, title = 23549}
, 
[22] = {id = 22, text = 76367, title = 53092}
, 
[23] = {id = 23, pic_path = "LoadingBG/LoadingImg_23", text = 509278, title = 256780}
, 
[24] = {id = 24, pic_path = "LoadingBG/LoadingImg_24", text = 24596, title = 256780}
, 
[25] = {id = 25, pic_path = "LoadingBG/LoadingImg_25", text = 375588, title = 69887}
, 
[26] = {id = 26, pic_path = "LoadingBG/LoadingImg_26", text = 217597, title = 181587}
, 
[27] = {id = 27, pic_path = "LoadingBG/LoadingImg_27", text = 83938, title = 104709}
, 
[28] = {id = 28, text = 314424, title = 413800}
, 
[29] = {id = 29, text = 220765, title = 304585}
, 
[30] = {id = 30, pic_path = "LoadingBG/LoadingImg_18", text = 191748, title = 448601}
, 
[31] = {id = 31, pic_path = "LoadingBG/LoadingImg_31", text = 85387, title = 98834}
, 
[32] = {id = 32, pic_path = "LoadingBG/LoadingImg_32", text = 511294, title = 342588}
, 
[33] = {id = 33, pic_path = "LoadingBG/LoadingImg_33", text = 383751, title = 231791}
, 
[34] = {id = 34, pic_path = "LoadingBG/LoadingImg_34", text = 131721, title = 274558}
, 
[35] = {id = 35, text = 380652, title = 108362}
, 
[36] = {id = 36, pic_path = "LoadingBG/LoadingImg_17", text = 226245, title = 120297}
, 
[37] = {id = 37, text = 131378, title = 109700}
, 
[38] = {id = 38, pic_path = "LoadingBG/LoadingImg_38", text = 26014, title = 163183}
, 
[39] = {id = 39, pic_path = "LoadingBG/LoadingImg_39", text = 475938, title = 450463}
, 
[41] = {id = 41, pic_path = "LoadingBG/LoadingImg_41", text = 171407, title = 85574}
, 
[42] = {id = 42, text = 478269, title = 88019}
, 
[43] = {id = 43, text = 410026, title = 344062}
, 
[44] = {id = 44, text = 394537, title = 60812}
, 
[45] = {id = 45, text = 217559, title = 523996}
, 
[46] = {id = 46, text = 120222, title = 413426}
}
local __default_values = {id = 10, in_condition = __rt_1, in_para1 = __rt_1, in_para2 = __rt_1, out_condition = __rt_1, out_para1 = __rt_1, out_para2 = __rt_1, pic_path = "", system_id = 0, text = 102160, title = ""}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(loading_tips) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
systemLoadingTipsDic = {
[0] = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 41, 42, 43, 44, 45, 46}
}
}
setmetatable(loading_tips, {__index = __rawdata})
return loading_tips

