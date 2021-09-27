local BuildingTypeData = class("BuildingTypeData")
local BuildingData = require("Game.Oasis.Data.OasisBuildingData")
local BuildingEnum = require("Game.Oasis.Data.BuildingEnum")
BuildingTypeData.CreateAllBuildTypeData = function()
  -- function num : 0_0 , upvalues : _ENV, BuildingTypeData
  local buildTypeDataList = {}
  for typeId,buildIdList in pairs((ConfigData.building).buildingTypeDic) do
    local typeData = (BuildingTypeData.New)(typeId, buildIdList)
    ;
    (table.insert)(buildTypeDataList, typeData)
  end
  return buildTypeDataList
end

BuildingTypeData.ctor = function(self, typeId, buildIdList)
  -- function num : 0_1
  self.typeId = typeId
  self.buildIdList = buildIdList
  self:UpdateBuildTypeDataState()
end

BuildingTypeData.GetBuildTypeNum = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local num = 0
  for k,buildId in ipairs(self.buildIdList) do
    if ((PlayerDataCenter.AllBuildingData).built)[buildId] ~= nil then
      num = num + 1
    end
  end
  local maxNum = #self.buildIdList
  return num, maxNum
end

BuildingTypeData.GetNextUnlockBuildData = function(self)
  -- function num : 0_3 , upvalues : _ENV, BuildingData
  for k,buildId in ipairs(self.buildIdList) do
    local buildData = ((PlayerDataCenter.AllBuildingData).built)[buildId]
    if buildData == nil then
      local dynData = ((PlayerDataCenter.AllBuildingData).unbuilt)[buildId]
      buildData = (BuildingData.New)()
      buildData:InitializeWithDynData(nil, dynData)
      return buildData
    end
  end
  return ((PlayerDataCenter.AllBuildingData).built)[(self.buildIdList)[1]]
end

BuildingTypeData.UpdateBuildTypeDataState = function(self)
  -- function num : 0_4 , upvalues : BuildingEnum, _ENV
  local curNum, maxNum = self:GetBuildTypeNum()
  local buildingData = self:GetNextUnlockBuildData()
  if buildingData.isBuild then
    if curNum == maxNum then
      self.buildTypeState = (BuildingEnum.BuildingTypeState).MaxNum
    else
      error("error BuildingTypeState state")
    end
  else
    if (buildingData.dynData):Unlock() then
      self.buildTypeState = (BuildingEnum.BuildingTypeState).CanBuild
    else
      if curNum == 0 then
        self.buildTypeState = (BuildingEnum.BuildingTypeState).Lock
      else
        self.buildTypeState = (BuildingEnum.BuildingTypeState).MoreNumLock
      end
    end
  end
  return self.buildTypeState
end

BuildingTypeData.GetBuildTypeState = function(self)
  -- function num : 0_5
  return self.buildTypeState
end

return BuildingTypeData

