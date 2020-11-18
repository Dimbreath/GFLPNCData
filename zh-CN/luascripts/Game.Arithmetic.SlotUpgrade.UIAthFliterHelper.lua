-- params : ...
-- function num : 0 , upvalues : _ENV
local eFliterKindType = {Area = 1, Quality = 2, MainAttr = 3}
local eFliterKindTypeName = {[eFliterKindType.Area] = "区域", [eFliterKindType.Quality] = "品质", [eFliterKindType.MainAttr] = "主属性"}
local eFliterKindTypeOptionName = {[eFliterKindType.Area] = "区域", [eFliterKindType.Quality] = "色品质", [eFliterKindType.MainAttr] = "主属性:"}
local eFliterKindColorName = {[eItemQualityType.Blue] = "蓝", [eItemQualityType.Orange] = "橙", [eItemQualityType.Purple] = "紫", [eItemQualityType.White] = "白", [eItemQualityType.Green] = "绿"}
local M = {eFliterKindType, eFliterKindTypeName, eFliterKindTypeOptionName, eFliterKindColorName}
return M

