-- params : ...
-- function num : 0 , upvalues : _ENV
local FactoryEnum = {}
FactoryEnum.eRoomType = {normal = 2, dig = 1, present = 3, locked = -1, notOpen = -2}
FactoryEnum.eOrderType = {dig = 1, product = 2}
FactoryEnum.eOrderType2RoomType = {[(FactoryEnum.eOrderType).dig] = (FactoryEnum.eRoomType).dig, [(FactoryEnum.eOrderType).product] = (FactoryEnum.eRoomType).normal}
FactoryEnum.eCannotAddReason = {energyInsufficeient = 1, matInsufficeient = 2, warehouseFull = 3}
return FactoryEnum

