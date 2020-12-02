-- params : ...
-- function num : 0 , upvalues : _ENV
local FactoryEnum = {}
FactoryEnum.eRoomType = {normal = 1, dig = 2, locked = 3}
FactoryEnum.eOrderType = {dig = 1, produce = 2}
FactoryEnum.eCannotAddReason = {energyInsufficeient = 1, matInsufficeient = 2, warehouseFull = 3}
return FactoryEnum

