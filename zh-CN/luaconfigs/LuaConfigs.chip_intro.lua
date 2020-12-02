-- params : ...
-- function num : 0 , upvalues : _ENV
local chip_intro = {
[101] = {
[0] = {id = 101, intro = 153238}
}
, 
[102] = {
[0] = {id = 102, intro = 302841}
}
, 
[103] = {
[0] = {id = 103, intro = 355274}
}
, 
[104] = {
{arg = 1, intro = 98440}
, 
{arg = 2, intro = 501681}
}
, 
[105] = {
[0] = {id = 105, intro = 194280}
}
, 
[601] = {
[0] = {id = 601, intro = 475972}
}
, 
[602] = {
[0] = {id = 602}
}
, 
[603] = {
[0] = {id = 603, intro = 428916}
}
, 
[604] = {
{arg = 1, id = 604, intro = 421174}
, 
{arg = 2, id = 604, intro = 300127}
}
, 
[605] = {
[0] = {id = 605, intro = 329254}
}
}
local __default_values = {arg = 0, id = 104, intro = 133335}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(chip_intro) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base, 
influence_type = {[101] = 0, [102] = 1, [103] = 2, [104] = 0, [105] = 3, [601] = 0, [602] = 1, [603] = 2, [604] = 0, [605] = 3}
}
setmetatable(chip_intro, {__index = __rawdata})
return chip_intro

