local SectorItemEntity = class("SectorItemEntity")
local CS_EventTriggerListener = CS.EventTriggerListener
SectorItemEntity.ctor = function(self, sctCtrl)
  -- function num : 0_0
  self.sctCtrl = sctCtrl
end

SectorItemEntity.InitSectorItemEntity = function(self, gameObject, sectorId, sctInfoItem, sctProgressStage, sctProgressBuild, uiCanvas)
  -- function num : 0_1 , upvalues : _ENV, CS_EventTriggerListener
  self.gameObject = gameObject
  self.transform = gameObject.transform
  self.id = sectorId
  self.uiSctInfoItem = sctInfoItem
  self.uiSctProgressStage = sctProgressStage
  self.uiSctProgressBuild = sctProgressBuild
  self.uiCanvas = uiCanvas
  self.showProcessBuild = false
  ;
  (self.uiSctProgressBuild):Hide(self.showProcessBuild)
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.bind)
  self.sectorCfg = (ConfigData.sector)[sectorId]
  sctInfoItem:SetSctInfoPosConstraint((self.bind).uIPos_Info)
  sctProgressStage:SetSctProgressPosConstraint((self.bind).uIPos_Stage)
  sctProgressBuild:SetSctProgressPosConstraint((self.bind).uIPos_Build)
  ;
  ((CS_EventTriggerListener.Get)((self.bind).collider)):onClick("+", BindCallback(self, self.__OnClickRoot))
  self:RefreshSctStageProress()
  self:RefreshSctBuildProgress()
  self:UpdateSectorLock()
end

SectorItemEntity.__OnClickRoot = function(self)
  -- function num : 0_2
  if self.sctCtrl ~= nil then
    (self.sctCtrl):OnSectorItemClicked(self.id)
  end
end

SectorItemEntity.__OnClickBuilding = function(self)
  -- function num : 0_3
  if self.sctCtrl ~= nil then
    (self.sctCtrl):StartBuildFocusEnter(self.id)
  end
end

SectorItemEntity.SetSctItemSelect = function(self)
  -- function num : 0_4
  (self.uiCanvas):SetUISctSelect(((self.bind).uIPos_Select).position, (self.bind).selectSize)
end

SectorItemEntity.RefreshSctStageProress = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local sectorIdList = ((ConfigData.sector_stage).sectorIdList)[self.id]
  local allCount = 0
  local completeCount = 0
  for k,id in ipairs(sectorIdList) do
    if ((ConfigData.sector_stage)[id]).difficulty ~= eSectorStageDifficult.Endless then
      do
        allCount = allCount + 1
        if (PlayerDataCenter.sectorStage):IsStageComplete(id) then
          completeCount = completeCount + 1
        end
        -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local progress = (completeCount) / (allCount)
  ;
  (self.uiSctProgressStage):SetSctProgress(progress)
  self:__RefreshBuildLock()
end

SectorItemEntity.RefreshSctBuildProgress = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local totalCurrentLevel = 0
  local builingMaxLevel = 0
  for _,id in ipairs((self.sectorCfg).building) do
    local builtData = ((PlayerDataCenter.AllBuildingData).sectorBuilt)[id]
    do
      if builtData ~= nil then
        if builtData.state ~= proto_object_BuildingState.BuildingStateCreate or not 0 then
          local level = builtData.level
        end
        totalCurrentLevel = totalCurrentLevel + level
      end
      do
        local maxLevel = ((ConfigData.buildingLevel).maxLevelDic)[id]
        builingMaxLevel = builingMaxLevel + maxLevel
        -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  local progress = (totalCurrentLevel) / (builingMaxLevel)
  ;
  (self.uiSctProgressBuild):SetSctProgress(progress)
end

SectorItemEntity.GetSctCanGetResBuild = function(self, canGetResBuildIdDic)
  -- function num : 0_7 , upvalues : _ENV
  for k,buildId in pairs((self.sectorCfg).building) do
    local builtData = ((PlayerDataCenter.AllBuildingData).built)[buildId]
    if builtData ~= nil then
      local cangetRes = builtData:CanGetBuildRes(true)
      if cangetRes then
        canGetResBuildIdDic[buildId] = true
      end
    end
  end
end

SectorItemEntity.ShowSctItemInEp = function(self, show)
  -- function num : 0_8
  (self.uiSctInfoItem):ShowUISctItemInEp(show)
end

SectorItemEntity.ShowSctItemRedDot = function(self, show)
  -- function num : 0_9
  (self.uiSctProgressStage):ShowSctProgressRedDot(show)
end

SectorItemEntity.ShowSctResRedDot = function(self, show)
  -- function num : 0_10
  (self.uiSctProgressBuild):ShowSctProgressRedDot(show)
end

SectorItemEntity.UpdateSectorLock = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local unlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(self.id)
  if unlock then
    (self.uiSctInfoItem):Show()
    ;
    (self.uiSctProgressStage):Show()
    self:SetEmissiveNum(1)
  else
    ;
    (self.uiSctInfoItem):Hide()
    ;
    (self.uiSctProgressStage):Hide()
    self:SetEmissiveNum(0)
  end
  self:__RefreshBuildLock()
end

SectorItemEntity.SetEmissiveNum = function(self, num)
  -- function num : 0_12
  if (self.bind).meshRender ~= nil then
    local materials = ((self.bind).meshRender).materials
    for i = 0, materials.Length - 1 do
      local mat = materials[i]
      mat:SetFloat("_EmissiveSwitch", num)
    end
  end
end

SectorItemEntity.GetMats = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local mats = {}
  if (self.bind).meshRender ~= nil then
    local materials = ((self.bind).meshRender).materials
    for i = 0, materials.Length - 1 do
      (table.insert)(mats, materials[i])
    end
  end
  do
    return mats
  end
end

SectorItemEntity.SetIsSectorBuildingUnlock = function(self, bool)
  -- function num : 0_14
  self.isSectorBuildingUnlock = bool
  self:__RefreshBuildLock()
end

SectorItemEntity.__RefreshBuildLock = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self.isSectorBuildingUnlock and (PlayerDataCenter.sectorStage):AnySectorBuildingUnlock(self.id) and self.showProcessBuild then
    (self.uiSctProgressBuild):Show()
  else
    ;
    (self.uiSctProgressBuild):Hide()
  end
end

SectorItemEntity.OnDelete = function(self)
  -- function num : 0_16
end

return SectorItemEntity

