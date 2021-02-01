-- params : ...
-- function num : 0 , upvalues : _ENV
local base = ControllerBase
local StrategyOverviewController = class("UIStrategyOverviewController", base)
local BuildingData = require("Game.Oasis.Data.OasisBuildingData")
local cs_MessageCommon = CS.MessageCommon
StrategyOverviewController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.buildingNetwork = NetworkManager:GetNetwork(NetworkTypeID.Building)
end

StrategyOverviewController.InitStOCtrl = function(self, sectorId, closeFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.closeFunc = closeFunc
  if sectorId == nil then
    sectorId = 1
  end
  local techDataList = self:_GetTechDataList(sectorId)
  UIManager:ShowWindowAsync(UIWindowTypeID.StrategyOverview, function(window)
    -- function num : 0_1_0 , upvalues : self, techDataList
    if window == nil then
      return 
    end
    window:InitUIStO(self, techDataList)
  end
)
end

StrategyOverviewController._GetTechDataList = function(self, defaultSectorId)
  -- function num : 0_2 , upvalues : _ENV, BuildingData
  local techDataList = {}
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
          local selected = defaultSectorId == sectorId and k2 == 1
          do
            local techData = {buildingData = buildingData, sectorId = sectorId, selected = selected}
            ;
            (table.insert)(techDataList, techData)
            -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
  do return techDataList end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

StrategyOverviewController.StOTechUpgrade = function(self, buildingData)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon
  if (PlayerDataCenter.AllBuildingData):FullSectorBuildQue() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Building_ConstructQueueFull))
    return 
  end
  self.upgradeBuidingId = buildingData.id
  if self._OnStOTechUpgradeFunc == nil then
    self._OnStOTechUpgradeFunc = BindCallback(self, self._OnStOTechUpgrade)
  end
  if buildingData.isBuild then
    local nextLevel = buildingData.level + 1
    if buildingData.maxLevel < nextLevel then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Building_LevelFull))
      return 
    end
    if not buildingData:CanUpgrade() then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Building_NotFillConstructCodition))
      return 
    end
    ;
    (self.buildingNetwork):SendBuildingUpgrade(buildingData.id, self._OnStOTechUpgradeFunc)
  else
    do
      if not (buildingData.dynData):CanBuild() then
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Building_NotFillConstructCodition))
        return 
      end
      ;
      (self.buildingNetwork):SendBuildingConstruct(buildingData.id, nil, nil, self._OnStOTechUpgradeFunc)
    end
  end
end

StrategyOverviewController._OnStOTechUpgrade = function(self)
  -- function num : 0_4 , upvalues : _ENV
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
  end
end

StrategyOverviewController.UpdateStOBuilding = function(self, buildingId)
  -- function num : 0_5 , upvalues : _ENV
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
  -- function num : 0_6 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.StrategyOverview)
  if self.closeFunc ~= nil then
    (self.closeFunc)()
  end
  ;
  (base.OnDelete)(self)
end

return StrategyOverviewController

