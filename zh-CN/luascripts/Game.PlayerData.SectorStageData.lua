-- params : ...
-- function num : 0 , upvalues : _ENV
local SectorStageData = class("SectorStageData")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
SectorStageData.ctor = function(self)
  -- function num : 0_0
  self.lastSelectSector = nil
  self.stageData = {}
  self.__isUnlockFree = false
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
  if self:IsStageComplete(1101) and self:IsStageComplete(1102) and self:IsStageComplete(1103) then
    self.__isUnlockFree = true
  else
    self.__isUnlockFree = false
  end
  MsgCenter:Broadcast(eMsgEventId.OnSectorStageStateChange, data)
end

SectorStageData.IsUnlockFree = function(self, stageId)
  -- function num : 0_3 , upvalues : _ENV
  if self.__isUnlockFree then
    return true
  end
  local stageCfg = nil
  if self:IsStageComplete(1102) then
    if stageId == 1103 then
      return true
    end
    stageCfg = (ConfigData.sector_stage)[1103]
  else
    if self:IsStageComplete(1101) then
      if stageId == 1102 then
        return true
      end
      stageCfg = (ConfigData.sector_stage)[1102]
    else
      if stageId == 1101 then
        return true
      end
      stageCfg = (ConfigData.sector_stage)[1101]
    end
  end
  do
    if stageCfg ~= nil then
      local desc = (string.format)(ConfigData:GetTipContent(289), "主线" .. tostring(stageCfg.sector) .. "-" .. tostring(stageCfg.num) .. "[" .. (LanguageUtil.GetLocaleText)(stageCfg.name) .. "]")
      return false, desc
    end
    return false, ""
  end
end

SectorStageData.GetStageState = function(self, stageId)
  -- function num : 0_4
  local stageState = (self.stageData)[stageId]
  return stageState or 0
end

SectorStageData.IsStageUnlock = function(self, stageId)
  -- function num : 0_5 , upvalues : _ENV
  local stageCfg = (ConfigData.sector_stage)[stageId]
  return (CheckCondition.CheckLua)(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
end

SectorStageData.IsSectorUnlock = function(self, sectorId)
  -- function num : 0_6 , upvalues : _ENV
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
  -- function num : 0_7
  local stageState = self:GetStageState(stageId)
  do return stageState > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SectorStageData.UpdateSctStageItemState = function(self, stageId)
  -- function num : 0_8 , upvalues : _ENV
  local stageCfg = (ConfigData.sector_stage)[stageId]
  if stageCfg == nil then
    error("Cant get sector_stage cfg, stageId = " .. tostring(stageId))
    return 
  end
  MsgCenter:Broadcast(eMsgEventId.OnMainLevelStateChange, stageCfg.sector, stageCfg.difficulty, stageId)
end

SectorStageData.GetEpStageCfg4Home = function(self)
  -- function num : 0_9 , upvalues : _ENV
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
  -- function num : 0_10 , upvalues : _ENV
  local latestSectorId, latestStageIndex = nil, nil
  for sectorId,_ in ipairs((ConfigData.sector).id_sort_list) do
    if self:IsSectorUnlock(sectorId) then
      latestSectorId = sectorId
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
  end
  do
    if latestStageIndex ~= nil then
      return latestSectorId, latestStageIndex
    end
    return 
  end
end

return SectorStageData

