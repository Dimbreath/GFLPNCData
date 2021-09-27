local lottery_preview = {
[1008] = {}
, 
[1010] = {hero_up_id = 1010, previewPic = "Lottery/PreviewPicture/PrePic_1010"}
, 
[1016] = {hero_up_id = 1016, previewPic = "Lottery/PreviewPicture/PrePic_1016"}
, 
[1018] = {hero_up_id = 1018, previewPic = "Lottery/PreviewPicture/PrePic_1018"}
, 
[1022] = {hero_up_id = 1022, previewPic = "Lottery/PreviewPicture/PrePic_1022"}
, 
[1025] = {hero_up_id = 1025, previewPic = "Lottery/PreviewPicture/PrePic_1025"}
, 
[1026] = {hero_up_id = 1026, previewPic = "Lottery/PreviewPicture/PrePic_1026"}
, 
[1028] = {hero_up_id = 1028, previewPic = "Lottery/PreviewPicture/PrePic_1028"}
, 
[1037] = {hero_up_id = 1037, previewPic = "Lottery/PreviewPicture/PrePic_1037"}
, 
[1039] = {hero_up_id = 1039, previewPic = "Lottery/PreviewPicture/PrePic_1039"}
}
local __default_values = {hero_up_id = 1008, previewPic = "Lottery/PreviewPicture/PrePic_1008"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(lottery_preview) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(lottery_preview, {__index = __rawdata})
return lottery_preview

