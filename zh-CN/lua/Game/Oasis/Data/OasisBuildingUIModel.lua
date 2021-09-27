local OasisBuildingUIModel = class("OasisBuildingUIModel")
local BuildingData = require("Game.Oasis.Data.OasisBuildingData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
OasisBuildingUIModel.ctor = function(self, buildingData)
  -- function num : 0_0
  self:UpdateBuildingData(buildingData)
end

OasisBuildingUIModel.UpdateBuildingData = function(self, buildingData)
  -- function num : 0_1
  self.buildingData = buildingData
  self.buildingDataList = self:__handleBuildingData(buildingData)
end

OasisBuildingUIModel.__handleBuildingData = function(self, buildingData)
  -- function num : 0_2 , upvalues : _ENV, BuildingBelong, BuildingData
  local allOasisBuildingList = {}
  for id,data in pairs((self.buildingData).oasisBuilt) do
    (table.insert)(allOasisBuildingList, data)
  end
  for id,data in pairs((self.buildingData).unbuilt) do
    if data.belong == BuildingBelong.Oasis then
      local buildData = (BuildingData.New)()
      buildData:InitializeWithDynData(nil, data)
      ;
      (table.insert)(allOasisBuildingList, buildData)
    end
  end
  ;
  (table.sort)(allOasisBuildingList, function(a, b)
    -- function num : 0_2_0 , upvalues : _ENV
    local aUnlockLevel, bUnlockLevel = nil, nil
    local alevelCfg = (a.levelConfig)[1]
    local blevelCfg = (b.levelConfig)[1]
    for index,condition in ipairs(alevelCfg.pre_condition) do
      if condition == 4 and (alevelCfg.pre_para1)[index] == 1001 then
        aUnlockLevel = (alevelCfg.pre_para2)[index]
      end
    end
    for index,condition in ipairs(blevelCfg.pre_condition) do
      if condition == 4 and (blevelCfg.pre_para1)[index] == 1001 then
        bUnlockLevel = (blevelCfg.pre_para2)[index]
      end
    end
    do
      if a.id >= b.id then
        do return aUnlockLevel ~= bUnlockLevel and aUnlockLevel ~= nil and bUnlockLevel ~= nil end
        do return aUnlockLevel < bUnlockLevel end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
)
  return allOasisBuildingList
end

return OasisBuildingUIModel

