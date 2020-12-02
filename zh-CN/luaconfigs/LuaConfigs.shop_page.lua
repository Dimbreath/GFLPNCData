-- params : ...
-- function num : 0 , upvalues : _ENV
local shop_page = {
{page = 332125}
, 
{id = 2, page = 173057}
, 
{id = 3, page = 188719}
, 
{id = 4, page = 88019}
, 
{id = 5, page = 344062}
; 
[401] = {id = 401, page = 387183}
, 
[402] = {id = 402}
, 
[403] = {id = 403, page = 28609}
, 
[404] = {id = 404, page = 11829}
, 
[405] = {id = 405, page = 444397}
}
local __default_values = {id = 1, page = "42LAB"}
local base = {__index = __default_values, __newindex = function()
  -- function num : 0_0 , upvalues : _ENV
  error("Attempt to modify read-only table")
end
}
for k,v in pairs(shop_page) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(shop_page, {__index = __rawdata})
return shop_page

