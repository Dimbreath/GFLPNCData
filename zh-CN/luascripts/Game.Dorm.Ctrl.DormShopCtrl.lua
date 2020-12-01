-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormShopCtrl = class("DormShopCtrl", DormCtrlBase)
local eDormState = require("Game.Dorm.Enum.eDormState")
DormShopCtrl.ctor = function(self, dormCtrl)
  -- function num : 0_0
end

DormShopCtrl.EnterDormShop = function(self)
  -- function num : 0_1 , upvalues : eDormState, _ENV
  local shopId = 0
  local itemType = nil
  if (self.dormCtrl).state == eDormState.House or (self.dormCtrl).state == eDormState.HouseEdit then
    shopId = (ConfigData.game_config).DormRoomShopId
    itemType = eItemType.DormRoom
  else
    if (self.dormCtrl).state == eDormState.Room or (self.dormCtrl).state == eDormState.RoomEdit then
      shopId = (ConfigData.game_config).DormFntShopId
      itemType = eItemType.DormFurniture
    end
  end
  if shopId <= 0 then
    return 
  end
  ;
  (ControllerManager:GetController(ControllerTypeId.Shop, true)):ReqShopDetail(shopId, function(shopData)
    -- function num : 0_1_0 , upvalues : _ENV, itemType
    UIManager:ShowWindowAsync(UIWindowTypeID.DormShop, function(window)
      -- function num : 0_1_0_0 , upvalues : itemType, shopData
      if window == nil then
        return 
      end
      window:InitDormShop(itemType, shopData)
    end
)
  end
)
end

DormShopCtrl.OnDelete = function(self)
  -- function num : 0_2
end

return DormShopCtrl

-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormShopCtrl = class("DormShopCtrl", DormCtrlBase)
local eDormState = require("Game.Dorm.Enum.eDormState")
DormShopCtrl.ctor = function(self, dormCtrl)
    -- function num : 0_0
end

DormShopCtrl.EnterDormShop = function(self)
    -- function num : 0_1 , upvalues : eDormState, _ENV
    local shopId = 0
    local itemType = nil
    if (self.dormCtrl).state == eDormState.House or (self.dormCtrl).state ==
        eDormState.HouseEdit then
        shopId = (ConfigData.game_config).DormRoomShopId
        itemType = eItemType.DormRoom
    else
        if (self.dormCtrl).state == eDormState.Room or (self.dormCtrl).state ==
            eDormState.RoomEdit then
            shopId = (ConfigData.game_config).DormFntShopId
            itemType = eItemType.DormFurniture
        end
    end
    if shopId <= 0 then return end
    (ControllerManager:GetController(ControllerTypeId.Shop, true)):ReqShopDetail(
        shopId, function(shopData)
            -- function num : 0_1_0 , upvalues : _ENV, itemType
            UIManager:ShowWindowAsync(UIWindowTypeID.DormShop, function(window)
                -- function num : 0_1_0_0 , upvalues : itemType, shopData
                if window == nil then return end
                window:InitDormShop(itemType, shopData)
            end)
        end)
end

DormShopCtrl.OnDelete = function(self)
    -- function num : 0_2
end

return DormShopCtrl

