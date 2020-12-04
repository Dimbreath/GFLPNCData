-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationController = require("Game.Exploration.ExplorationController")
local DynEpMapData = require("Game.Exploration.MapData.DynEpMapData")
local DynPlayer = require("Game.Exploration.Data.DynPlayer")
local EpMvpData = require("Game.Exploration.Data.EpMvpData")
local CS_PlayerPrefs = (CS.UnityEngine).PlayerPrefs
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local util = require("XLua.Common.xlua_util")
local EpDataCenter = require("Game.Exploration.MapData.EpDataCenter")
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

-- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.ctor = function(self)
  -- function num : 0_2
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.IsInExploration = function(self)
  -- function num : 0_3
  return self.__isInExploration
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.IsInExplorationAndScene = function(self)
  -- function num : 0_4
  do return self.__isInExploration and ((self.epCtrl ~= nil and (self.epCtrl).loadSceneComplete)) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.ReqEnterExploration = function(self, epId, fomationId, moduleId, callback)
  -- function num : 0_5 , upvalues : _ENV
  self.__enterEpComplete = callback
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  ;
  (self.network):CS_EXPLORATION_Start(epId, fomationId, moduleId)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.RecvEnterExploration = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_StartFailure) .. tostring(msg.ret))
    MsgCenter:Broadcast(eMsgEventId.ExplorationEnterComplete, false)
    return 
  end
  self:__NewExploration(msg)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.__NewExploration = function(self, msg, isReconnect)
  -- function num : 0_7 , upvalues : EpDataCenter, _ENV, eDynConfigData, DynPlayer, EpMvpData
  self.restartInfo = {epId = (msg.epMap).dungeonId, fomationId = (msg.epForm).formId, moduleId = (msg.epMap).moduleId}
  self.moduleId = (msg.epMap).moduleId
  self.floorId = (msg.epMap).floorId
  if not isReconnect then
    isReconnect = false
  end
  self.epDataCenter = (EpDataCenter.New)()
  ;
  (self.epDataCenter):InitEpDataCenter()
  if self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local cfg = (ConfigData.sector_stage)[(msg.epMap).dungeonId]
    if cfg == nil then
      error("sector stage is null,id:" .. tostring(self.dungeonId))
      return 
    end
    self.stageCfg = cfg
    ;
    (self.epDataCenter):GetStageEpChipData(self.stageCfg)
  else
    do
      if self:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
        ConfigData:LoadDynCfg(eDynConfigData.endless)
        local endlessId = (msg.epMap).dungeonId
        local levelDic = ((ConfigData.endless).levelDic)[endlessId]
        local cfg = ((ConfigData.endless)[levelDic.sectorId])[levelDic.index]
        if cfg == nil then
          error("endlessCfg is null,endlessId:" .. tostring(endlessId))
          return 
        end
        self.stageCfg = {endlessCfg = cfg, size_row = cfg.size_row, size_col = cfg.size_col, deploy_rows = cfg.deploy_rows, name = cfg.name, sector = levelDic.sectorId, cost_strength_num = (cfg.cost_strength_itemNums)[1], difficulty = (ConfigData.sector_stage).difficultyCount + 1, dungeonId = endlessId, combat = cfg.combat}
        ConfigData:ReleaseDynCfg(eDynConfigData.endless)
        ;
        (self.epDataCenter):GetInfinityEpChipData(cfg)
      end
      do
        ;
        (NetworkManager:GetNetwork(NetworkTypeID.Sector)):SendChipSet()
        local cfg = (ConfigData.sector)[(self.stageCfg).sector]
        if cfg == nil then
          error("sector cfg is null,id:" .. tostring((self.stageCfg).sector))
          return 
        end
        self.sectorCfg = cfg
        self.dynPlayer = (DynPlayer.New)()
        ;
        (self.dynPlayer):CreateDefaultPlayer(msg.epForm)
        self:RequestDynPlayerAttr(function(battlePlaterData)
    -- function num : 0_7_0 , upvalues : self, msg, isReconnect, _ENV
    (self.dynPlayer):InitDynPlayerAttr(battlePlaterData)
    self:RequestHeroAttr(nil, function()
      -- function num : 0_7_0_0 , upvalues : self, msg, isReconnect, _ENV
      (self.dynPlayer):UpdateOperatorDetail(msg.epOp)
      ;
      (self.dynPlayer):UpdateEpEventData(msg.epOp)
      ;
      (self.dynPlayer):UpdateEpBackpack(msg.epBackpack)
      ;
      (self.dynPlayer):UpdateEpBuff(msg.epBuff)
      self:EnterCurSectionExploration(msg, isReconnect)
      MsgCenter:Broadcast(eMsgEventId.ExplorationEnterComplete, true)
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if self.__enterEpComplete ~= nil then
        (self.__enterEpComplete)()
        self.__enterEpComplete = nil
      end
      self.__isInExploration = true
    end
)
  end
)
        self.epMvpData = (EpMvpData.New)()
        if isReconnect then
          (self.epMvpData):AddServerSaveData((msg.epForm).data)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GetEpModuleId = function(self)
  -- function num : 0_8
  return self.moduleId
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GetSectorStageCfg = function(self)
  -- function num : 0_9
  return self.stageCfg
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GetSectorCfg = function(self)
  -- function num : 0_10
  return self.sectorCfg
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GetCurExplorationId = function(self)
  -- function num : 0_11
  return self.floorId
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.EnterCurSectionExploration = function(self, msg, isReconnect)
  -- function num : 0_12 , upvalues : __ClearCurExploration, _ENV, DynEpMapData, ExplorationController
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
  local opDetail = (self.dynPlayer):GetOperatorDetail((self:GetSectorStageCfg()).id)
  epMapData:InitMapData(msg.epMap, msg.epNext, opDetail)
  ;
  (self.dynPlayer):SetChipDiscardId((msg.epMap).discardId)
  self.epCtrl = (ExplorationController.New)(epMapData, self.dynPlayer)
  ;
  ((self.epCtrl).autoCtrl):SetDefaultAutoEp(needEnableAutoEp)
  if msg.epGrid ~= nil then
    (self.epCtrl):UpdateNextRoomInfo(msg.epGrid)
  end
  if msg.epResident ~= nil then
    (self.epCtrl):UpdateResidentDetail(msg.epResident)
  end
  ;
  (self.epCtrl):Start(isReconnect)
  ;
  (GR.SetIsOneTheEpMap)(true)
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.EnterNextSectionExploration = function(self)
  -- function num : 0_13 , upvalues : _ENV
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

-- DECOMPILER ERROR at PC67: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.OnEnterNextSectionExploration = function(self, msg)
  -- function num : 0_14 , upvalues : _ENV
  AudioManager:PlayAudioById(1028)
  self:EnterCurSectionExploration(msg)
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.RecordLastEpData = function(self, msg)
  -- function num : 0_15 , upvalues : _ENV
  self.__lastEpData = msg
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  local isComplete = false
  local hasHasUncompletedEp, dungeonId = ExplorationManager:HasUncompletedEp()
  if hasHasUncompletedEp then
    local x, y = (ExplorationManager.Coordination2Pos)((msg.epOp).curPostion)
    local nextPos = (ExplorationManager.XY2Coordination)(x + 1, y)
    if (msg.epOp).canFloorOver and ((msg.epMap).lineData)[(msg.epOp).curPostion] ~= nil and ((msg.epMap).lineData)[nextPos] == nil and (msg.epOp).state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over and (msg.epMap).floor <= (msg.epMap).floorIdx + 1 then
      (self.network):CS_EXPLORATION_Settle((msg.epOp).curPostion, true)
      isComplete = true
    end
    local stageCfg = self:TryGetUncompletedEpSectorStateCfg()
    ;
    (PlayerDataCenter.sectorStage):InitSelectStage(stageCfg.sector, stageCfg.difficulty)
  end
  do
    if isComplete then
      self.__lastEpData = nil
    end
    MsgCenter:Broadcast(eMsgEventId.OnHasUncompletedEp)
  end
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.HasUncompletedEp = function(self)
  -- function num : 0_16
  local has = self.__lastEpData ~= nil and (self.__lastEpData).epMap ~= nil
  if has then
    local moduleId = ((self.__lastEpData).epMap).moduleId
  end
  if has then
    local dungeonId = ((self.__lastEpData).epMap).dungeonId
  end
  do return has, dungeonId, moduleId end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.TryGetUncompletedEpSectorStateCfg = function(self)
  -- function num : 0_17 , upvalues : _ENV, eDynConfigData
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
          ConfigData:LoadDynCfg(eDynConfigData.endless)
          local levelDic = ((ConfigData.endless).levelDic)[dungeonId]
          local cfg = ((ConfigData.endless)[levelDic.sectorId])[levelDic.index]
          if cfg == nil then
            error("endlessCfg is null,endlessId:" .. tostring(dungeonId))
            return 
          end
          local stageCfg = {endlessCfg = cfg, size_row = cfg.size_row, size_col = cfg.size_col, deploy_rows = cfg.deploy_rows, name = cfg.name, sector = levelDic.sectorId, cost_strength_num = (cfg.cost_strength_itemNums)[1], difficulty = (ConfigData.sector_stage).difficultyCount + 1, dungeonId = dungeonId}
          ConfigData:ReleaseDynCfg(eDynConfigData.endless)
          return stageCfg
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.ContinueLastExploration = function(self, callback)
  -- function num : 0_18 , upvalues : _ENV
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

-- DECOMPILER ERROR at PC82: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.OnContinueLastExploration = function(self)
  -- function num : 0_19
  self:__NewExploration(self.__lastEpData, true)
  self.__lastEpData = nil
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GiveUpLastExploration = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if not self:HasUncompletedEp() then
    print("Last exploration data is null")
    return 
  end
  ;
  (self.network):CS_EXPLORATION_Settle(((self.__lastEpData).epOp).curPostion, false, true)
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.SendSettle = function(self, callback)
  -- function num : 0_21 , upvalues : _ENV
  if self.dynPlayer ~= nil then
    (self.network):CS_EXPLORATION_Settle(((self.dynPlayer):GetOperatorDetail()).curPostion, nil, nil, callback)
  else
    print("warning : dynPlayer is nil")
  end
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.SendFloorSettle = function(self, callback)
  -- function num : 0_22 , upvalues : _ENV
  if self.dynPlayer ~= nil then
    (self.network):CS_EXPLORATION_SettleFloor(((self.dynPlayer):GetOperatorDetail()).curPostion, callback)
  else
    print("warning : dynPlayer is nil")
  end
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.ExitExploration = function(self, SceneName, loadMainCallback)
  -- function num : 0_23 , upvalues : _ENV, util
  ((CS.BattleManager).Instance):ForceExitBattle()
  ;
  (BattleUtil.ResetBattleSetting)()
  MsgCenter:Broadcast(eMsgEventId.ExplorationExit)
  ;
  (self.network):CS_EXPLORATION_Detail()
  self:ClearExploration()
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Character)
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Monster)
  AudioManager:RemoveCueSheet(eAuCueSheet.CommonSkill)
  AudioManager:RemoveCueSheet(eAuCueSheet.Ambience)
  UIManager:DeleteAllWindow()
  ;
  ((CS.UIManager).Instance):DeleteAllWindow()
  if SceneName == nil or SceneName == (Consts.SceneName).Sector then
    local loadingFunc = function()
    -- function num : 0_23_0 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.Sector, nil)
    while UIManager:GetWindow(UIWindowTypeID.Sector) == nil do
      (coroutine.yield)(nil)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, nil)
    while UIManager:GetWindow(UIWindowTypeID.SectorLevel) == nil do
      (coroutine.yield)(nil)
    end
  end

    ;
    ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Sector, function()
    -- function num : 0_23_1 , upvalues : _ENV
    (ControllerManager:GetController(ControllerTypeId.SectorController, true)):SetFrom(AreaConst.Exploration)
  end
, (util.cs_generator)(loadingFunc))
  else
    do
      if SceneName == (Consts.SceneName).Main then
        ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Main, function(ok)
    -- function num : 0_23_2 , upvalues : _ENV, loadMainCallback
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_23_2_0 , upvalues : _ENV, loadMainCallback
      if window == nil then
        return 
      end
      window:SetFrom(AreaConst.Home)
      if loadMainCallback ~= nil then
        loadMainCallback()
      end
    end
)
  end
)
      end
    end
  end
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.RestartExploratcion = function(self)
  -- function num : 0_24
  if self.restartInfo ~= nil then
    self:ReqEnterExploration((self.restartInfo).epId, (self.restartInfo).fomationId, (self.restartInfo).moduleId)
  end
end

-- DECOMPILER ERROR at PC100: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.ClearExploration = function(self)
  -- function num : 0_25 , upvalues : __ClearCurExploration
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

-- DECOMPILER ERROR at PC103: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.Coordination2Pos = function(coordination)
  -- function num : 0_26 , upvalues : _ENV
  local x = coordination & CommonUtil.UInt16Max
  local y = coordination >> 16
  return x, y
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.XY2Coordination = function(x, y)
  -- function num : 0_27
  local coordination = y << 16 | x
  return coordination
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.RequestHeroAttr = function(self, heroIdDic, callback)
  -- function num : 0_28 , upvalues : _ENV
  if self.dynPlayer == nil then
    return 
  end
  if heroIdDic == nil then
    heroIdDic = {}
    for heroId,v in pairs((self.dynPlayer).heroDic) do
      heroIdDic[heroId] = true
    end
  end
  do
    if self.__onRequestHeroAttr == nil then
      self.__onRequestHeroAttr = BindCallback(self, self.OnRequestHeroAttr)
    end
    self.__requestHeroAttrEvent = callback
    if self.heroNetwork == nil then
      self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
    end
    ;
    (self.heroNetwork):CS_BATTLE_ReqHeroDetail(heroIdDic, self.__onRequestHeroAttr)
  end
end

-- DECOMPILER ERROR at PC112: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.OnRequestHeroAttr = function(self, objList)
  -- function num : 0_29 , upvalues : _ENV
  if self.dynPlayer == nil then
    return 
  end
  if objList.Count < 1 then
    error("objList ArgumentOutOfRange")
    return 
  end
  local heroBattleData = (objList[0]).battle
  ;
  (self.dynPlayer):UpdateHeroAttr(heroBattleData)
  if self.__requestHeroAttrEvent ~= nil then
    (self.__requestHeroAttrEvent)()
  end
end

-- DECOMPILER ERROR at PC115: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.RequestDynPlayerAttr = function(self, callback)
  -- function num : 0_30 , upvalues : _ENV
  if self.dynPlayer == nil then
    return 
  end
  if self.__onRecvDynPlayerAttr == nil then
    self.__onRecvDynPlayerAttr = BindCallback(self, self.OnRecvDynPlayerAttr)
  end
  self.__requestDynPlayerAttrEvent = callback
  if self.heroNetwork == nil then
    self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  end
  ;
  (self.heroNetwork):CS_BATTLE_ReqPlayerDetail(self.__onRecvDynPlayerAttr)
end

-- DECOMPILER ERROR at PC118: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.OnRecvDynPlayerAttr = function(self, objList)
  -- function num : 0_31 , upvalues : _ENV
  if self.dynPlayer == nil then
    return 
  end
  if objList.Count < 1 then
    error("objList ArgumentOutOfRange")
    return 
  end
  if (objList[0]).player == nil then
    error("proto_msg_SC_BATTLE_ReqPlayerDetail msg.player is nil")
    return 
  end
  if self.__requestDynPlayerAttrEvent ~= nil then
    (self.__requestDynPlayerAttrEvent)((objList[0]).player)
  end
end

-- DECOMPILER ERROR at PC121: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GetCurLevelIndex = function(self)
  -- function num : 0_32
  return ((self.epCtrl).mapData).floorIdx
end

-- DECOMPILER ERROR at PC124: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GetLevelCount = function(self)
  -- function num : 0_33
  return ((self.epCtrl).mapData).floor
end

-- DECOMPILER ERROR at PC127: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GetReturnStamina = function(self)
  -- function num : 0_34 , upvalues : _ENV
  local levelCount = self:GetLevelCount()
  local remainLevelCount = levelCount - (self:GetCurLevelIndex() + 1)
  if self.moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless and not ((PlayerDataCenter.infinityData).completed)[(self:GetSectorStageCfg()).dungeonId] then
    return 0, remainLevelCount, 0
  end
  local costStamina = (self:GetSectorStageCfg()).cost_strength_num
  local returnStamina = (math.floor)(costStamina * (remainLevelCount + (ConfigData.game_config).ReturnStaminaRatio / 1000) / levelCount)
  return returnStamina, remainLevelCount, costStamina
end

-- DECOMPILER ERROR at PC130: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GetLastEpReturnStamina = function(self)
  -- function num : 0_35 , upvalues : _ENV
  local stageCfg = self:TryGetUncompletedEpSectorStateCfg()
  if stageCfg == nil then
    return 0
  end
  local levelCount = ((self.__lastEpData).epMap).floor
  local curLevelIdx = ((self.__lastEpData).epMap).floorIdx
  local remainLevelCount = levelCount - (curLevelIdx + 1)
  if ((self.__lastEpData).epMap).moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless and not ((PlayerDataCenter.infinityData).completed)[stageCfg.dungeonId] then
    return 0, remainLevelCount, 0
  end
  local costStamina = stageCfg.cost_strength_num
  local returnStamina = (math.floor)(costStamina * (remainLevelCount + (ConfigData.game_config).ReturnStaminaRatio / 1000) / levelCount)
  return returnStamina, remainLevelCount, costStamina
end

-- DECOMPILER ERROR at PC133: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.HasNextLevel = function(self)
  -- function num : 0_36
  do return self:GetCurLevelIndex() < self:GetLevelCount() - 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC136: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GetDynPlayer = function(self)
  -- function num : 0_37
  return self.dynPlayer
end

-- DECOMPILER ERROR at PC139: Confused about usage of register: R10 in 'UnsetPending'

ExplorationManager.GetEpDataCenter = function(self)
  -- function num : 0_38
  return self.epDataCenter
end

ExplorationManager:ctor()

