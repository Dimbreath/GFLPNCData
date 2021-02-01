-- params : ...
-- function num : 0 , upvalues : _ENV
local SectorStageData = class("SectorStageData")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local eDifficulty = (require("Game.Sector.Enum.SectorLevelDetailEnum")).eDifficulty
SectorStageData.ctor = function(self)
  -- function num : 0_0
  self.lastSelectSector = nil
  self.lastPeriodicChallenge = nil
  self.stageData = {}
end

SectorStageData.InitSelectStage = function(self, sectorId, difficult)
  -- function num : 0_1
  self.lastSelectSector = sectorId
  self.lastSelectDiff = difficult or 1
end

SectorStageData.UpdateStageData = function(self, data, isInit)
  -- function num : 0_2 , upvalues : _ENV, CheckerTypeId
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  for k,v in pairs(data) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R9 in 'UnsetPending'

    (self.stageData)[k] = v
    if not isInit then
      self:UpdateSctStageItemState(k)
      local unlockDic = ((ConfigData.sector).stageUnlockDic)[k]
      if unlockDic ~= nil then
        for id,checkerTypeId in pairs(unlockDic) do
          if checkerTypeId == CheckerTypeId.CompleteStage then
            self:UpdateSctStageItemState(id)
          else
            if checkerTypeId == CheckerTypeId.CompleteAvg then
              avgPlayCtrl:UpdateMainAvgState(id)
            end
          end
        end
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.OnSectorStageStateChange, data)
end

SectorStageData.GetStageState = function(self, stageId)
  -- function num : 0_3
  local stageState = (self.stageData)[stageId]
  return stageState or 0
end

SectorStageData.IsStageUnlock = function(self, stageId)
  -- function num : 0_4 , upvalues : _ENV
  local stageCfg = (ConfigData.sector_stage)[stageId]
  return (CheckCondition.CheckLua)(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
end

SectorStageData.IsSectorUnlock = function(self, sectorId)
  -- function num : 0_5 , upvalues : _ENV
  local sectorCfg = (ConfigData.sector)[sectorId]
  if sectorCfg == nil then
    return false
  end
  local sectorStage = ((ConfigData.sector_stage).sectorIdList)[sectorId]
  if sectorStage == nil or #sectorStage == 0 then
    return false
  end
  local sectorStageCfg = (ConfigData.sector_stage)[sectorStage[1]]
  local stageId = sectorStageCfg.id
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1)
  if avgCfg == nil then
    return self:IsStageUnlock(stageId)
  else
    return avgPlayCtrl:IsAvgUnlock(avgCfg.id)
  end
end

SectorStageData.IsStageComplete = function(self, stageId)
  -- function num : 0_6
  local stageState = self:GetStageState(stageId)
  do return stageState > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SectorStageData.IsSectorClear = function(self, sectorId)
  -- function num : 0_7 , upvalues : _ENV, eDifficulty
  local sectorCfg = (ConfigData.sector)[sectorId]
  if sectorCfg == nil then
    return false
  end
  if not self:IsSectorUnlock(sectorId) then
    return false
  end
  local normalStageList = (((ConfigData.sector_stage).sectorDiffDic)[sectorId])[eDifficulty.normal]
  local lastStageId = normalStageList[#normalStageList]
  if self:IsStageComplete(lastStageId) then
    return true
  end
  return false
end

SectorStageData.AnySectorBuildingUnlock = function(self, sectorId)
  -- function num : 0_8 , upvalues : _ENV
  local sectorCfg = (ConfigData.sector)[sectorId]
  if sectorCfg == nil then
    return 
  end
  for k,buildId in ipairs(sectorCfg.building) do
    local lvCfg = (ConfigData.buildingLevel)[buildId]
    if lvCfg == nil then
      error("Cant get buildingLevel cfg, buildId : " .. tostring(buildId))
      return 
    end
    local lv1Cfg = lvCfg[1]
    if lv1Cfg == nil then
      error("Cant get building level 1 cfg, buildId : " .. tostring(buildId))
      return 
    end
    if (CheckCondition.CheckLua)(lv1Cfg.pre_condition, lv1Cfg.pre_para1, lv1Cfg.pre_para2) then
      return true
    end
  end
end

SectorStageData.UpdateSctStageItemState = function(self, stageId)
  -- function num : 0_9 , upvalues : _ENV
  local stageCfg = (ConfigData.sector_stage)[stageId]
  if stageCfg == nil then
    error("Cant get sector_stage cfg, stageId = " .. tostring(stageId))
    return 
  end
  MsgCenter:Broadcast(eMsgEventId.OnMainLevelStateChange, stageCfg.sector, stageCfg.difficulty, stageId)
end

SectorStageData.GetEpStageCfg4Home = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local latestSectorId, latestStageIndex, lastdifferIdex = nil, nil, nil
  for sectorId,_ in ipairs((ConfigData.sector).id_sort_list) do
    if self:IsSectorUnlock(sectorId) then
      latestSectorId = sectorId
    else
      break
    end
  end
  do
    local sageDifferList = ((ConfigData.sector_stage).sectorDiffDic)[latestSectorId]
    for differIdex = 1, (ConfigData.sector_stage).difficultyCount do
      local stageList = sageDifferList[differIdex]
      if stageList ~= nil and #stageList ~= 0 then
        for index,stageId in ipairs(stageList) do
          if self:IsStageUnlock(stageId) then
            latestStageIndex = index
            lastdifferIdex = differIdex
          else
            return latestSectorId, latestStageIndex, differIdex
          end
        end
      end
    end
    if latestStageIndex ~= nil then
      return latestSectorId, latestStageIndex, lastdifferIdex
    end
    local final = nil
    for key,value in pairs(ConfigData.sector_stage) do
      final = value
      do break end
    end
    do
      return final.sector, final.id, final.difficulty
    end
  end
end

SectorStageData.GetEpStageCfg4UserInfo = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local latestSectorId, latestStageIndex = nil, nil
  for sectorId,_ in ipairs((ConfigData.sector).id_sort_list) do
    if self:IsSectorUnlock(sectorId) then
      do
        local sectorStage = ((ConfigData.sector_stage).sectorIdList)[sectorId]
        if self:IsStageComplete(sectorStage[1]) then
          latestSectorId = sectorId
          latestStageIndex = 1
          local sageDifferList = ((ConfigData.sector_stage).sectorDiffDic)[latestSectorId]
          local differIdex = 1
          local stageList = sageDifferList[differIdex]
          if stageList ~= nil and #stageList ~= 0 then
            for index,stageId in ipairs(stageList) do
              if self:IsStageComplete(stageId) then
                latestStageIndex = index
              else
                return latestSectorId, latestStageIndex
              end
            end
          end
        else
          break
        end
        -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if latestStageIndex ~= nil then
    return latestSectorId, latestStageIndex
  end
  return 
end

SectorStageData.GetGetUnlockInfo = function(self, stageId)
  -- function num : 0_12 , upvalues : _ENV
  local cfg = (ConfigData.sector_stage)[stageId]
  local lockInfo = (CheckCondition.GetUnlockInfoLua)(cfg.pre_condition, cfg.pre_para1)
  return lockInfo
end

return SectorStageData

