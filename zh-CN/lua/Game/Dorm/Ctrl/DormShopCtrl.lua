local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormShopCtrl = class("DormShopCtrl", DormCtrlBase)
local DormEnum = require("Game.Dorm.DormEnum")
DormShopCtrl.ctor = function(self, dormCtrl)
  -- function num : 0_0
end

DormShopCtrl.EnterDormShop = function(self)
  -- function num : 0_1 , upvalues : DormEnum, _ENV
  local shopId = 0
  local itemType = nil
  if (self.dormCtrl).state == (DormEnum.eDormState).House or (self.dormCtrl).state == (DormEnum.eDormState).HouseEdit then
    shopId = (ConfigData.game_config).DormRoomShopId
    itemType = eItemType.DormRoom
  else
    if (self.dormCtrl).state == (DormEnum.eDormState).Room or (self.dormCtrl).state == (DormEnum.eDormState).RoomEdit then
      shopId = (ConfigData.game_config).DormFntShopId
      itemType = eItemType.DormFurniture
    end
  end
  if shopId <= 0 then
    return 
  end
  ;
  (ControllerManager:GetController(ControllerTypeId.Shop, true)):ReqShopDetail(shopId, function(shopData)
    -- function num : 0_1_0 , upvalues : _ENV
    print("UIWindowTypeID.DormShop the prefab is Delete")
  end
)
end

DormShopCtrl.OnDelete = function(self)
  -- function num : 0_2
end

return DormShopCtrl

