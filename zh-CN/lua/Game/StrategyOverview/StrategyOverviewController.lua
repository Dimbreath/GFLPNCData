local base = ControllerBase
local StrategyOverviewController = class("UIStrategyOverviewController", base)
local BuildingData = require("Game.Oasis.Data.OasisBuildingData")
local BuildEnum = require("Game.Oasis.Data.BuildingEnum")
local cs_MessageCommon = CS.MessageCommon
StrategyOverviewController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.buildingNetwork = NetworkManager:GetNetwork(NetworkTypeID.Building)
end

StrategyOverviewController.InitStOCtrl = function(self, sectorId, buildId, closeFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.closeFunc = closeFunc
  local techDataList = self:GetTechDataList(sectorId, buildId)
  UIManager:ShowWindowAsync(UIWindowTypeID.StrategyOverview, function(window)
    -- function num : 0_1_0 , upvalues : self, techDataList
    if window == nil then
      return 
    end
    window:InitUIStO(self, techDataList)
  end
)
end

StrategyOverviewController.InitCareerStO = function(self, buildId, closeFunc)
  -- function num : 0_2 , upvalues : _ENV, cs_MessageCommon
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1) then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1))
    return 
  end
  self.closeFunc = closeFunc
  local techDataList = self:GetCareerMaster(buildId)
  UIManager:ShowWindowAsync(UIWindowTypeID.StrategyOverview, function(window)
    -- function num : 0_2_0 , upvalues : self, techDataList
    if window == nil then
      return 
    end
    window:InitCareerStO(self, techDataList)
  end
)
end

StrategyOverviewController.GetTechDataList = function(self, defaultSectorId, defaultBuildId)
  -- function num : 0_3 , upvalues : _ENV, BuildingData
  if defaultSectorId == nil then
    defaultSectorId = 1
  end
  if defaultBuildId == nil or not defaultBuildId then
    defaultBuildId = (ConfigData.game_config).defaultStOBuild
  end
  local techDataList = {}
  local hasSelect = false
  for k,sectorId in ipairs((ConfigData.sector).id_sort_list) do
    local sectorCfg = (ConfigData.sector)[sectorId]
    if sectorCfg == nil then
      error("Cant get sectorCfg, sectorId = " .. tostring(sectorId))
    else
      for k2,buildId in ipairs(sectorCfg.building) do
        local buildingData = ((PlayerDataCenter.AllBuildingData).built)[buildId]
        do
          if buildingData == nil then
            local data = ((PlayerDataCenter.AllBuildingData).unbuilt)[buildId]
            buildingData = (BuildingData.New)()
            buildingData:InitializeWithDynData(nil, data)
          end
          local selected = false
          if defaultBuildId or defaultSectorId ~= sectorId or 0 == buildId then
            selected = true
            hasSelect = true
          else
            if k2 == #sectorCfg.building and not hasSelect then
              selected = true
            end
          end
          do
            local techData = {buildingData = buildingData, sectorId = sectorId, selected = selected}
            ;
            (table.insert)(techDataList, techData)
            -- DECOMPILER ERROR at PC79: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
  return techDataList
end

StrategyOverviewController.GetCareerMaster = function(self, defaultBuildId)
  -- function num : 0_4 , upvalues : _ENV, BuildingData
  local techDataList = {}
  for _,buildId in ipairs((ConfigData.building).careerBuilds) do
    local buildingData = ((PlayerDataCenter.AllBuildingData).built)[buildId]
    do
      if buildingData == nil then
        local data = ((PlayerDataCenter.AllBuildingData).unbuilt)[buildId]
        buildingData = (BuildingData.New)()
        buildingData:InitializeWithDynData(nil, data)
      end
      do
        local techData = {buildingData = buildingData, selected = defaultBuildId == buildId}
        ;
        (table.insert)(techDataList, techData)
        -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  do return techDataList end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

StrategyOverviewController.StOTechUpgrade = function(self, buildingData)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  if (PlayerDataCenter.AllBuildingData):FullSectorBuildQue() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_ConstructQueueFull))
    return 
  end
  self.upgradeBuidingId = buildingData.id
  if self._OnStOTechUpgradeFunc == nil then
    self._OnStOTechUpgradeFunc = BindCallback(self, self._OnStOTechUpgrade)
  end
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  if buildingData.isBuild then
    local nextLevel = buildingData.level + 1
    if buildingData.maxLevel < nextLevel then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_LevelFull))
      return 
    end
    if not buildingData:CanUpgrade() then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_NotFillConstructCodition))
      return 
    end
    ;
    (self.buildingNetwork):SendBuildingUpgrade(buildingData.id, self._OnStOTechUpgradeFunc)
  else
    do
      if not (buildingData.dynData):CanBuild() then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_NotFillConstructCodition))
        return 
      end
      ;
      (self.buildingNetwork):SendBuildingConstruct(buildingData.id, nil, nil, self._OnStOTechUpgradeFunc)
    end
  end
end

StrategyOverviewController._OnStOTechUpgrade = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.StrategyOverview)
  do
    if window ~= nil then
      local buildingData = ((PlayerDataCenter.AllBuildingData).built)[self.upgradeBuidingId]
      window:OnStOBuildUpgradeComplete(buildingData)
    end
    window = UIManager:GetWindow(UIWindowTypeID.Sector)
    if window ~= nil then
      window:RefreshStrategyOverviewBtn()
    end
    local reward = NetworkManager:GetRewardShowCache()
    do
      if reward ~= nil and (table.count)(reward) > 0 then
        local rewardIds = {}
        local rewardCounts = {}
        local heroIdSnapShoot = self._heroIdSnapShoot
        for id,count in pairs(reward) do
          (table.insert)(rewardIds, id)
          ;
          (table.insert)(rewardCounts, count)
        end
        local window = UIManager:GetWindow(UIWindowTypeID.CommonReward)
        if window ~= nil then
          window:Hide()
          window:Show()
          window:InitRewardsItem(rewardIds, rewardCounts, heroIdSnapShoot)
        else
          UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_6_0 , upvalues : rewardIds, rewardCounts, heroIdSnapShoot
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardCounts, heroIdSnapShoot)
  end
)
        end
      end
    end
  end
end

StrategyOverviewController.UpdateStOBuilding = function(self, buildingId)
  -- function num : 0_7 , upvalues : _ENV
  local buildingData = ((PlayerDataCenter.AllBuildingData).built)[buildingId]
  if buildingData == nil then
    return 
  end
  local window = UIManager:GetWindow(UIWindowTypeID.StrategyOverview)
  if window ~= nil then
    window:UpdateUIStOBuilding(buildingData)
  end
end

StrategyOverviewController.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.StrategyOverview)
  if self.closeFunc ~= nil then
    (self.closeFunc)()
  end
  ;
  (base.OnDelete)(self)
end

return StrategyOverviewController

