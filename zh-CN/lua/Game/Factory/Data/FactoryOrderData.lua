local FactoryOrderData = class("FactoryOrderData")
local FactoryEnum = require("Game.Factory.FactoryEnum")
local factoryEnergyItemId = (ConfigData.game_config).factoryEnergyItemId
FactoryOrderData.CreateOrderData = function(orderCfg, isRoomUnlock)
  -- function num : 0_0 , upvalues : FactoryOrderData, _ENV, FactoryEnum
  local FactoryOrderData = (FactoryOrderData.New)()
  FactoryOrderData.orderCfg = orderCfg
  FactoryOrderData.orderRoomIndex = orderCfg.type
  FactoryOrderData.isUnlock = (CheckCondition.CheckLua)(orderCfg.pre_condition, orderCfg.pre_para1, orderCfg.pre_para2)
  FactoryOrderData.isRoomUnlock = isRoomUnlock
  FactoryOrderData.efficiencyEnhance = (PlayerDataCenter.playerBonus):GetFactoryEfficiency(orderCfg.id)
  FactoryOrderData.timeCost = (math.ceil)(orderCfg.time_cost * (1 - FactoryOrderData.efficiencyEnhance / 1000))
  if orderCfg.type == 1 then
    FactoryOrderData.orderType = (FactoryEnum.eOrderType).dig
  else
    FactoryOrderData.orderType = (FactoryEnum.eOrderType).product
  end
  return FactoryOrderData
end

FactoryOrderData.ctor = function(self)
  -- function num : 0_1
  self.orderCfg = nil
  self.orderType = nil
  self.orderRoomIndex = nil
  self.isUnlock = false
  self.isRoomUnlock = false
  self.efficiencyEnhance = nil
  self.timeCost = nil
end

FactoryOrderData.UpdateOrderData = function(self)
  -- function num : 0_2
  self:UpdateIsUnlcok()
  if self.isUnlock then
    self:UpdateEfficiencyEnhance()
  end
end

FactoryOrderData.UpdateEfficiencyEnhance = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.efficiencyEnhance = (PlayerDataCenter.playerBonus):GetFactoryEfficiency((self.orderCfg).id)
  if self.efficiencyEnhance == nil then
    return 
  end
  self.timeCost = (math.ceil)((self.orderCfg).time_cost * (1 - self.efficiencyEnhance / 1000))
end

FactoryOrderData.UpdateIsUnlcok = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.isUnlock = (CheckCondition.CheckLua)((self.orderCfg).pre_condition, (self.orderCfg).pre_para1, (self.orderCfg).pre_para2)
end

FactoryOrderData.UpdateIsRoomUnlock = function(self, bool)
  -- function num : 0_5
  self.isRoomUnlock = bool
end

FactoryOrderData.GetIsWhareHouseNotFull = function(self, curOrderNum)
  -- function num : 0_6 , upvalues : _ENV
  local curwarehouseNum = PlayerDataCenter:GetItemCount((self.orderCfg).outPutItemId, false)
  local warehouseCapacity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity((self.orderCfg).outPutItemId)
  do
    if warehouseCapacity == 0 then
      local itemCfg = (ConfigData.item)[(self.orderCfg).outPutItemId]
      if itemCfg == nil or itemCfg.holdlimit == nil then
        error("can\'t read itemCfg/itemCfg.holdlimit with id = " .. tostring((self.orderCfg).outPutItemId))
      else
        warehouseCapacity = itemCfg.holdlimit
      end
    end
    local warehouseNotFull = warehouseCapacity == 0 or (curOrderNum + 1) * (self.orderCfg).outPutItemNum <= warehouseCapacity - curwarehouseNum
    do return warehouseNotFull end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

FactoryOrderData.GetIsUnlock = function(self)
  -- function num : 0_7
  if self.isRoomUnlock then
    return self.isUnlock
  end
end

FactoryOrderData.GetTimeCost = function(self)
  -- function num : 0_8
  return self.timeCost
end

FactoryOrderData.GetOrderCfg = function(self)
  -- function num : 0_9
  return self.orderCfg
end

FactoryOrderData.GetOrderType = function(self)
  -- function num : 0_10
  return self.orderType
end

FactoryOrderData.GetOrderRoomIndex = function(self)
  -- function num : 0_11
  return self.orderRoomIndex
end

FactoryOrderData.GetCouldProdunc = function(self, factoryController)
  -- function num : 0_12 , upvalues : _ENV
  if not self:GetIsUnlock() then
    return false
  end
  return factoryController:CheckOrderResource(self, 1, {}, {}, (ConfigData.game_config).factoryTimeCostLimit)
end

FactoryOrderData.Delete = function(self)
  -- function num : 0_13
end

return FactoryOrderData

