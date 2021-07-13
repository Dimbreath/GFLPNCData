-- params : ...
-- function num : 0 , upvalues : _ENV
local AllBuildingData = class("AllBuildingData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local BuildingDynData = require("Game.Oasis.Data.OasisBuildingDynData")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
AllBuildingData.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, BuildingDynData, BuildingBelong
  self.built = {}
  self.builtSort = {}
  self.unbuilt = {}
  self.unbuiltSort = {}
  self.oasisBuilt = {}
  self.sectorBuilt = {}
  self.oasisAreaDic = {}
  self.oasisTotalLevel = 0
  for _,v in ipairs((ConfigData.building).id_sort_list) do
    local stcData = (ConfigData.building)[v]
    local data = (BuildingDynData.New)()
    data:Initialize(stcData)
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.unbuilt)[data.id] = data
    ;
    (table.insert)(self.unbuiltSort, data)
    if data.belong == BuildingBelong.Oasis then
      self.oasisTotalLevel = self.oasisTotalLevel + data.maxLevel
    end
  end
  ;
  (table.sort)(self.unbuiltSort, function(a, b)
    -- function num : 0_0_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

AllBuildingData.InitOasisAreaData = function(self, areaData)
  -- function num : 0_1 , upvalues : _ENV, NoticeData, JumpManager
  for areaId,areaCfg in ipairs(ConfigData.oasis_area) do
    do
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R7 in 'UnsetPending'

      (self.oasisAreaDic)[areaId] = areaData[areaId] ~= nil
      if areaData[areaId] == nil then
        for index,pre_conditionId in ipairs(areaCfg.pre_condition) do
          local pre_para1 = (areaCfg.pre_para1)[index]
          local pre_para2 = (areaCfg.pre_para2)[index]
          NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function()
    -- function num : 0_1_0 , upvalues : _ENV, areaCfg, NoticeData, JumpManager, areaId
    if (CheckCondition.CheckLua)(areaCfg.pre_condition, areaCfg.pre_para1, areaCfg.pre_para2) then
      NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).OasisAreaUnlock, {jumpType = (JumpManager.eJumpTarget).Oasis, argList = nil}, {" " .. tostring(areaCfg.id) .. " "}, {areaId = areaId}))
      return true
    end
  end
)
        end
      end
    end
  end
  self._isInited = true
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

AllBuildingData.IsBuildingDataInited = function(self)
  -- function num : 0_2
  return self._isInited
end

AllBuildingData.UpdateOasisAreaData = function(self, areaId, unlock)
  -- function num : 0_3 , upvalues : _ENV
  if (self.oasisAreaDic)[areaId] == nil then
    error("Cant get oasisArea, areaId = " .. tostring(areaId))
    return 
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.oasisAreaDic)[areaId] = unlock
end

AllBuildingData.OsisAreaUnlock = function(self, areaId)
  -- function num : 0_4
  return (self.oasisAreaDic)[areaId]
end

AllBuildingData.UpdateData = function(self)
  -- function num : 0_5
  self:UpdateBuilt()
end

AllBuildingData.UpdateBuilt = function(self)
  -- function num : 0_6 , upvalues : _ENV, BuildingBelong
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
  -- function num : 0_7 , upvalues : BuildingBelong, _ENV
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
  -- function num : 0_8 , upvalues : BuildingBelong
  return self:FullBuildQue(BuildingBelong.Oasis)
end

AllBuildingData.FullSectorBuildQue = function(self)
  -- function num : 0_9 , upvalues : BuildingBelong
  return self:FullBuildQue(BuildingBelong.Sector)
end

AllBuildingData.GetResOutputEfficiency = function(self, id)
  -- function num : 0_10 , upvalues : _ENV
  local value = (PlayerDataCenter.playerBonus):GetResOutputEfficiency(id)
  local value0 = (PlayerDataCenter.playerBonus):GetResOutputEfficiency(0)
  value = value + value0
  return value
end

AllBuildingData.GetBuiltDataById = function(self, buildId)
  -- function num : 0_11
  local bulidData = (self.built)[buildId]
  if bulidData == nil then
    return nil
  end
  return bulidData:GetResDatas()
end

AllBuildingData.GetOasisBuiltRate = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local totalBuiltLevel = 0
  for _,built in pairs(self.oasisBuilt) do
    totalBuiltLevel = totalBuiltLevel + (built.level or 0)
  end
  return (totalBuiltLevel) / self.oasisTotalLevel
end

return AllBuildingData

