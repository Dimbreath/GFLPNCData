local AllEffectorData = class("AllEffectorData")
local EffectorResourceData = require("Game.Effector.Data.EffectorResourceData")
local EffectorUtil = require("Game.Effector.EffectorUtil")
local AutoResourceGeneratorData = require("Game.Effector.Data.AutoResourceGeneratorData")
AllEffectorData.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.effectorResDataDic = {}
  self.AutoResourceGeneratorDic = {}
  self.OldItemDNumDic = {}
  self.m_OnARGItemChnage = BindCallback(self, self.OnARGItemChnage)
end

AllEffectorData.UpdateResourceData = function(self, rg)
  -- function num : 0_1 , upvalues : EffectorResourceData, _ENV
  local resData = (self.effectorResDataDic)[rg.uid]
  if resData == nil then
    resData = (EffectorResourceData.New)()
    resData:InitEffectorRes(rg)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.effectorResDataDic)[rg.uid] = resData
  else
    resData:UpdateEffectorRes(rg)
  end
  local functionId = resData.functionId
  if functionId == proto_csmsg_SystemFunctionID.SystemFunctionID_Building then
    self:UpdateBuildingResourceData(resData)
  end
end

AllEffectorData.UpdateBuildingResourceData = function(self, resData, remove)
  -- function num : 0_2 , upvalues : _ENV
  local buildingId = resData.logicId
  local buildingData = ((PlayerDataCenter.AllBuildingData).built)[buildingId]
  if buildingData == nil then
    error("Can\'t find buildingData, id = " .. tostring(buildingId))
    return 
  end
  local resDatas = buildingData.resDatas
  if resDatas == nil then
    resDatas = {}
    buildingData.resDatas = resDatas
  end
  if remove then
    resDatas[resData.itemId] = nil
  else
    resDatas[resData.itemId] = resData
  end
end

AllEffectorData.DeleteResourceData = function(self, uid)
  -- function num : 0_3 , upvalues : _ENV
  local resData = (self.effectorResDataDic)[uid]
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.effectorResDataDic)[uid] = nil
  local functionId = resData.functionId
  if functionId == proto_csmsg_SystemFunctionID.SystemFunctionID_Building then
    self:UpdateBuildingResourceData(resData, true)
  end
end

AllEffectorData.IsAutoGenerateResource = function(self, itemId)
  -- function num : 0_4 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    return false
  end
  do return itemCfg.type == eItemType.AutoGenerateResource and (self.AutoResourceGeneratorDic)[itemId] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AllEffectorData.UpdateAutoResourceGenerator = function(self, ARGBase)
  -- function num : 0_5 , upvalues : AutoResourceGeneratorData
  local ArgData = (self.AutoResourceGeneratorDic)[ARGBase.itemId]
  if ArgData == nil then
    ArgData = (AutoResourceGeneratorData.New)()
    ArgData:UpdateItem(ARGBase)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.AutoResourceGeneratorDic)[ARGBase.itemId] = ArgData
  else
    ArgData:UpdateItem(ARGBase)
  end
end

AllEffectorData.OnUpdateItemCeil = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for itemId,data in pairs(self.AutoResourceGeneratorDic) do
    data:UpdateItemCeil()
  end
end

AllEffectorData.OnUpdateItemGenerateSpeed = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for itemId,data in pairs(self.AutoResourceGeneratorDic) do
    data:UpdateItemSpeed()
  end
end

AllEffectorData.GetCurrentARGNum = function(self, itemId)
  -- function num : 0_8 , upvalues : _ENV
  if (self.AutoResourceGeneratorDic)[itemId] == nil then
    error("auto gen item don\'t have id=" .. tostring(itemId))
    return 0, 0
  end
  return ((self.AutoResourceGeneratorDic)[itemId]):GetCurrentNum()
end

AllEffectorData.GetCurrentARGCeiling = function(self, itemId)
  -- function num : 0_9 , upvalues : _ENV
  if (self.AutoResourceGeneratorDic)[itemId] == nil then
    error("auto gen item don\'t have id=" .. tostring(itemId))
    return 0
  end
  return ((self.AutoResourceGeneratorDic)[itemId]):GetARGCeiling()
end

AllEffectorData.GetCurrentARGSpeed = function(self, itemId, isBase)
  -- function num : 0_10 , upvalues : _ENV
  if (self.AutoResourceGeneratorDic)[itemId] == nil then
    error("auto gen item don\'t have id=" .. tostring(itemId))
    return 0
  end
  return ((self.AutoResourceGeneratorDic)[itemId]):GetARGGenSpeedPerSecond(isBase)
end

AllEffectorData.SetAccRacte = function(self, itemId, accRate)
  -- function num : 0_11 , upvalues : _ENV
  if (self.AutoResourceGeneratorDic)[itemId] == nil then
    error("auto gen item don\'t have id=" .. tostring(itemId))
    return 
  end
  ;
  ((self.AutoResourceGeneratorDic)[itemId]):SetAccRate(accRate)
end

AllEffectorData.StartTimer4ARGNum = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local minTime = math.maxinteger
  for itemId,data in pairs(self.AutoResourceGeneratorDic) do
    local num, remainSecond = data:GetCurrentNum()
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.OldItemDNumDic)[itemId] = num
    if remainSecond ~= 0 then
      minTime = (math.min)(minTime, remainSecond)
    end
  end
  TimerManager:StopTimer(self.ARGNumTimerId)
  if minTime == math.maxinteger then
    return 
  end
  if minTime < 1 then
    minTime = 1
  end
  self.ARGNumTimerId = TimerManager:StartTimer(minTime, self.m_OnARGItemChnage, nil, true, false, false)
end

AllEffectorData.OnARGItemChnage = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self.ARGNumTimerId = nil
  local changedItemNumDic = {}
  for itemId,data in pairs(self.AutoResourceGeneratorDic) do
    local num, remainSecond = data:GetCurrentNum()
    if num ~= (self.OldItemDNumDic)[itemId] then
      changedItemNumDic[itemId] = num
    end
  end
  MsgCenter:Broadcast(eMsgEventId.UpdateARGItem, changedItemNumDic)
  self:StartTimer4ARGNum()
end

return AllEffectorData

