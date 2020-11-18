-- params : ...
-- function num : 0 , upvalues : _ENV
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
  self.resPillarEntityDic = {}
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.bind)
  self.buildBind = {}
  ;
  (UIUtil.LuaUIBindingTable)((self.bind).sectorBuilding, self.buildBind)
  self.sectorCfg = (ConfigData.sector)[sectorId]
  sctInfoItem:SetSctInfoPosConstraint((self.bind).uIPos_Info)
  sctProgressStage:SetSctProgressPosConstraint((self.bind).uIPos_Stage)
  sctProgressBuild:SetSctProgressPosConstraint((self.bind).uIPos_Build)
  ;
  ((CS_EventTriggerListener.Get)((self.bind).collider)):onClick("+", BindCallback(self, self.__OnClickRoot))
  ;
  ((CS_EventTriggerListener.Get)((self.buildBind).collider)):onClick("+", BindCallback(self, self.__OnClickBuilding))
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

SectorItemEntity.GetSctBuildFocusPos = function(self)
  -- function num : 0_5
  return ((self.bind).sectorBuilding).position
end

SectorItemEntity.RefreshSctStageProress = function(self)
  -- function num : 0_6 , upvalues : _ENV
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
end

SectorItemEntity.RefreshSctBuildProgress = function(self)
  -- function num : 0_7 , upvalues : _ENV
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
  -- function num : 0_8 , upvalues : _ENV
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

SectorItemEntity.UpdateSctBuildResPillar = function(self, curSctResDic)
  -- function num : 0_9 , upvalues : _ENV
  local allResList = {}
  for k,v in pairs(curSctResDic) do
    (table.insert)(allResList, v)
  end
  ;
  (table.sort)(allResList, function(a, b)
    -- function num : 0_9_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for k,allResData in ipairs(allResList) do
    if (self.buildBind).pillarCountMax >= k then
      local pillar = (self.resPillarEntityDic)[k]
      do
        if pillar == nil then
          local pos = (((self.buildBind).pillarPos)[k]).position
          pillar = (self.sctCtrl):NewSctResPillarEntity((self.bind).sectorBuilding, k, pos)
          -- DECOMPILER ERROR at PC42: Confused about usage of register: R10 in 'UnsetPending'

          ;
          (self.resPillarEntityDic)[k] = pillar
        end
        do
          local progress = allResData.count / allResData.countMax
          pillar:UpdateResPillarProgress(progress)
          -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

SectorItemEntity.ShowSctItemInEp = function(self, show)
  -- function num : 0_10
  (self.uiSctInfoItem):ShowUISctItemInEp(show)
end

SectorItemEntity.ShowSctItemRedDot = function(self, show)
  -- function num : 0_11
  (self.uiSctProgressStage):ShowSctProgressRedDot(show)
end

SectorItemEntity.ShowSctResRedDot = function(self, show)
  -- function num : 0_12
  (self.uiSctProgressBuild):ShowSctProgressRedDot(show)
end

SectorItemEntity.UpdateSectorLock = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local unlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(self.id)
  ;
  (self.uiSctInfoItem):SetUISctItemLock(not unlock)
  if unlock then
    (self.uiSctProgressStage):Show()
    if self.isSectorBuildingUnlock then
      (self.uiSctProgressBuild):Show()
    else
      ;
      (self.uiSctProgressBuild):Hide()
    end
  else
    ;
    (self.uiSctProgressStage):Hide()
    ;
    (self.uiSctProgressBuild):Hide()
  end
end

SectorItemEntity.SetIsSectorBuildingUnlock = function(self, bool)
  -- function num : 0_14 , upvalues : _ENV
  self.isSectorBuildingUnlock = bool
  if not self.isSectorBuildingUnlock then
    (self.uiSctProgressBuild):Hide()
  else
    if (PlayerDataCenter.sectorStage):IsSectorUnlock(self.id) then
      (self.uiSctProgressBuild):Show()
    end
  end
end

SectorItemEntity.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV
  for k,v in pairs(self.resPillarEntityDic) do
    v:OnDelete()
  end
end

return SectorItemEntity

