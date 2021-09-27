local AllTimingProduct = class("AllTimingProduct")
local TimingProductData = require("Game.PlayerData.TimingProduct.TimingProductData")
AllTimingProduct.ctor = function(self)
  -- function num : 0_0
  self.allTimingProduct = {}
  self.allTmProductItemIdMap = {}
  self._refreshEventDic = {}
end

AllTimingProduct.TimingProductKeyConvert = function(k)
  -- function num : 0_1 , upvalues : _ENV
  return k >> 32, k & CommonUtil.UInt32Max
end

AllTimingProduct.InitAllTimingProduct = function(self, timingProductBrief)
  -- function num : 0_2 , upvalues : _ENV
  for itemId,_ in pairs(timingProductBrief.itemIdMap) do
    self:_NewTmProductItemId(itemId, timingProductBrief.moduleId)
  end
  for k,v in pairs(timingProductBrief.data) do
    self:_NewTmProductData(v, timingProductBrief.moduleId)
  end
  self:_UpdDormResOutputRedDot()
end

AllTimingProduct._NewTmProductItemId = function(self, itemId, moduleId)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if not (self.allTmProductItemIdMap)[moduleId] then
    (self.allTmProductItemIdMap)[moduleId] = {}
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.allTmProductItemIdMap)[moduleId])[itemId] = true
  end
end

AllTimingProduct._TryAddTimeUnlock = function(self, tmProductData, isNew)
  -- function num : 0_4 , upvalues : _ENV
  local moduleId = tmProductData.moduleId
  local refreshTm = tmProductData:GetTmProductRefreshTm()
  local curTimestamp = PlayerDataCenter.timestamp
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

  if isNew or curTimestamp < refreshTm then
    if not (self._refreshEventDic)[moduleId] then
      (self._refreshEventDic)[moduleId] = BindCallback(self, self._OnRefreshTimeUp, moduleId)
      local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
      timePassCtrl:AddEventTimer(refreshTm, (self._refreshEventDic)[moduleId])
    end
  end
end

AllTimingProduct._NewTmProductData = function(self, timingProduct, moduleId)
  -- function num : 0_5 , upvalues : TimingProductData
  local moduleId = timingProduct.moduleId
  local tmProductData = (TimingProductData.New)(timingProduct)
  self:_NewTmProductItemId(timingProduct.itemId, moduleId)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  if not (self.allTimingProduct)[moduleId] then
    (self.allTimingProduct)[moduleId] = {}
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.allTimingProduct)[moduleId])[timingProduct.id] = tmProductData
    self:_TryAddTimeUnlock(tmProductData, true)
    return tmProductData
  end
end

AllTimingProduct.UpdAllTimingProduct = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, AllTimingProduct
  for k,v in pairs(msg.delete) do
    local moduleId, specifyId = (AllTimingProduct.TimingProductKeyConvert)(k)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R9 in 'UnsetPending'

    if (self.allTimingProduct)[moduleId] ~= nil and ((self.allTimingProduct)[moduleId])[specifyId] ~= nil then
      ((self.allTimingProduct)[moduleId])[specifyId] = nil
    end
  end
  for k,v in pairs(msg.update) do
    if v.realNum ~= nil and v.realNum ~= 0 then
      local moduleId, specifyId = (AllTimingProduct.TimingProductKeyConvert)(k)
      if (self.allTimingProduct)[moduleId] == nil or ((self.allTimingProduct)[moduleId])[specifyId] == nil then
        self:_NewTmProductData(v, moduleId)
      else
        local tmProductData = ((self.allTimingProduct)[moduleId])[specifyId]
        tmProductData:UpdTimingProductData(v)
        self:_NewTmProductItemId(v.itemId, moduleId)
        self:_TryAddTimeUnlock(tmProductData)
      end
    end
  end
  self:_UpdDormResOutputRedDot()
end

AllTimingProduct.GetTimingProductData = function(self, moduleId)
  -- function num : 0_7 , upvalues : _ENV
  if not (self.allTimingProduct)[moduleId] then
    return table.emptytable
  end
end

AllTimingProduct.GetTimingProductDataGroupItemId = function(self, moduleId)
  -- function num : 0_8 , upvalues : _ENV
  local tmProductDic = self:GetTimingProductData(moduleId)
  local curTimestamp = PlayerDataCenter.timestamp
  local tmProductGroupDic = {}
  for k,tmProductData in pairs(tmProductDic) do
    if tmProductData:IsTmProductTimeUp(curTimestamp) then
      if not tmProductGroupDic[tmProductData.itemId] then
        local groupDic = {}
      end
      if tmProductGroupDic[tmProductData.itemId] == nil then
        tmProductGroupDic[tmProductData.itemId] = groupDic
      end
      groupDic[k] = tmProductData
    end
  end
  return tmProductGroupDic
end

AllTimingProduct.GetTmProductItemIdList = function(self, moduleId)
  -- function num : 0_9 , upvalues : _ENV
  local list = {}
  if not (self.allTmProductItemIdMap)[moduleId] then
    local dic = table.emptytable
  end
  for itemId,v in pairs(dic) do
    (table.insert)(list, itemId)
  end
  return list
end

AllTimingProduct._OnRefreshTimeUp = function(self, moduleId)
  -- function num : 0_10 , upvalues : _ENV
  MsgCenter:Broadcast(eMsgEventId.TimingProductRefresh, moduleId)
end

AllTimingProduct.CanPickTimingProduct = function(self, moduleId)
  -- function num : 0_11 , upvalues : _ENV
  local curTimestamp = PlayerDataCenter.timestamp
  local tmProductDataDic = self:GetTimingProductData(moduleId)
  for k,v in pairs(tmProductDataDic) do
    if v:IsTmProductTimeUp(curTimestamp) then
      return true
    end
  end
  return false
end

AllTimingProduct._UpdDormResOutputRedDot = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local ok, comfortNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormResOutput)
  if self:CanPickTimingProduct(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm) then
    comfortNode:SetRedDotCount(1)
  else
    comfortNode:SetRedDotCount(0)
  end
end

return AllTimingProduct

