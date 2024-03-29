local OasisBuildingData = class("OasisBuildingData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local CoordinateConvert = require("Game.Oasis.OasisCoordinateConvert")
local DynData = require("Game.Oasis.Data.OasisBuildingDynData")
local cs_MessageCommon = CS.MessageCommon
OasisBuildingData.ctor = function(self)
  -- function num : 0_0
  self.progress = 0
  self.remainSecond = 0
end

OasisBuildingData.Initialize = function(self, data, stcData)
  -- function num : 0_1 , upvalues : _ENV, DynData
  if stcData == nil then
    error("stcData is null" .. data.id)
    return 
  end
  if self.dynData == nil then
    self.dynData = (DynData.New)()
  end
  ;
  (self.dynData):Initialize(stcData)
  self.name = (self.dynData).name
  self.nameEn = (self.dynData).nameEn
  self.id = (self.dynData).id
  self.size = (self.dynData).size
  self.height = (self.dynData).height
  self.levelConfig = (self.dynData).levelConfig
  self.maxLevel = (self.dynData).maxLevel
  self.icon_res = (self.dynData).icon_res
  self.upgradeEffectPath = (self.dynData).upgradeEffectPath
  self.waitConfirmOver = false
  self.resDatas = nil
  self.belong = (self.dynData).belong
  self.sectorId = (self.dynData).sectorId
  if data ~= nil then
    self:Update(data)
    self:AddBuildingBonus()
  else
    self.isBuild = false
  end
end

OasisBuildingData.IsMaxLevel = function(self)
  -- function num : 0_2
  if self.level == nil then
    return false
  end
  do return self.maxLevel <= self.level end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

OasisBuildingData.InitializeWithDynData = function(self, data, dynData)
  -- function num : 0_3
  self.dynData = dynData
  self.name = (self.dynData).name
  self.nameEn = (self.dynData).nameEn
  self.id = (self.dynData).id
  self.size = (self.dynData).size
  self.height = (self.dynData).height
  self.levelConfig = (self.dynData).levelConfig
  self.maxLevel = (self.dynData).maxLevel
  self.icon_res = (self.dynData).icon_res
  self.upgradeEffectPath = (self.dynData).upgradeEffectPath
  self.waitConfirmOver = false
  self.resDatas = nil
  self.belong = (self.dynData).belong
  self.sectorId = (self.dynData).sectorId
  if data ~= nil then
    self:Update(data)
    self:AddBuildingBonus()
  else
    self.isBuild = false
  end
end

OasisBuildingData.Update = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  self.isBuild = true
  self.id = data.id
  self.level = data.level
  self.state = data.state
  self.position = (Vector2.New)(data.x, data.y)
  self.over = data.over
  self.area = data.area
  self.__areaList = nil
  self.waitConfirmOver = false
  if self.level < self.maxLevel then
    if self.state ~= proto_object_BuildingState.BuildingStateCreate or not 1 then
      local nextLevel = self.level + 1
    end
    self.upgradeTotalTime = (math.ceil)(((self.levelConfig)[nextLevel]).time / (1 + (PlayerDataCenter.playerBonus):GetBuildSpeed() / 1000))
  else
    do
      self.upgradeTotalTime = 0
      self.canUpgrade = self:CanUpgrade()
    end
  end
end

OasisBuildingData.CanUpgrade = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (PlayerDataCenter.AllBuildingData):FullBuildQue(self.belong) then
    return false
  end
  if self.state ~= proto_object_BuildingState.BuildingStateNormal then
    return false
  end
  local nextLevel = self.level + 1
  if self.maxLevel < nextLevel then
    return false
  end
  local nextLevelCfg = (self.levelConfig)[nextLevel]
  if not (CheckCondition.CheckLua)(nextLevelCfg.pre_condition, nextLevelCfg.pre_para1, nextLevelCfg.pre_para2) then
    return false
  end
  for k,v in ipairs(nextLevelCfg.consumeIds) do
    local resId = v
    local count = PlayerDataCenter:GetItemCount(resId)
    local cost = (nextLevelCfg.consumeNums)[k]
    if count < cost then
      return false
    end
  end
  return true
end

OasisBuildingData.IsBuildResPeriodOk = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.state == proto_object_BuildingState.BuildingStateCreate or self.resDatas == nil then
    return false
  end
  for k,v in pairs(self.resDatas) do
    do return v.fitPeriodCount end
  end
end

OasisBuildingData.CanGetBuildRes = function(self, withTips, fullWareHouseItemDic)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  if self.state == proto_object_BuildingState.BuildingStateCreate or self.resDatas == nil then
    return false
  end
  local fullWarehouse = true
  local datas = self:GetResDatas()
  for k,v in pairs(datas) do
    local count = v.count
    local capacity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(v.id)
    local playerResCount = PlayerDataCenter:GetItemCount(v.id)
    if playerResCount < capacity then
      fullWarehouse = false
      break
    else
      if withTips then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(v.name .. ConfigData:GetTipContent(TipContent.ItemInWarehouseFull), true)
      end
      if fullWareHouseItemDic ~= nil then
        fullWareHouseItemDic[v.name] = true
      end
    end
  end
  do
    if fullWarehouse then
      return false
    end
    local periodLimit = true
    for k,v in pairs(self.resDatas) do
      if v.fitPeriodCount then
        periodLimit = false
      end
    end
    if periodLimit then
      if withTips then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_UnsatisfMinialRewardCycle), true)
      end
      return false
    end
    return true
  end
end

OasisBuildingData.GetLevelUpgradeReward = function(self, targetLevel)
  -- function num : 0_8
  if not self.level then
    targetLevel = (targetLevel ~= nil or 0) + 1
    if self.maxLevel < targetLevel then
      return nil
    end
    local buildLevelCfg = (self.levelConfig)[targetLevel]
    return buildLevelCfg.reward
  end
end

OasisBuildingData.GetResDatas = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.resDatas == nil then
    return 
  end
  if self._resDataDic == nil then
    self._resDataDic = {}
    self._resDataPool = {}
  else
    for k,data in ipairs(self._resDataPool) do
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

      (self._resDataDic)[data.id] = nil
    end
  end
  do
    local levelConfig = (self.levelConfig)[self.level]
    for i = 1, #levelConfig.logic do
      if (levelConfig.logic)[i] == eLogicType.ResourceOutput then
        local id = (levelConfig.para1)[i]
        local resData = (self.resDatas)[id]
        local speed = (levelConfig.para2)[i]
        local resCount, resProgress, resMax, effSpeed, outputCeiling = resData:GetResCount(speed, (levelConfig.para3)[i])
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R14 in 'UnsetPending'

        if (self._resDataPool)[i] == nil then
          (self._resDataPool)[i] = {}
        end
        local data = (self._resDataPool)[i]
        data.id = id
        data.name = resData:GetName()
        data.count = resCount
        data.countMax = outputCeiling
        data.progress = resProgress
        data.resMax = resMax
        data.speed = speed
        data.effSpeed = effSpeed
        -- DECOMPILER ERROR at PC66: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (self._resDataDic)[id] = data
      end
    end
    return self._resDataDic
  end
end

OasisBuildingData.GetProcess = function(self, timestamp)
  -- function num : 0_10 , upvalues : _ENV
  local remainTime = self.over - timestamp
  remainTime = (math.max)(remainTime, 0)
  remainTime = (math.min)(remainTime, self.upgradeTotalTime)
  local progress = 0
  if self.level < self.maxLevel then
    progress = 1 - remainTime / self.upgradeTotalTime
  else
    progress = 1
  end
  local second = (math.ceil)(remainTime)
  if progress < 1 then
    self.waitConfirmOver = (self.state ~= proto_object_BuildingState.BuildingStateCreate and self.state ~= proto_object_BuildingState.BuildingStateUpgrade) or self.waitConfirmOver
    self.progress = progress
    self.remainSecond = second
    do return progress, second, self.waitConfirmOver end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

OasisBuildingData.GetArea = function(self)
  -- function num : 0_11 , upvalues : CoordinateConvert
  if self.__areaList == nil then
    self.__areaList = (CoordinateConvert.GetHexArea)(self.position, self.size)
  end
  return self.__areaList
end

OasisBuildingData.AddBuildingBonus = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self.state ~= proto_object_BuildingState.BuildingStateCreate then
    local levelConfig = (self.levelConfig)[self.level]
    if levelConfig ~= nil then
      for i = 1, #levelConfig.logic do
        (PlayerDataCenter.playerBonus):InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Building, self.id, (levelConfig.logic)[i], (levelConfig.para1)[i], (levelConfig.para2)[i], (levelConfig.para3)[i])
      end
    end
  end
end

OasisBuildingData.RemoveBuildingBonus = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if self.state ~= proto_object_BuildingState.BuildingStateCreate then
    local levelConfig = (self.levelConfig)[self.level]
    for i = 1, #levelConfig.logic do
      (PlayerDataCenter.playerBonus):UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Building, self.id, (levelConfig.logic)[i])
    end
  end
end

OasisBuildingData.GetJumpTargetId = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local buildCfg = (ConfigData.building)[self.id]
  if buildCfg == nil then
    error("Can\'t read oasis_building Cfg id=" .. self.id)
    return nil
  end
  if buildCfg.system_jump == nil or buildCfg.system_jump == 0 then
    return nil
  else
    return buildCfg.system_jump
  end
end

OasisBuildingData.GetNextLevelCostItem = function(self)
  -- function num : 0_15
  local lvl = nil
  if self.isBuild then
    lvl = self.level + 1
  else
    lvl = 1
  end
  return (self.dynData):GetLevelCostItem(lvl)
end

OasisBuildingData.GetPreBuildingLevelInfo = function(self)
  -- function num : 0_16
  local targetLvl = nil
  if self.isBuild then
    targetLvl = self.level + 1
  else
    targetLvl = 1
  end
  return (self.dynData):GetPreBuildingLvlInfo(targetLvl)
end

OasisBuildingData.GetNextLevelNeedTime = function(self)
  -- function num : 0_17
  local targetLvl = nil
  if self.isBuild then
    targetLvl = self.level + 1
  else
    targetLvl = 1
  end
  return (self.dynData):GetTargetLevelNeedTime(targetLvl)
end

OasisBuildingData.GetNextLevelBuffItem = function(self)
  -- function num : 0_18
  local targetLvl = nil
  local getNext = false
  if self.isBuild then
    targetLvl = self.level
    getNext = true
  else
    targetLvl = 1
    getNext = false
  end
  return (self.dynData):GetBuffItems(targetLvl, getNext)
end

OasisBuildingData.GetBuildCustomLogicInfo = function(self, level)
  -- function num : 0_19 , upvalues : _ENV
  level = level ~= nil or self.level or 1
  local levelConfig = (self.levelConfig)[level]
  if levelConfig == nil then
    error((string.format)("Cant get building levelConfig, buildingId:%s, level:%s", self.id, level))
    return table.emptytable
  end
  if #levelConfig.custom_logic == 0 then
    return table.emptytable
  end
  local infoList = {}
  for k,v in ipairs(levelConfig.custom_logic) do
    local info = nil
    if v == 0 then
      info = ""
    else
      info = ConfigData:GetTipContent(v)
    end
    ;
    (table.insert)(infoList, info)
  end
  return infoList
end

OasisBuildingData.GetSectorName = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local sectorCfg = (ConfigData.sector)[self.sectorId]
  if sectorCfg ~= nil then
    return (LanguageUtil.GetLocaleText)(sectorCfg.name)
  end
end

return OasisBuildingData

