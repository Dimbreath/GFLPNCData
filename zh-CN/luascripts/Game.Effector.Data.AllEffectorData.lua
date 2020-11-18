-- params : ...
-- function num : 0 , upvalues : _ENV
local AllEffectorData = class("AllEffectorData")
local EffectorResourceData = require("Game.Effector.Data.EffectorResourceData")
local EffectorUtil = require("Game.Effector.EffectorUtil")
AllEffectorData.ctor = function(self)
  -- function num : 0_0
  self.effectorResDataDic = {}
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

return AllEffectorData

