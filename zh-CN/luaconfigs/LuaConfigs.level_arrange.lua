-- params : ...
-- function num : 0 , upvalues : _ENV
local level_arrange = {
{
{}
, 
{id = 2, 
pos = {67, -464}
}
, 
{id = 3, 
pos = {-368, -703}
}
, 
{id = 4, 
pos = {90, -1023}
}
, 
{id = 5, 
pos = {-160, -1439}
}
, 
{id = 6, 
pos = {140, -1639}
}
}
, 
{
{
pos = {192, -140}
, typeId = 2, vertical = false}
, 
{id = 2, 
pos = {464, 67}
, typeId = 2, vertical = false}
, 
{id = 3, 
pos = {703, -368}
, typeId = 2, vertical = false}
, 
{id = 4, 
pos = {1023, 90}
, typeId = 2, vertical = false}
, 
{id = 5, 
pos = {1439, -160}
, typeId = 2, vertical = false}
, 
{id = 6, 
pos = {1639, 140}
, typeId = 2, vertical = false}
}
, 
{
{
pos = {67, -192}
, typeId = 3}
, 
{id = 2, 
pos = {-140, -464}
, typeId = 3}
, 
{id = 3, 
pos = {90, -703}
, typeId = 3}
, 
{id = 4, 
pos = {-368, -1023}
, typeId = 3}
, 
{id = 5, 
pos = {140, -1439}
, typeId = 3}
, 
{id = 6, 
pos = {-160, -1639}
, typeId = 3}
}
}
local __default_values = {id = 1, 
pos = {-140, -192}
, typeId = 1, vertical = true}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(level_arrange) do
  for k1,v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(level_arrange, {__index = __rawdata})
return level_arrange

-- params : ...
-- function num : 0 , upvalues : _ENV
local level_arrange = {
    {
        {}, {id = 2, pos = {67, -464}}, {id = 3, pos = {-368, -703}},
        {id = 4, pos = {90, -1023}}, {id = 5, pos = {-160, -1439}},
        {id = 6, pos = {140, -1639}}
    }, {
        {pos = {192, -140}, typeId = 2, vertical = false},
        {id = 2, pos = {464, 67}, typeId = 2, vertical = false},
        {id = 3, pos = {703, -368}, typeId = 2, vertical = false},
        {id = 4, pos = {1023, 90}, typeId = 2, vertical = false},
        {id = 5, pos = {1439, -160}, typeId = 2, vertical = false},
        {id = 6, pos = {1639, 140}, typeId = 2, vertical = false}
    }, {
        {pos = {67, -192}, typeId = 3},
        {id = 2, pos = {-140, -464}, typeId = 3},
        {id = 3, pos = {90, -703}, typeId = 3},
        {id = 4, pos = {-368, -1023}, typeId = 3},
        {id = 5, pos = {140, -1439}, typeId = 3},
        {id = 6, pos = {-160, -1639}, typeId = 3}
    }
}
local __default_values = {
    id = 1,
    pos = {-140, -192},
    typeId = 1,
    vertical = true
}
local base = {
    __index = __default_values,
    __newindex = function()
        -- function num : 0_0 , upvalues : _ENV
        error("Attempt to modify read-only table")
    end
}
for k, v in pairs(level_arrange) do
    for k1, v1 in pairs(v) do setmetatable(v1, base) end
end
local __rawdata = {__basemetatable = base}
setmetatable(level_arrange, {__index = __rawdata})
return level_arrange

