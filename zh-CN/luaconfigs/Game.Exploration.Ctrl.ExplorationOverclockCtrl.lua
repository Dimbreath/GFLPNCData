-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationOverclockCtrl = class("ExplorationOverclockCtrl", ExplorationCtrlBase)
ExplorationOverclockCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.__getUnlokChipSet = BindCallback(self, self.GetUnlokChipSet)
  MsgCenter:AddListener(eMsgEventId.SectorChipSet, self.__getUnlokChipSet)
  self.__SyncOverclockData = BindCallback(self, self.SyncOverclockData)
  MsgCenter:AddListener(eMsgEventId.OnEpOverclockDiff, self.__SyncOverclockData)
end

ExplorationOverclockCtrl.InitEpOverclockCtrl = function(self, overclockData)
  -- function num : 0_1 , upvalues : _ENV
  local moduleId = ExplorationManager:GetEpModuleId()
  local dungeonId = ExplorationManager:GetEpDungeonId()
  local isUnlock = false
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    isUnlock = true
  else
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
      isUnlock = true
    end
  end
  if isUnlock then
    isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_OverClock)
  end
  if not isUnlock or overclockData == nil then
    self.__hasOverclock = false
    return 
  end
  self.__hasOverclock = true
  self.__dungeonId = dungeonId
  self.__unlockChipSetTable = {}
  self.__curAssembleNum = 0
  self.__maxAssembleNum = (ConfigData.game_config).OverclockLimtNum
  self:__GetStageAllChips(moduleId)
  self:__GenOverClockOptionDatas()
  self:SyncOverclockData(overclockData)
end

ExplorationOverclockCtrl.SyncOverclockData = function(self, overclockData)
  -- function num : 0_2 , upvalues : _ENV
  self.__clockData = overclockData
  if overclockData.overclock ~= nil then
    self.__useOverclockList = (overclockData.overclock).data
  else
    self.__useOverclockList = {}
  end
  self.__curAssembleNum = (table.count)(self.__useOverclockList)
  MsgCenter:Broadcast(eMsgEventId.UpdateEpOverclock)
end

ExplorationOverclockCtrl.ShowEpOverclockUI = function(self, showMoney)
  -- function num : 0_3 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.OverClock, function(clockWindow)
    -- function num : 0_3_0 , upvalues : self, showMoney
    if clockWindow == nil then
      return 
    end
    clockWindow:InitOverclockUI(self, showMoney)
  end
)
end

ExplorationOverclockCtrl.UseOverclockOption = function(self, clockId, level)
  -- function num : 0_4
  ((self.epCtrl).epNetwork):CS_EXPLORATION_OVERCLOCK_BUY(clockId, level)
end

ExplorationOverclockCtrl.UseOverclockOptionWithChipId = function(self, clockId, level, chipId)
  -- function num : 0_5
  ((self.epCtrl).epNetwork):CS_EXPLORATION_OVERCLOCK_BUY(clockId, level, chipId)
end

ExplorationOverclockCtrl.IsLevelHasOverclock = function(self)
  -- function num : 0_6
  return self.__hasOverclock
end

ExplorationOverclockCtrl.GetIsHaveFree = function(self)
  -- function num : 0_7
  do return (self.__clockData).freeCnt > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ExplorationOverclockCtrl.GetLastFreeNum = function(self)
  -- function num : 0_8
  return (self.__clockData).freeCnt
end

ExplorationOverclockCtrl.GetClockAssembleNum = function(self)
  -- function num : 0_9
  return self.__curAssembleNum, self.__maxAssembleNum
end

ExplorationOverclockCtrl.IsUseClockLimit = function(self)
  -- function num : 0_10
  do return self.__maxAssembleNum <= self.__curAssembleNum end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ExplorationOverclockCtrl.IsUseOverclockOption = function(self, clockId)
  -- function num : 0_11
  do return (self.__useOverclockList)[clockId] ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ExplorationOverclockCtrl.__GenOverClockOptionDatas = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self.__clockOptionDatas = {}
  local OCDatas = {}
  for overclockId,cfgs in pairs(ConfigData.overclock) do
    local lv1Cfg = cfgs[1]
    local data = {}
    data.overclockId = overclockId
    data.isUnlock = (CheckCondition.CheckLua)(lv1Cfg.pre_condition, lv1Cfg.pre_para1, lv1Cfg.pre_para2)
    if data.isUnlock then
      data.overclockLevel = (PlayerDataCenter.playerBonus):GetOverClock(overclockId)
      if data.overclockLevel <= 0 then
        error("overclock option level blow 0, pls check common logic init.")
      end
    else
      data.unlockDes = (CheckCondition.GetUnlockInfoLua)(lv1Cfg.pre_condition, lv1Cfg.pre_para1, lv1Cfg.pre_para2)
    end
    ;
    (table.insert)(OCDatas, data)
  end
  ;
  (table.sort)(OCDatas, function(a, b)
    -- function num : 0_12_0
    if a.isUnlock ~= b.isUnlock then
      return a.isUnlock
    end
    do return a.overclockId < b.overclockId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self.__clockOptionDatas = OCDatas
end

ExplorationOverclockCtrl.GetOverclockOptions = function(self)
  -- function num : 0_13
  return self.__clockOptionDatas
end

ExplorationOverclockCtrl.__GetStageAllChips = function(self, fromModule)
  -- function num : 0_14 , upvalues : _ENV
  self.__levelchipDic = {}
  if fromModule == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local sectorStageCfg = (ConfigData.sector_stage)[self.__dungeonId]
    if sectorStageCfg == nil then
      return 
    end
    for _,epId in pairs(sectorStageCfg.exploration_list) do
      local epCfg = (ConfigData.exploration)[epId]
      if epCfg ~= nil then
        for _,poolId in pairs(epCfg.chip_pool) do
          local funcPoolCfg = (ConfigData.ep_function_pool)[poolId]
          if funcPoolCfg ~= nil then
            for _,chipId in pairs(funcPoolCfg.function_pool) do
              -- DECOMPILER ERROR at PC36: Confused about usage of register: R20 in 'UnsetPending'

              (self.__levelchipDic)[chipId] = true
            end
          end
        end
      end
    end
  else
    do
      if fromModule == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
        local endlessLevel = ((ConfigData.endless).levelDic)[self.__dungeonId]
        if endlessLevel == nil then
          return 
        end
        local endlessCfg = ((ConfigData.endless)[endlessLevel.sectorId])[endlessLevel.index]
        if endlessCfg == nil then
          return 
        end
        local chips = endlessCfg.chip
        if chips == nil then
          return 
        end
        for _,chipId in ipairs(chips) do
          -- DECOMPILER ERROR at PC74: Confused about usage of register: R10 in 'UnsetPending'

          (self.__levelchipDic)[chipId] = true
        end
      end
    end
  end
end

ExplorationOverclockCtrl.GetClockAllChipDic = function(self)
  -- function num : 0_15
  return self.__levelchipDic
end

ExplorationOverclockCtrl.GetUnlokChipSet = function(self, chipSetTab)
  -- function num : 0_16
  self.__unlockChipSetTable = chipSetTab
end

ExplorationOverclockCtrl.OnDelete = function(self)
  -- function num : 0_17 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.SectorChipSet, self.__getUnlokChipSet)
  MsgCenter:RemoveListener(eMsgEventId.OnEpOverclockDiff, self.__SyncOverclockData)
end

return ExplorationOverclockCtrl

