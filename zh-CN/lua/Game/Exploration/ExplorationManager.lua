local DynEpMapData = require("Game.Exploration.MapData.DynEpMapData")
local DynPlayer = require("Game.Exploration.Data.DynPlayer")
local EpMvpData = require("Game.Exploration.Data.EpMvpData")
local CS_PlayerPrefs = (CS.UnityEngine).PlayerPrefs
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local util = require("XLua.Common.xlua_util")
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local SectorEnum = require("Game.Sector.SectorEnum")
local ExplorationResultCtrl = require("Game.Exploration.Ctrl.ExplorationResultCtrl")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local ChipData = require("Game.PlayerData.Item.ChipData")
local EpDataCenter = require("Game.Exploration.MapData.EpDataCenter")
local epMainCtrlCfg = {[(ExplorationEnum.eMapLogic).Default] = require("Game.Exploration.MainCtrl.EpNormalMainCtrl"), [(ExplorationEnum.eMapLogic).TowerDefence] = require("Game.Exploration.MainCtrl.EpTDMainCtrl"), [(ExplorationEnum.eMapLogic).Light] = require("Game.Exploration.MainCtrl.EpLightMainCtrl")}
local epDynPlayerCfg = {[(ExplorationEnum.eMapLogic).Default] = require("Game.Exploration.Data.DynPlayer"), [(ExplorationEnum.eMapLogic).TowerDefence] = require("Game.BattleTowerDefence.Data.TowerDefenceDynPlayer"), [(ExplorationEnum.eMapLogic).Light] = require("Game.Exploration.Data.DynPlayer")}
ExplorationManager = {__isInExploration = false}
local __NewExplorationInternal = function(self, fomationId)
  -- function num : 0_0
end

local __ClearCurExploration = function(self)
  -- function num : 0_1
  if self.epCtrl ~= nil then
    (self.epCtrl):OnDelete()
    self.epCtrl = nil
  end
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.ctor = function(self)
  -- function num : 0_2 , upvalues : ExplorationResultCtrl
  self.resultCtrl = (ExplorationResultCtrl.New)()
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.IsInExploration = function(self)
  -- function num : 0_3
  return self.__isInExploration
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.IsInTDExp = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.floorId ~= nil then
    local expCfg = (ConfigData.exploration)[self.floorId]
    if expCfg ~= nil and self:CheckTDModeByMapLogic(expCfg.map_logic) then
      return true
    end
  else
    do
      local dungeonId = nil
      if self.dungeonId == nil then
        _ = ExplorationManager:HasUncompletedEp()
      else
        -- DECOMPILER ERROR at PC28: Overwrote pending register: R1 in 'AssignReg'

      end
      if dungeonId == nil then
        return false
      end
      local sectorStageCfg = (ConfigData.sector_stage)[self.dungeonId]
      if sectorStageCfg == nil then
        return false
      end
      local expFloorList = sectorStageCfg.exploration_list
      if expFloorList == nil then
        return false
      end
      for _,v in ipairs(expFloorList) do
        local expCfg = (ConfigData.exploration)[v]
        if expCfg ~= nil and self:CheckTDModeByMapLogic(expCfg.map_logic) then
          return true
        end
      end
      do
        return false
      end
    end
  end
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.CheckTDModeByMapLogic = function(self, mapLogicId)
  -- function num : 0_5 , upvalues : ExplorationEnum
  do return mapLogicId == (ExplorationEnum.eMapLogic).TowerDefence end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.IsInExplorationAndScene = function(self)
  -- function num : 0_6
  do return self.__isInExploration and ((self.epCtrl ~= nil and (self.epCtrl).loadSceneComplete)) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.ReqEnterExploration = function(self, epId, fomationId, moduleId, ezMode, callback, support)
  -- function num : 0_7 , upvalues : _ENV
  self.__enterEpComplete = callback
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  ;
  (self.network):CS_EXPLORATION_Start(epId, fomationId, moduleId, ezMode, nil, support)
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.RecvEnterExploration = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_StartFailure) .. tostring(msg.ret))
    MsgCenter:Broadcast(eMsgEventId.ExplorationEnterComplete, false)
    return 
  end
  self:__NewExploration(msg.detail, false)
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetMapCfg = function(self, dungeonId)
  -- function num : 0_9 , upvalues : _ENV, SectorLevelDetailEnum
  if self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local cfg = (ConfigData.sector_stage)[dungeonId]
    if cfg == nil then
      error("sector stage is null,id:" .. tostring(dungeonId))
      return 
    end
    local metatable = getmetatable(cfg)
    local stageCfg = {}
    for key,value in pairs(metatable.__index) do
      stageCfg[key] = value
    end
    for key,value in pairs(cfg) do
      stageCfg[key] = value
    end
    return stageCfg
  else
    do
      if self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
        local endlessId = dungeonId
        local levelDic = ((ConfigData.endless).levelDic)[endlessId]
        local cfg = ((ConfigData.endless)[levelDic.sectorId])[levelDic.index]
        if cfg == nil then
          error("endlessCfg is null,endlessId:" .. tostring(endlessId))
          return 
        end
        local stageCfg = {endlessCfg = cfg, name = cfg.name, sector = levelDic.sectorId, index = levelDic.index, cost_strength_num = (cfg.cost_strength_itemNums)[1], difficulty = (SectorLevelDetailEnum.eDifficulty).infinity, dungeonId = endlessId, combat = cfg.combat}
        return stageCfg
      else
        do
          if self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
            local challengeCfg = (ConfigData.daily_challenge)[dungeonId]
            local stageCfg = {challengeCfg = challengeCfg, name = (LanguageUtil.GetLocaleText)(challengeCfg.name), sector = nil, cost_strength_num = 0, difficulty = (SectorLevelDetailEnum.eDifficulty).daily_challenge, dungeonId = dungeonId, combat = 5000}
            return stageCfg
          else
            do
              if self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
                local challengeCfg = (ConfigData.weekly_challenge)[dungeonId]
                local stageCfg = {challengeCfg = challengeCfg, name = (LanguageUtil.GetLocaleText)(challengeCfg.name), sector = nil, cost_strength_num = 0, difficulty = (SectorLevelDetailEnum.eDifficulty).weekly_challenge, dungeonId = dungeonId, combat = 5000}
                return stageCfg
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.ReqEnterChallengeExploration = function(self, fomationId, callback)
  -- function num : 0_10 , upvalues : _ENV
  self.__enterEpComplete = callback
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  ;
  (self.network):CS_DAILYCHALLENGE_Start(fomationId)
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.ReqEnterWeeklyExploration = function(self, challengeId, virtualFormation, callback)
  -- function num : 0_11 , upvalues : _ENV
  self.__enterEpComplete = callback
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  ;
  (self.network):CS_WEEKLYCHALLENGE_Start(challengeId, virtualFormation.buffIds, (virtualFormation.formation).data, virtualFormation:GetCstTreeId(), virtualFormation:GetSctSkills())
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.__NewExploration = function(self, msg, isReconnect)
  -- function num : 0_12 , upvalues : EpDataCenter, _ENV, epDynPlayerCfg, EpMvpData
  self.restartInfo = {epId = (msg.epMap).dungeonId, fomationId = (msg.epStc).formId, moduleId = (msg.epMap).moduleId}
  self.moduleId = (msg.epMap).moduleId
  self.floorId = (msg.epMap).floorId
  self.dungeonId = (msg.epMap).dungeonId
  self.astAv = msg.astAv
  if not isReconnect then
    isReconnect = false
  end
  self.epDataCenter = (EpDataCenter.New)()
  ;
  (self.epDataCenter):InitEpDataCenter()
  local isChallenge = false
  local moduleId = self:GetEpModuleId()
  self.stageCfg = self:GetMapCfg(self:GetEpDungeonId())
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    (self.epDataCenter):GetStageEpChipData(self.stageCfg)
  else
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
      local endlessId = self:GetEpDungeonId()
      local levelDic = ((ConfigData.endless).levelDic)[endlessId]
      local cfg = ((ConfigData.endless)[levelDic.sectorId])[levelDic.index]
      if cfg == nil then
        error("endlessCfg is null,endlessId:" .. tostring(endlessId))
        return 
      end
      ;
      (self.epDataCenter):GetInfinityEpChipData(cfg)
    else
      do
        if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
          isChallenge = true
        else
          if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
            isChallenge = true
          end
        end
        ;
        (NetworkManager:GetNetwork(NetworkTypeID.Sector)):SendChipSet()
        do
          if not isChallenge then
            local cfg = (ConfigData.sector)[(self.stageCfg).sector]
            if cfg == nil then
              error("sector cfg is null,id:" .. tostring((self.stageCfg).sector))
              return 
            end
            self.sectorCfg = cfg
          end
          local epDynPlayerClass = epDynPlayerCfg[(msg.epMap).logic]
          if epDynPlayerClass == nil then
            error("Cant get epDynPlayerClass, logic = " .. tostring((msg.epMap).logic))
            return 
          end
          self.dynPlayer = (epDynPlayerClass.New)()
          ;
          (self.dynPlayer):CreateDefaultPlayer(msg.epRoleStc, msg.epRoleDyc, msg.epStc, msg.epStmGoods)
          ;
          (self.dynPlayer):InitDynPlayerAttr((msg.epRoleStc).player)
          ;
          (self.dynPlayer):UpdateHeroAttr((msg.epRoleStc).heroes)
          ;
          (self.dynPlayer):UpdateOperatorDetail(msg.epOp)
          ;
          (self.dynPlayer):UpdateEpEventData(msg.epOp)
          ;
          (self.dynPlayer):UpdateEpBackpack(msg.epBackpack)
          ;
          (self.dynPlayer):UpdateEpBuff(msg.epBuff)
          ;
          (self.dynPlayer):UpdateAllDynServerGrid(msg.epBattleGrid)
          ;
          (self.dynPlayer):UpdateEpCommonData(msg.epCommon)
          self:EnterCurSectionExploration(msg, isReconnect)
          MsgCenter:Broadcast(eMsgEventId.ExplorationEnterComplete, true)
          ControllerManager:DeleteController(ControllerTypeId.SectorController)
          self.__isInExploration = true
          if self.__enterEpComplete ~= nil then
            (self.__enterEpComplete)()
            self.__enterEpComplete = nil
          end
          self.epMvpData = (EpMvpData.New)((msg.epRoleStc).heroes)
          -- DECOMPILER ERROR at PC206: Confused about usage of register: R6 in 'UnsetPending'

          ;
          (self.epMvpData).defaultMVPHeroId = (((self.dynPlayer).heroList)[1]).dataId
          if isReconnect then
            (self.epMvpData):AddServerSaveData((msg.epStc).record, (msg.epRoleStc).heroes)
          end
          self:UpdateChipDataPreview()
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.TryUpdataEpMvpHeros = function(self, heroList, removeHeroList)
  -- function num : 0_13
  if self.epMvpData ~= nil then
    (self.epMvpData):UpdataEpMvpDataHeroIdMapping(heroList, removeHeroList)
  end
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetEpModuleId = function(self)
  -- function num : 0_14
  return self.moduleId
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetEpModuleTypeCfgId = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self:IsInExplorationTD() then
    return (ConfigData.game_config).towerEpTypeCfgId
  end
  return self.moduleId
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.IsSectorNewbee = function(self)
  -- function num : 0_16 , upvalues : _ENV, SectorEnum
  local moduleId = self:GetEpModuleId()
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local stageCfg = self:GetSectorStageCfg()
    local sectorId = stageCfg.sector
    return sectorId == SectorEnum.NewbeeSectorId
  end
  do return false end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetEpTypeCfg = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local moduleId = self:GetEpModuleTypeCfgId()
  local epTypeCfg = (ConfigData.exploration_type)[moduleId]
  if epTypeCfg == nil then
    error("Cant get exploration_type, epModuleId = " .. tostring(moduleId))
    return 
  end
  return epTypeCfg
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetEpDungeonId = function(self)
  -- function num : 0_18
  return self.dungeonId
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetSectorStageCfg = function(self)
  -- function num : 0_19
  return self.stageCfg
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetSectorCfg = function(self)
  -- function num : 0_20
  return self.sectorCfg
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetCurExplorationId = function(self)
  -- function num : 0_21
  return self.floorId
end

-- DECOMPILER ERROR at PC143: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.EnterCurSectionExploration = function(self, msg, isReconnect, isNextExp)
  -- function num : 0_22 , upvalues : __ClearCurExploration, _ENV, DynEpMapData, epMainCtrlCfg
  self.floorId = (msg.epMap).floorId
  if not isReconnect then
    isReconnect = false
  end
  local needEnableAutoEp = false
  if self.epCtrl ~= nil then
    needEnableAutoEp = ((self.epCtrl).autoCtrl):IsEnableAutoMode()
  end
  __ClearCurExploration(self)
  UIManager:DeleteAllWindow()
  ;
  ((CS.UIManager).Instance):DeleteAllWindow()
  local epMapData = (DynEpMapData.New)()
  if isNextExp then
    self.stageCfg = self:GetMapCfg((msg.epMap).dungeonId)
  end
  local opDetail = (self.dynPlayer):GetOperatorDetail((self:GetSectorStageCfg()).id)
  epMapData:InitMapData(msg.epMap, msg.epNext, opDetail)
  ;
  (self.dynPlayer):SetChipDiscardId((msg.epMap).discardId)
  local epMainCtrlClass = epMainCtrlCfg[(msg.epMap).logic]
  if epMainCtrlClass == nil then
    error("Cant get epMainCtrlClass, logic = " .. tostring((msg.epMap).logic))
    return 
  end
  self.epCtrl = (epMainCtrlClass.New)(epMapData, self.dynPlayer)
  ;
  ((self.epCtrl).autoCtrl):SetDefaultAutoEp(needEnableAutoEp)
  ;
  ((self.epCtrl).overclockCtrl):InitEpOverclockCtrl(msg.epClock)
  do
    if msg.epGrid ~= nil then
      local jumpCat = nil
      if msg.epOp ~= nil then
        jumpCat = (msg.epOp).jumpCat
      end
      ;
      (self.epCtrl):UpdateNextRoomInfo(msg.epGrid, jumpCat)
    end
    if msg.epResident ~= nil then
      (self.epCtrl):UpdateResidentDetail(msg.epResident)
    end
    local isFirstEnter = (not isReconnect and not isNextExp)
    ;
    (self.epCtrl):Start(isReconnect, isFirstEnter)
    ;
    (GR.SetIsOneTheEpMap)(true)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC146: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.EnterNextSectionExploration = function(self)
  -- function num : 0_23 , upvalues : _ENV
  (((self.epCtrl).mapData):GetNextMapBrief())
  local nextBrief = nil
  local id = nil
  for k,v in pairs(nextBrief.data) do
    id = k
    do break end
  end
  do
    ;
    (self.network):CS_EXPLORATION_NextFloor(id)
  end
end

-- DECOMPILER ERROR at PC149: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.OnEnterNextSectionExploration = function(self, msg)
  -- function num : 0_24 , upvalues : _ENV
  AudioManager:PlayAudioById(1028)
  self:EnterCurSectionExploration(msg, false, true)
end

-- DECOMPILER ERROR at PC152: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.IsCompleteLastEpRoom = function(msg)
  -- function num : 0_25 , upvalues : _ENV
  local x, y = (ExplorationManager.Coordination2Pos)((msg.epOp).curPostion)
  local nextPos = (ExplorationManager.XY2Coordination)(x + 1, y)
  do return not (msg.epOp).canFloorOver or (((msg.epMap).lineData)[(msg.epOp).curPostion] ~= nil and ((msg.epMap).lineData)[nextPos] == nil and (msg.epOp).state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over and (msg.epMap).floor <= (msg.epMap).floorIdx + 1) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC155: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetLastEpData = function(self)
  -- function num : 0_26
  return self.__lastEpData
end

-- DECOMPILER ERROR at PC158: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.RecordLastEpData = function(self, msg)
  -- function num : 0_27 , upvalues : _ENV, SectorLevelDetailEnum
  self.__lastEpData = msg
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  local isComplete = false
  local hasHasUncompletedEp, dungeonId = ExplorationManager:HasUncompletedEp()
  if msg.epStmGoods ~= nil and #(msg.epStmGoods).stmStore ~= 0 then
    local noStore = not hasHasUncompletedEp
    local x, y = (ExplorationManager.Coordination2Pos)((msg.epOp).curPostion)
    local nextPos = (ExplorationManager.XY2Coordination)(x + 1, y)
    if (ExplorationManager.IsCompleteLastEpRoom)(msg) and noStore then
      (self.resultCtrl):EnterResultProcess(true, false)
      isComplete = true
    elseif (msg.epOp).state == proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleFailure then
      local returnStamina, remainLevelCount, costStamina = self:GetLastEpReturnStamina()
      if costStamina <= 0 and noStore then
        (self.resultCtrl):EnterResultProcess(false, false)
        isComplete = true
      end
    end
    do
      local stageCfg = self:TryGetUncompletedEpSectorStateCfg()
      if stageCfg.sector ~= nil and stageCfg.difficulty <= (SectorLevelDetailEnum.eDifficulty).infinity then
        (PlayerDataCenter.sectorStage):InitSelectStage(stageCfg.sector, stageCfg.difficulty)
      end
      if isComplete then
        self.__lastEpData = nil
      end
      MsgCenter:Broadcast(eMsgEventId.OnHasUncompletedEp)
      -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end
  end
end

-- DECOMPILER ERROR at PC161: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.HasUncompletedEp = function(self)
  -- function num : 0_28
  local has = self.__lastEpData ~= nil and (self.__lastEpData).epMap ~= nil
  if has then
    local moduleId = ((self.__lastEpData).epMap).moduleId
  end
  if has then
    local dungeonId = ((self.__lastEpData).epMap).dungeonId
  end
  local canFloorOver = not has or not ((self.__lastEpData).epOp).canFloorOver or ((self.__lastEpData).epMap).floor <= ((self.__lastEpData).epMap).floorIdx + 1
  do return has, dungeonId, moduleId, canFloorOver end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC164: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetStoreData = function(self)
  -- function num : 0_29
  if self.dynPlayer ~= nil then
    return ((self.dynPlayer).dynRewardBag):GetEpRewardBagDataList()
  end
  if self.__lastEpData ~= nil and (self.__lastEpData).epStmGoods ~= nil then
    return ((self.__lastEpData).epStmGoods).stmStore
  end
  return nil
end

-- DECOMPILER ERROR at PC167: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.TryGetUncompletedEpSectorStateCfg = function(self)
  -- function num : 0_30 , upvalues : _ENV, SectorLevelDetailEnum
  local hasHasUncompletedEp, dungeonId, moduleId = ExplorationManager:HasUncompletedEp()
  if hasHasUncompletedEp then
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
      local sectorStateCfg = (ConfigData.sector_stage)[dungeonId]
      if sectorStateCfg == nil then
        error("Can\'t find sectorStateCfg, id = " .. tostring(dungeonId))
        return 
      end
      return sectorStateCfg
    else
      do
        if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
          local levelDic = ((ConfigData.endless).levelDic)[dungeonId]
          local cfg = ((ConfigData.endless)[levelDic.sectorId])[levelDic.index]
          if cfg == nil then
            error("endlessCfg is null,endlessId:" .. tostring(dungeonId))
            return 
          end
          local stageCfg = {endlessCfg = cfg, name = cfg.name, sector = levelDic.sectorId, cost_strength_num = (cfg.cost_strength_itemNums)[1], difficulty = (SectorLevelDetailEnum.eDifficulty).infinity, dungeonId = dungeonId}
          return stageCfg
        else
          do
            if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
              local challengeCfg = (ConfigData.daily_challenge)[dungeonId]
              local stageCfg = {challengeCfg = challengeCfg, name = (LanguageUtil.GetLocaleText)(challengeCfg.name), sector = nil, cost_strength_num = 0, difficulty = (SectorLevelDetailEnum.eDifficulty).daily_challenge, dungeonId = dungeonId}
              return stageCfg
            else
              do
                if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
                  local challengeCfg = (ConfigData.weekly_challenge)[dungeonId]
                  local stageCfg = {challengeCfg = challengeCfg, name = (LanguageUtil.GetLocaleText)(challengeCfg.name), sector = nil, cost_strength_num = 0, difficulty = (SectorLevelDetailEnum.eDifficulty).weekly_challenge, dungeonId = dungeonId, combat = 5000}
                  return stageCfg
                end
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC170: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.ContinueLastExploration = function(self, callback)
  -- function num : 0_31 , upvalues : _ENV
  if not self:HasUncompletedEp() then
    print("Last exploration data is null")
    return 
  end
  self.__enterEpComplete = callback
  if self.__onContinueLastExploration == nil then
    self.__onContinueLastExploration = BindCallback(self, self.OnContinueLastExploration)
  end
  ;
  (self.network):CS_EXPLORATION_NtfServerEnter(self.__onContinueLastExploration)
end

-- DECOMPILER ERROR at PC173: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.OnContinueLastExploration = function(self)
  -- function num : 0_32
  self:__NewExploration(self.__lastEpData, true)
  self.__lastEpData = nil
end

-- DECOMPILER ERROR at PC176: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GiveUpLastExploration = function(self)
  -- function num : 0_33 , upvalues : _ENV
  if not self:HasUncompletedEp() then
    print("Last exploration data is null")
    return 
  end
  local isWin = (ExplorationManager.IsCompleteLastEpRoom)(self.__lastEpData)
  ;
  (self.resultCtrl):EnterResultProcess(isWin, false)
end

-- DECOMPILER ERROR at PC179: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.SendFloorSettle = function(self, callback)
  -- function num : 0_34 , upvalues : _ENV
  if self.dynPlayer ~= nil then
    (self.network):CS_EXPLORATION_SettleFloor(((self.dynPlayer):GetOperatorDetail()).curPostion, callback)
  else
    print("warning : dynPlayer is nil")
  end
end

-- DECOMPILER ERROR at PC182: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.ExitExploration = function(self, SceneName, loadMainCallback, isWin, scenechangeCallback)
  -- function num : 0_35 , upvalues : _ENV, util
  ((CS.BattleManager).Instance):ForceExitBattle()
  local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  saveUserData:SetUnitBlood(0, 0)
  local lastSatgeData = {stageCfg = self.stageCfg, isWin = isWin == true}
  MsgCenter:Broadcast(eMsgEventId.ExplorationExit)
  ;
  (self.network):CS_EXPLORATION_Detail()
  self:ClearExploration()
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Character)
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Monster)
  AudioManager:RemoveCueSheet(eAuCueSheet.CommonSkill)
  AudioManager:RemoveCueSheet(eAuCueSheet.Ambience)
  AudioManager:RemoveAllVoice()
  UIManager:DeleteAllWindow()
  ;
  ((CS.UIManager).Instance):DeleteAllWindow()
  if SceneName == nil or SceneName == (Consts.SceneName).Sector then
    local loadingFunc = function()
    -- function num : 0_35_0 , upvalues : _ENV, scenechangeCallback
    UIManager:ShowWindowAsync(UIWindowTypeID.Sector, nil)
    while UIManager:GetWindow(UIWindowTypeID.Sector) == nil do
      (coroutine.yield)(nil)
    end
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, true)
    if sectorController:IsHave2PlayUnlockSectorShow() then
      sectorController:SetAfterUnlockSectorShowCallback(scenechangeCallback)
    else
      if scenechangeCallback ~= nil then
        scenechangeCallback()
      end
    end
  end

    ;
    (UIManager:GetWindow(UIWindowTypeID.Loading)):SetLoadingTipsSystemId(1)
    ;
    ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Sector, function()
    -- function num : 0_35_1 , upvalues : _ENV, lastSatgeData
    (ControllerManager:GetController(ControllerTypeId.SectorController, true)):SetFrom(AreaConst.Exploration, nil, nil, lastSatgeData)
  end
, (util.cs_generator)(loadingFunc))
  elseif SceneName == (Consts.SceneName).Main then
    (UIManager:GetWindow(UIWindowTypeID.Loading)):SetLoadingTipsSystemId(1)
    ;
    ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Main, function(ok)
    -- function num : 0_35_2 , upvalues : _ENV, loadMainCallback, scenechangeCallback
    (ControllerManager:GetController(ControllerTypeId.HomeController, true)):OnEnterHome()
    UIManager:CreateWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_35_2_0 , upvalues : _ENV, loadMainCallback, scenechangeCallback
      if window == nil then
        return 
      end
      window:SetFrom2Home(AreaConst.Home, true)
      if loadMainCallback ~= nil then
        loadMainCallback()
      end
      if scenechangeCallback ~= nil then
        scenechangeCallback()
      end
    end
)
  end
)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC185: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.RestartExploratcion = function(self)
  -- function num : 0_36
  if self.restartInfo ~= nil then
    self:ReqEnterExploration((self.restartInfo).epId, (self.restartInfo).fomationId, (self.restartInfo).moduleId)
  end
end

-- DECOMPILER ERROR at PC188: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.ClearExploration = function(self)
  -- function num : 0_37 , upvalues : __ClearCurExploration
  self.dynPlayer = nil
  self.network = nil
  self.__isInExploration = false
  self.stageCfg = nil
  if self.epDataCenter ~= nil then
    (self.epDataCenter):CleanEpDataCenter()
    self.epDataCenter = nil
  end
  __ClearCurExploration(self)
end

-- DECOMPILER ERROR at PC191: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.Coordination2Pos = function(coordination)
  -- function num : 0_38 , upvalues : _ENV
  local x = coordination & CommonUtil.UInt16Max
  local y = coordination >> 16
  return x, y
end

-- DECOMPILER ERROR at PC194: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.XY2Coordination = function(x, y)
  -- function num : 0_39
  local coordination = y << 16 | x
  return coordination
end

-- DECOMPILER ERROR at PC197: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.ChipServerIdConvert = function(serverId)
  -- function num : 0_40
  local chipId = serverId >> 4
  local level = serverId & 15
  return chipId, level
end

-- DECOMPILER ERROR at PC200: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetCurLevelIndex = function(self)
  -- function num : 0_41
  return ((self.epCtrl).mapData).floorIdx
end

-- DECOMPILER ERROR at PC203: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetLevelCount = function(self)
  -- function num : 0_42
  return ((self.epCtrl).mapData).floor
end

-- DECOMPILER ERROR at PC206: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetReturnStamina = function(self)
  -- function num : 0_43 , upvalues : _ENV
  local levelCount = self:GetLevelCount()
  local remainLevelCount = levelCount - (self:GetCurLevelIndex() + 1)
  if self.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless and not (PlayerDataCenter.infinityData):IsInfinityDungeonCompleted((self:GetSectorStageCfg()).dungeonId) then
    return 0, remainLevelCount, 0
  end
  local costStamina = (self:GetSectorStageCfg()).cost_strength_num
  local returnStamina = (math.clamp)((math.floor)(costStamina - (ConfigData.game_config).retreatDeductStamina), 0, costStamina)
  local rewardReturnStamina = (math.floor)(costStamina * (remainLevelCount + (ConfigData.game_config).returnStaminaRatio / 1000) / levelCount)
  return returnStamina, remainLevelCount, costStamina, rewardReturnStamina
end

-- DECOMPILER ERROR at PC209: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetLastEpReturnStamina = function(self)
  -- function num : 0_44 , upvalues : _ENV
  local stageCfg = self:TryGetUncompletedEpSectorStateCfg()
  if stageCfg == nil then
    return 0
  end
  local levelCount = ((self.__lastEpData).epMap).floor
  local curLevelIdx = ((self.__lastEpData).epMap).floorIdx
  local remainLevelCount = levelCount - (curLevelIdx + 1)
  if ((self.__lastEpData).epMap).moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless and not (PlayerDataCenter.infinityData):IsInfinityDungeonCompleted(stageCfg.dungeonId) then
    return 0, remainLevelCount, 0
  end
  local costStamina = stageCfg.cost_strength_num
  local returnStamina = (math.clamp)((math.floor)(costStamina - (ConfigData.game_config).retreatDeductStamina), 0, costStamina)
  local rewardReturnStamina = (math.floor)(costStamina * (remainLevelCount + (ConfigData.game_config).returnStaminaRatio / 1000) / levelCount)
  return returnStamina, remainLevelCount, costStamina, rewardReturnStamina
end

-- DECOMPILER ERROR at PC212: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.HasNextLevel = function(self)
  -- function num : 0_45
  do return self:GetCurLevelIndex() < self:GetLevelCount() - 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC215: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.HasEpRewardBag = function(self, isUncompleteEp)
  -- function num : 0_46 , upvalues : _ENV
  local moduleId = nil
  -- DECOMPILER ERROR at PC8: Unhandled construct in 'MakeBoolean' P1

  if isUncompleteEp and self.__lastEpData ~= nil then
    moduleId = ((self.__lastEpData).epMap).moduleId
  end
  moduleId = self.moduleId
  local hasEpRewardBag = moduleId ~= nil and moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless
  do return hasEpRewardBag end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC218: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.WaitGetLastRoomEpRewardBag = function(self)
  -- function num : 0_47 , upvalues : _ENV
  -- DECOMPILER ERROR at PC17: Unhandled construct in 'MakeBoolean' P3

  local wait = (self.__lastEpData == nil or ExplorationManager:HasEpRewardBag(true)) and self:WaitGetLastEpRewardBag()
  do return wait end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC221: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.WaitGetLastEpRewardBag = function(self)
  -- function num : 0_48
  local wait = self.__lastEpData ~= nil and (self.__lastEpData).epStmGoods ~= nil and #((self.__lastEpData).epStmGoods).stmStore > 0
  do return wait end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC224: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.SettleDataDeal = function(self, msg)
  -- function num : 0_49 , upvalues : _ENV
  if msg.Count < 1 then
    error("can\'t get msg arg0")
    return 
  end
  local data = msg[0]
  if data.scoreShow ~= nil then
    local dungeonId = self.dungeonId
    if dungeonId == nil and self.__lastEpData ~= nil and (self.__lastEpData).epMap ~= nil then
      dungeonId = ((self.__lastEpData).epMap).dungeonId
    end
    ;
    (PlayerDataCenter.allWeeklyChallengeData):UpdateScoreInfo(dungeonId, (data.scoreShow).score, (data.scoreShow).reward)
  end
end

-- DECOMPILER ERROR at PC227: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetDynPlayer = function(self)
  -- function num : 0_50
  return self.dynPlayer
end

-- DECOMPILER ERROR at PC230: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetEpDataCenter = function(self)
  -- function num : 0_51
  return self.epDataCenter
end

-- DECOMPILER ERROR at PC233: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetEpFirstClearDic = function(self, stageId, moduleId)
  -- function num : 0_52 , upvalues : _ENV
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    if (PlayerDataCenter.sectorStage):IsStageComplete(stageId) then
      return table.emptytable
    end
    local stageCfg = (ConfigData.sector_stage)[stageId]
    if stageCfg == nil then
      error("sector stage is null,id:" .. tostring(stageId))
      return table.emptytable
    end
    local dic = {}
    for k,itemId in ipairs(stageCfg.first_reward_ids) do
      dic[itemId] = (stageCfg.first_reward_nums)[k]
    end
    return dic
  else
    do
      if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
        if (PlayerDataCenter.infinityData):IsInfinityDungeonCompleted(stageId) then
          return table.emptytable
        end
        local levelDic = ((ConfigData.endless).levelDic)[stageId]
        if levelDic == nil then
          error("Cant get endless.levelDic, stageId = " .. tostring(stageId))
          return table.emptytable
        end
        local endlessCfg = ((ConfigData.endless)[levelDic.sectorId])[levelDic.index]
        local dic = {}
        for index,rewardId in ipairs(endlessCfg.clear_reward_itemIds) do
          dic[rewardId] = (endlessCfg.clear_reward_itemNums)[index]
        end
        return dic
      else
        do
          error("Invalid moduleId:" .. tostring(moduleId))
          do return table.emptytable end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC236: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetEpSceneBattleFieldSize = function(self, floorId)
  -- function num : 0_53 , upvalues : _ENV
  return (ExplorationManager.__GetEpSceneBattleFieldSizeInternal)(self.floorId)
end

-- DECOMPILER ERROR at PC239: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.__GetEpSceneBattleFieldSizeInternal = function(floorId)
  -- function num : 0_54 , upvalues : _ENV
  local epCfg = (ConfigData.exploration)[floorId]
  if epCfg == nil then
    error("epCfg is null,floorId:" .. tostring(floorId))
    return 
  end
  local sceneCfg = (ConfigData.scene)[epCfg.scene_id]
  if sceneCfg == nil then
    error("scene cfg is null,scene_id:" .. tostring(epCfg.scene_id))
    return 
  end
  return sceneCfg.size_row, sceneCfg.size_col, sceneCfg.deploy_rows
end

-- DECOMPILER ERROR at PC242: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.RewardSort = function(self, rewardList)
  -- function num : 0_55 , upvalues : _ENV
  if rewardList == nil or #rewardList < 2 then
    return 
  end
  local sortDic = {[eItemType.Resource] = -10, [eItemType.Arithmetic] = -9, [eItemType.LimitRes] = -8, [eItemType.GrowUp] = -7, [eItemType.FactoryRes] = -6}
  local GetTypeSortId = function(typeId)
    -- function num : 0_55_0 , upvalues : sortDic
    local mappingId = sortDic[typeId]
    return mappingId ~= nil and mappingId or typeId
  end

  ;
  (table.sort)(rewardList, function(a, b)
    -- function num : 0_55_1 , upvalues : GetTypeSortId
    local aValue = (a.itemCfg).quality
    local bValue = (b.itemCfg).quality
    if bValue >= aValue then
      do return aValue == bValue end
      aValue = GetTypeSortId((a.itemCfg).type)
      bValue = GetTypeSortId((b.itemCfg).type)
      if aValue >= bValue then
        do return aValue == bValue end
        do return (b.itemCfg).id < (a.itemCfg).id end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
)
end

-- DECOMPILER ERROR at PC245: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetIsInWeeklyChallenge = function(self)
  -- function num : 0_56 , upvalues : _ENV
  do return self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC248: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.UpdateChipDataPreview = function(self)
  -- function num : 0_57 , upvalues : _ENV, ChipData
  local dic = self:GetChipPreviewByEpModuleId((self.restartInfo).moduleId, (self.restartInfo).epId)
  self.previewChipDataDic = {}
  self.previewChipDataList = {}
  for k,v in pairs(dic) do
    local level = nil
    if type(v) == "number" then
      level = v
    end
    local chipData = (ChipData.NewChipForLocal)(k, level)
    ;
    (table.insert)(self.previewChipDataList, chipData)
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.previewChipDataDic)[k] = chipData
  end
  ;
  (table.sort)(self.previewChipDataList, function(a, b)
    -- function num : 0_57_0
    local qualityA = a:GetQuality()
    local qualityB = b:GetQuality()
    do return qualityB < qualityA end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

-- DECOMPILER ERROR at PC251: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetChipDataPreview = function(self)
  -- function num : 0_58 , upvalues : _ENV
  if self.previewChipDataList == nil then
    error("previewChipDataList is nil")
    return table.emptytable
  end
  return self.previewChipDataList
end

-- DECOMPILER ERROR at PC254: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetChipDataPreviewDic = function(self, withoutError)
  -- function num : 0_59 , upvalues : _ENV
  if self.previewChipDataDic == nil then
    if not withoutError then
      error("previewChipDataDic is nil")
    end
    return table.emptytable
  end
  return self.previewChipDataDic
end

-- DECOMPILER ERROR at PC257: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetChipPreviewByEpModuleId = function(self, moduleId, stageId, param)
  -- function num : 0_60 , upvalues : _ENV
  local chip_dic = {}
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local stageCfg = (ConfigData.sector_stage)[stageId]
    for k,v in pairs(stageCfg.function_extra) do
      chip_dic[v] = true
    end
    local chip_pool_dic = {}
    for _,epId in pairs(stageCfg.exploration_list) do
      local epCfg = (ConfigData.exploration)[epId]
      if epCfg ~= nil then
        for _,poolId in pairs(epCfg.chip_pool) do
          chip_pool_dic[poolId] = true
          local funcPoolCfg = (ConfigData.ep_function_pool)[poolId]
          if funcPoolCfg ~= nil then
            for _,chipId in pairs(funcPoolCfg.function_pool) do
              chip_dic[chipId] = true
            end
          end
        end
      end
    end
  else
    do
      if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
        local levelDic = ((ConfigData.endless).levelDic)[stageId]
        local cfg = ((ConfigData.endless)[levelDic.sectorId])[levelDic.index]
        for k,v in pairs(cfg.chip) do
          chip_dic[v] = true
        end
      else
        do
          if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
            local chipList = (PlayerDataCenter.periodicChallengeData).dailyChipList
            if chipList ~= nil then
              for index,value in ipairs(chipList) do
                chip_dic[value] = true
              end
            end
          else
            do
              if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
                local chipDic = nil
                local weeklyData = ((PlayerDataCenter.allWeeklyChallengeData).dataDic)[stageId]
                if weeklyData ~= nil then
                  chipDic = weeklyData:GetWeeklyChanllengeChipDic()
                end
                if chipDic ~= nil then
                  chip_dic = chipDic
                end
              end
              do
                return chip_dic
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC260: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.TryToGetCurrentLevelInfo = function(self)
  -- function num : 0_61 , upvalues : _ENV
  local infoData = {}
  local moduleId = self:GetEpModuleId()
  local stageCfg = self:GetSectorStageCfg()
  infoData.moduleId = moduleId
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    infoData.sector = tostring(stageCfg.sector)
    infoData.num = tostring(stageCfg.num)
    infoData.difficulty = stageCfg.difficulty
  else
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
      local endlessCfg = stageCfg.endlessCfg
      infoData.name = tostring((LanguageUtil.GetLocaleText)(endlessCfg.name))
      infoData.index = tostring(endlessCfg.index * 10)
    else
      do
        if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
          infoData = nil
        end
        return infoData
      end
    end
  end
end

-- DECOMPILER ERROR at PC263: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.TryToShowCurrentLevelTips = function(self)
  -- function num : 0_62 , upvalues : _ENV, ExplorationEnum
  local hasHasUncompletedEp, dungeonId, moduleId = self:HasUncompletedEp()
  if not hasHasUncompletedEp then
    return 
  end
  local stageCfg = (self:TryGetUncompletedEpSectorStateCfg())
  local msg = nil
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local difficult = stageCfg.difficulty
    local strDiff = nil
    if difficult == (ExplorationEnum.eDifficultType).Normal then
      strDiff = ConfigData:GetTipContent(TipContent.DifficultyName_1)
    else
      if difficult == (ExplorationEnum.eDifficultType).Hard then
        strDiff = ConfigData:GetTipContent(TipContent.DifficultyName_2)
      else
        strDiff = ConfigData:GetTipContent(TipContent.DifficultyName_3)
      end
    end
    local sectorCfg = (ConfigData.sector)[stageCfg.sector]
    local strName = (LanguageUtil.GetLocaleText)(sectorCfg.name)
    local sectorShowId = ConfigData:GetSectorIdShow(stageCfg.sector)
    local strLv = tostring(sectorShowId) .. "-" .. tostring(stageCfg.num)
    msg = (string.format)(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2normal), strName, strLv, strDiff)
  else
    do
      if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
        local strName = (LanguageUtil.GetLocaleText)((stageCfg.endlessCfg).name)
        local strNum = tostring((stageCfg.endlessCfg).index * 10) .. "m"
        msg = (string.format)(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2endless), strName, strNum)
      else
        do
          if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
            msg = (string.format)(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2DailyAndWeekly), stageCfg.name)
          else
            msg = ConfigData:GetTipContent(TipContent.Sector_HasExpNotFinished)
          end
          self:TryGiveUpLastExploration(msg, stageCfg)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC266: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetMonsterLevelCfgs = function(self)
  -- function num : 0_63 , upvalues : _ENV
  local monsterLevelCfgs = nil
  local epModule = ExplorationManager:GetEpModuleId()
  if epModule == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    monsterLevelCfgs = ConfigData.monster_level
    if monsterLevelCfgs == nil then
      error("monster level cfg is null")
      return 
    end
  else
    if epModule == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
      local sectorCfg = ExplorationManager:GetSectorStageCfg()
      if sectorCfg == nil then
        error("can\'t get sectorCfg")
        return 
      end
      monsterLevelCfgs = sectorCfg.monster_level
      if monsterLevelCfgs == nil then
        error("monster level cfg is null")
        return 
      end
    else
      do
        if epModule == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
          local sectorCfg = ExplorationManager:GetSectorStageCfg()
          if sectorCfg == nil then
            error("can\'t get sectorCfg")
            return 
          end
          local endlessCfg = sectorCfg.endlessCfg
          if endlessCfg == nil then
            error("can\'t get endlessCfg")
            return 
          end
          monsterLevelCfgs = endlessCfg.monster_level
          if monsterLevelCfgs == nil then
            error("monster level cfg is null,level")
            return 
          end
        end
        do
          return monsterLevelCfgs
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC269: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.TryGiveUpLastExploration = function(self, msg, stageCfg)
  -- function num : 0_64 , upvalues : _ENV, cs_MessageCommon
  local addMsg = msg
  if addMsg == nil and (string.IsNullOrEmpty)(addMsg) then
    addMsg = ""
  else
    addMsg = addMsg .. "\n\n"
  end
  if self:HasEpRewardBag(true) then
    if self:WaitGetLastEpRewardBag() then
      if self:WaitGetLastRoomEpRewardBag() then
        (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(758), function()
    -- function num : 0_64_0 , upvalues : self
    self:GiveUpLastExploration()
  end
, nil)
        return 
      end
      ;
      (cs_MessageCommon.ShowMessageBox)(addMsg .. ConfigData:GetTipContent(753), function()
    -- function num : 0_64_1 , upvalues : self
    self:GiveUpLastExploration()
  end
, nil)
      return 
    end
    ;
    (cs_MessageCommon.ShowMessageBox)(addMsg .. ConfigData:GetTipContent(752), function()
    -- function num : 0_64_2 , upvalues : self
    self:GiveUpLastExploration()
  end
, nil)
    return 
  end
  local returnStamina = (self:GetLastEpReturnStamina())
  local msg = nil
  if returnStamina == 0 then
    msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
  else
    msg = (string.format)(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), tostring(returnStamina))
  end
  msg = addMsg .. msg
  ;
  (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_64_3 , upvalues : self
    self:GiveUpLastExploration()
  end
, nil)
end

-- DECOMPILER ERROR at PC272: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.IsInExplorationTD = function(self)
  -- function num : 0_65
  do return self:IsInExploration() and ((self.epCtrl ~= nil and ((self.epCtrl).mapData):IsEpTD())) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC275: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.IsInExplorationLight = function(self)
  -- function num : 0_66
  do return self:IsInExploration() and ((self.epCtrl ~= nil and ((self.epCtrl).mapData):IsEpLight())) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC278: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.HasRoomSceneInEp = function(self)
  -- function num : 0_67
  do return self:IsInExploration() and ((self.epCtrl ~= nil and ((self.epCtrl).mapData):IsEpDefault())) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC281: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetChipSuitMaxLevelDic = function(self)
  -- function num : 0_68 , upvalues : _ENV
  if self.dynPlayer ~= nil then
    local chipSuitList = (self.dynPlayer):GetChipSuitSortList()
    if chipSuitList == nil then
      return false, nil
    end
    local levelDic = {}
    for _,dynChipSuit in ipairs(chipSuitList) do
      local level = dynChipSuit:GetActivatedAffixCount()
      if level > 0 then
        levelDic[dynChipSuit.tagId] = level
      end
    end
    return true, levelDic
  else
    do
      if self.__lastEpData ~= nil then
        if (self.__lastEpData).epBackpack == nil or ((self.__lastEpData).epBackpack).algData == nil or (((self.__lastEpData).epBackpack).algData).alg == nil then
          return false, nil
        end
        local chipSuitCountDic = {}
        local chipIdDic = (((self.__lastEpData).epBackpack).algData).alg
        for chipId,_ in pairs(chipIdDic) do
          local chipCfg = (ConfigData.chip)[chipId]
          if chipCfg ~= nil and chipCfg.fun_tag ~= 0 then
            local suitId = chipCfg.fun_tag
            local suitCount = chipSuitCountDic[suitId] or 0
            chipSuitCountDic[suitId] = suitCount + 1
          end
        end
        local levelDic = {}
        for suitId,count in pairs(chipSuitCountDic) do
          local suitCfg = ((ConfigData.chip_tag).tag_suits)[suitId]
          if suitCfg ~= nil and #suitCfg ~= 0 then
            local level = 0
            for _,cfg in ipairs(suitCfg) do
              if cfg.number <= count then
                level = level + 1
              end
            end
            if level > 0 then
              levelDic[suitId] = level
            end
          end
        end
        return true, levelDic
      end
      do
        return false, nil
      end
    end
  end
end

-- DECOMPILER ERROR at PC284: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetSectorHeadTexture = function(self, sectorId, challengeId, detailType, resloader)
  -- function num : 0_69 , upvalues : _ENV, SectorLevelDetailEnum
  local path = nil
  if sectorId ~= nil then
    local sectorCfg = (ConfigData.sector)[sectorId]
    if sectorCfg ~= nil then
      path = PathConsts:GetSectorBackgroundPath(sectorCfg.pic_small)
    end
  else
    do
      if challengeId ~= nil and detailType == (SectorLevelDetailEnum.eDetailType).PeriodicChallenge then
        local challengeCfg = (ConfigData.daily_challenge)[challengeId]
        if challengeCfg ~= nil then
          path = PathConsts:GetSectorBackgroundPath(challengeCfg.pic_small)
        end
      else
        do
          if challengeId ~= nil and detailType == (SectorLevelDetailEnum.eDetailType).WeeklyChallenge then
            local challengeCfg = (ConfigData.weekly_challenge)[challengeId]
            if challengeCfg ~= nil then
              path = PathConsts:GetSectorBackgroundPath(challengeCfg.pic_small)
            end
          else
            do
              do return  end
              if (string.IsNullOrEmpty)(path) then
                return 
              end
              return resloader:LoadABAsset(path)
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC287: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.GetEpGuideActionList = function(self, roomX, moment)
  -- function num : 0_70 , upvalues : _ENV
  local epId = self:GetCurExplorationId()
  local epGuideCfg = (ConfigData.exploration_guide)[epId]
  if epGuideCfg ~= nil and epGuideCfg[roomX] ~= nil then
    local roomGuideCfg = epGuideCfg[roomX]
    local actionList = roomGuideCfg[moment]
    return actionList
  end
  do
    return nil
  end
end

-- DECOMPILER ERROR at PC290: Confused about usage of register: R17 in 'UnsetPending'

ExplorationManager.HasEpGuideActionList = function(self, roomX)
  -- function num : 0_71 , upvalues : _ENV
  local epId = self:GetCurExplorationId()
  local epGuideCfg = (ConfigData.exploration_guide)[epId]
  do
    if epGuideCfg ~= nil and epGuideCfg[roomX] ~= nil then
      local roomGuideCfg = epGuideCfg[roomX]
      if roomGuideCfg ~= nil and (table.count)(roomGuideCfg) > 0 then
        return true
      end
    end
    return false
  end
end

ExplorationManager:ctor()

