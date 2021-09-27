local TimingProductData = class("TimingProductData")
local cs_MessageCommon = CS.MessageCommon
TimingProductData.ctor = function(self, msg)
  -- function num : 0_0
  self.id = msg.id
  self.moduleId = msg.moduleId
  self:UpdTimingProductData(msg)
end

TimingProductData.UpdTimingProductData = function(self, msg)
  -- function num : 0_1
  self.itemId = msg.itemId
  self.itemNum = msg.itemNum
  self.refreshTm = msg.refreshTm
  self.realNum = msg.realNum
end

TimingProductData.IsTmProductTimeUp = function(self, timestamp)
  -- function num : 0_2
  do return self.refreshTm <= timestamp end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TimingProductData.GetTmProductRefreshTm = function(self)
  -- function num : 0_3
  return self.refreshTm
end

TimingProductData.CanTmProductRes = function(self, withTips, fullWareHouseItemDic)
  -- function num : 0_4 , upvalues : _ENV, cs_MessageCommon
  local itemCfg = (ConfigData.item)[self.itemId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(self.itemId))
    return false
  end
  local capacity = itemCfg.holdlimit
  local playerResCount = PlayerDataCenter:GetItemCount(self.itemId)
  local fullWarehouse = capacity < playerResCount + self.realNum
  local name = (LanguageUtil.GetLocaleText)(itemCfg.name)
  if fullWarehouse then
    if withTips then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(name .. ConfigData:GetTipContent(TipContent.ItemInWarehouseFull), true)
    end
    if fullWareHouseItemDic ~= nil then
      fullWareHouseItemDic[name] = true
    end
  end
  do return not fullWarehouse end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return TimingProductData

