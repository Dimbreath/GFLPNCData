local dorm_fnt_category = {
{}
, 
{icon = "Icon_2", id = 2, limit = 8, line = 9, name = 19152}
, 
{icon = "Icon_3", id = 3, line = 3, name = 93686}
, 
{icon = "Icon_4", id = 4, line = 2, name = 226507}
, 
{icon = "Icon_5", id = 5, limit = 4, line = 10, name = 402339}
, 
{icon = "Icon_6", id = 6, limit = 2, line = 4, name = 241441}
, 
{icon = "Icon_7", id = 7, limit = 4, line = 6, name = 349177}
, 
{icon = "Icon_8", id = 8, limit = 2, line = 5, name = 222154}
, 
{icon = "Icon_9", id = 9, limit = 2, line = 7, name = 82047}
, 
{icon = "Icon_10", id = 10, limit = 8, line = 8, name = 441936}
}
local __default_values = {icon = "Icon_1", id = 1, limit = 0, line = 1, name = 180239}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(dorm_fnt_category) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, 
dmFntCategoryIdList = {1, 4, 3, 6, 8, 7, 9, 10, 2, 5}
}
setmetatable(dorm_fnt_category, {__index = __rawdata})
return dorm_fnt_category

