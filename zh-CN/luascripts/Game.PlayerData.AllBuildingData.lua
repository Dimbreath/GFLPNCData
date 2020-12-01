-- params : ...
-- function num : 0 , upvalues : _ENV
local AllBuildingData = class("AllBuildingData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local BuildingDynData = require("Game.Oasis.Data.OasisBuildingDynData")
AllBuildingData.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, BuildingDynData
  self.built = {}
  self.builtSort = {}
  self.unbuilt = {}
  self.unbuiltSort = {}
  self.oasisBuilt = {}
  self.sectorBuilt = {}
  for _,v in ipairs((ConfigData.building).id_sort_list) do
    local stcData = (ConfigData.building)[v]
    local data = (BuildingDynData.New)()
    data:Initialize(stcData)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.unbuilt)[data.id] = data
    ;
    (table.insert)(self.unbuiltSort, data)
  end
  ;
  (table.sort)(self.unbuiltSort, function(a, b)
    -- function num : 0_0_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

AllBuildingData.UpdateData = function(self)
  -- function num : 0_1
  self:UpdateBuilt()
end

AllBuildingData.UpdateBuilt = function(self)
  -- function num : 0_2 , upvalues : _ENV, BuildingBelong
  self.sectorBuilt = {}
  self.oasisBuilt = {}
  for k,v in pairs(self.built) do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

    if v.belong == BuildingBelong.Sector then
      (self.sectorBuilt)[v.id] = v
    else
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

      if v.belong == BuildingBelong.Oasis then
        (self.oasisBuilt)[v.id] = v
      end
    end
  end
end

AllBuildingData.FullBuildQue = function(self, buildingBelong)
  -- function num : 0_3 , upvalues : BuildingBelong, _ENV
  local inQueCount = 0
  if buildingBelong == BuildingBelong.Oasis then
    for k,v in pairs(self.oasisBuilt) do
      if v.state ~= proto_object_BuildingState.BuildingStateNormal then
        inQueCount = inQueCount + 1
        if (PlayerDataCenter.playerBonus):GetBuildQueueCount(eBuildQueueType.Oasis) <= inQueCount then
          return true
        end
      end
    end
  else
    do
      if buildingBelong == BuildingBelong.Sector then
        for k,v in pairs(self.sectorBuilt) do
          if v.state ~= proto_object_BuildingState.BuildingStateNormal then
            inQueCount = inQueCount + 1
            if (PlayerDataCenter.playerBonus):GetBuildQueueCount(eBuildQueueType.Sector) <= inQueCount then
              return true
            end
          end
        end
      end
      do
        return false
      end
    end
  end
end

AllBuildingData.FullOasisBuildQue = function(self)
  -- function num : 0_4 , upvalues : BuildingBelong
  return self:FullBuildQue(BuildingBelong.Oasis)
end

AllBuildingData.FullSectorBuildQue = function(self)
  -- function num : 0_5 , upvalues : BuildingBelong
  return self:FullBuildQue(BuildingBelong.Sector)
end

AllBuildingData.GetResOutputEfficiency = function(self, id)
  -- function num : 0_6 , upvalues : _ENV
  local value = (PlayerDataCenter.playerBonus):GetResOutputEfficiency(id)
  local value0 = (PlayerDataCenter.playerBonus):GetResOutputEfficiency(0)
  value = value + value0
  return value
end

AllBuildingData.GetBuiltDataById = function(self, buildId)
  -- function num : 0_7
  local bulidData = (self.built)[buildId]
  if bulidData == nil then
    return nil
  end
  return bulidData:GetResDatas()
end

AllBuildingData.GetOasisBuiltRate = function(self)
  -- function num : 0_8 , upvalues : _ENV, BuildingBelong
  local totalLevel = 0
  local totalBuiltLevel = 0
  for _,value in pairs(self.oasisBuilt) do
    if value.belong == BuildingBelong.Oasis then
      totalLevel = totalLevel + value.maxLevel
    end
  end
  for _,value in pairs(self.oasisBuilt) do
    totalLevel = totalLevel + value.maxLevel
    totalBuiltLevel = totalBuiltLevel + value.level
  end
  return (totalBuiltLevel) / (totalLevel)
end

return AllBuildingData

-- params : ...
-- function num : 0 , upvalues : _ENV
local AllBuildingData = class("AllBuildingData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local BuildingDynData = require("Game.Oasis.Data.OasisBuildingDynData")
AllBuildingData.ctor = function(self)
    -- function num : 0_0 , upvalues : _ENV, BuildingDynData
    self.built = {}
    self.builtSort = {}
    self.unbuilt = {}
    self.unbuiltSort = {}
    self.oasisBuilt = {}
    self.sectorBuilt = {}
    for _, v in ipairs((ConfigData.building).id_sort_list) do
        local stcData = (ConfigData.building)[v]
        local data = (BuildingDynData.New)()
        data:Initialize(stcData) -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'
        ;
        (self.unbuilt)[data.id] = data;
        (table.insert)(self.unbuiltSort, data)
    end
    (table.sort)(self.unbuiltSort, function(a, b)
        -- function num : 0_0_0
        do return a.id < b.id end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
end

AllBuildingData.UpdateData = function(self)
    -- function num : 0_1
    self:UpdateBuilt()
end

AllBuildingData.UpdateBuilt = function(self)
    -- function num : 0_2 , upvalues : _ENV, BuildingBelong
    self.sectorBuilt = {}
    self.oasisBuilt = {}
    for k, v in pairs(self.built) do
        -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

        if v.belong == BuildingBelong.Sector then
            (self.sectorBuilt)[v.id] = v
        else
            -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

            if v.belong == BuildingBelong.Oasis then
                (self.oasisBuilt)[v.id] = v
            end
        end
    end
end

AllBuildingData.FullBuildQue = function(self, buildingBelong)
    -- function num : 0_3 , upvalues : BuildingBelong, _ENV
    local inQueCount = 0
    if buildingBelong == BuildingBelong.Oasis then
        for k, v in pairs(self.oasisBuilt) do
            if v.state ~= proto_object_BuildingState.BuildingStateNormal then
                inQueCount = inQueCount + 1
                if (PlayerDataCenter.playerBonus):GetBuildQueueCount(
                    eBuildQueueType.Oasis) <= inQueCount then
                    return true
                end
            end
        end
    else
        do
            if buildingBelong == BuildingBelong.Sector then
                for k, v in pairs(self.sectorBuilt) do
                    if v.state ~= proto_object_BuildingState.BuildingStateNormal then
                        inQueCount = inQueCount + 1
                        if (PlayerDataCenter.playerBonus):GetBuildQueueCount(
                            eBuildQueueType.Sector) <= inQueCount then
                            return true
                        end
                    end
                end
            end
            do return false end
        end
    end
end

AllBuildingData.FullOasisBuildQue = function(self)
    -- function num : 0_4 , upvalues : BuildingBelong
    return self:FullBuildQue(BuildingBelong.Oasis)
end

AllBuildingData.FullSectorBuildQue = function(self)
    -- function num : 0_5 , upvalues : BuildingBelong
    return self:FullBuildQue(BuildingBelong.Sector)
end

AllBuildingData.GetResOutputEfficiency =
    function(self, id)
        -- function num : 0_6 , upvalues : _ENV
        local value = (PlayerDataCenter.playerBonus):GetResOutputEfficiency(id)
        local value0 = (PlayerDataCenter.playerBonus):GetResOutputEfficiency(0)
        value = value + value0
        return value
    end

AllBuildingData.GetBuiltDataById = function(self, buildId)
    -- function num : 0_7
    local bulidData = (self.built)[buildId]
    if bulidData == nil then return nil end
    return bulidData:GetResDatas()
end

AllBuildingData.GetOasisBuiltRate = function(self)
    -- function num : 0_8 , upvalues : _ENV, BuildingBelong
    local totalLevel = 0
    local totalBuiltLevel = 0
    for _, value in pairs(self.oasisBuilt) do
        if value.belong == BuildingBelong.Oasis then
            totalLevel = totalLevel + value.maxLevel
        end
    end
    for _, value in pairs(self.oasisBuilt) do
        totalLevel = totalLevel + value.maxLevel
        totalBuiltLevel = totalBuiltLevel + value.level
    end
    return (totalBuiltLevel) / (totalLevel)
end

return AllBuildingData

