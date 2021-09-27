local FactoryProcessingData = class("FactoryProcessingData")
local FactoryEnum = require("Game.Factory.FactoryEnum")
local FactoryHelper = require("Game.Factory.FactoryHelper")
FactoryProcessingData.ctor = function(self)
  -- function num : 0_0
  self.uid = nil
  self.id = nil
  self.lineId = nil
  self.num = nil
  self.startTm = nil
  self.endTm = nil
  self._orderCfg = nil
  self._outPutItemCfg = nil
end

FactoryProcessingData.CreateProcessOrderData = function(line, uid, processOrderMsg)
  -- function num : 0_1 , upvalues : FactoryProcessingData
  local data = (FactoryProcessingData.New)()
  data.uid = uid
  data.lineId = line
  data.id = processOrderMsg.id
  data.num = processOrderMsg.num
  data.startTm = processOrderMsg.startTm
  data.endTm = processOrderMsg.endTm
  data:__Preprocess()
  return data
end

FactoryProcessingData.__Preprocess = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self._orderCfg = (ConfigData.factory_order)[self.id]
  if self._orderCfg == nil then
    error("can\'t read factory_order with id:" .. tostring(self.id))
    return 
  end
  self._outPutItemCfg = (ConfigData.item)[(self._orderCfg).outPutItemId]
end

FactoryProcessingData.GetOutputItemIconName = function(self)
  -- function num : 0_3
  if self._outPutItemCfg == nil then
    return nil
  end
  return (self._outPutItemCfg).icon
end

FactoryProcessingData.GetIsFinish = function(self)
  -- function num : 0_4 , upvalues : _ENV
  do return self.endTm < PlayerDataCenter.timestamp end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FactoryProcessingData.GetProcessRate = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local passedTime = PlayerDataCenter.timestamp - self.startTm
  local totalTime = self.endTm - self.startTm
  return passedTime / totalTime
end

FactoryProcessingData.GetLeftProcessTime = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return self.endTm - PlayerDataCenter.timestamp
end

FactoryProcessingData.GetLeftProcessEnergy = function(self)
  -- function num : 0_7 , upvalues : FactoryHelper
  local time = self:GetLeftProcessTime()
  return (FactoryHelper.GetFactoryTime2EnergyCost)(time)
end

FactoryProcessingData.GetOutputItemProduceNum = function(self)
  -- function num : 0_8
  if self._orderCfg == nil then
    return 0
  end
  return ((self._orderCfg).outPutItemNum or 0) * (self.num or 0)
end

FactoryProcessingData.GetOutputItemCfg = function(self)
  -- function num : 0_9
  return self._outPutItemCfg
end

FactoryProcessingData.GetIndexAndUid = function(self)
  -- function num : 0_10
  return self.lineId, self.uid
end

FactoryProcessingData.Delete = function(self)
  -- function num : 0_11
end

return FactoryProcessingData

