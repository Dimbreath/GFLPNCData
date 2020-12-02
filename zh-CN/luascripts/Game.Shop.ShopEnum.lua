-- params : ...
-- function num : 0 , upvalues : _ENV
local ShopEnum = {}
ShopEnum.eShopType = {Normal = 1, Random = 2, Resource = 3, Charcter = 4}
ShopEnum.ShopId = {[(ShopEnum.eShopType).Charcter] = 403}
ShopEnum.eLimitType = {None = 0, Day = 1, Week = 2, Month = 3, Eternal = 4}
ShopEnum.eQuickBuy = {
stamina = {shopId = 301, shelfId = 1, 
resourceIds = {1002, 1007}
}
, 
lottery = {shopId = 203, shelfId = 1}
}
return ShopEnum

