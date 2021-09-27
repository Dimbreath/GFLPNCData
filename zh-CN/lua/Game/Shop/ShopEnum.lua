local ShopEnum = {}
ShopEnum.eShopType = {Normal = 1, Random = 2, Resource = 3, Charcter = 4, MonthCard = 5, Recommend = 6, Skin = 7, Recharge = 8, PayGift = 9, ResourceRefresh = 10}
ShopEnum.ShopId = {dormFnt = 101, recomme = 601, hero = 403, fluent = 204, recharge = 801, weekly = 1002, supportShop = 1003, DailyDungeonShop = 1004}
ShopEnum.eLimitType = {None = 0, Day = 1, Week = 2, Month = 3, Eternal = 4, Subscription = 801}
ShopEnum.eQuickBuy = {
stamina = {shopId = 301, shelfId = 1, 
resourceIds = {1001, 1002, 1007}
}
, 
lottery = {shopId = 203, shelfId = 1}
, 
factoryEnergy = {shopId = 301, shelfId = 2, 
resourceIds = {1001, 1002, (ConfigData.game_config).factoryEnergyItemId}
}
, 
dormCoin = {shopId = 301, shelfId = 3, 
resourceIds = {1001, 1002, ConstGlobalItem.DormCoin}
}
, 
skinTicket = {shopId = 203, shelfId = 6, 
resourceIds = {ConstGlobalItem.PaidItem, ConstGlobalItem.SkinTicket}
}
}
ShopEnum.eRecommeStyle = {SingleModel = 1, MultiModel = 2}
ShopEnum.eRecommePicType = {Banner = 1, Middle = 2, Small = 3, Single = 99}
ShopEnum.ePageMarkType = {MonthCard = 1}
ShopEnum.ePayGiftTag = {Discount = 1}
return ShopEnum

