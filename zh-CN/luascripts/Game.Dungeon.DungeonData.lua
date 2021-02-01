-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonData = class("DungeonData")
local DungeonStageData = require("Game.Dungeon.DungeonStageData")
local SortFunc = function(a, b)
  -- function num : 0_0
  do return a:GetDungeonStageId() < b:GetDungeonStageId() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DungeonData.CreateDungeonData = function(dungeonTypeData, dungeonCfg)
  -- function num : 0_1 , upvalues : DungeonData, _ENV, DungeonStageData, SortFunc
  local data = (DungeonData.New)()
  data.dungeonId = dungeonCfg.id
  data.systemFunctionId = dungeonCfg.id
  data.dungeonTypeData = dungeonTypeData
  data.dungeonCfg = dungeonCfg
  if dungeonCfg.stage_type ~= 0 then
    data.subTitleId = dungeonCfg.stage_type
  end
  data:__UpdateIsUnlock()
  if data:GetIsUnlock() then
    data.dungeonStageList = {}
    for _,dungeonStageId in ipairs(dungeonCfg.stage_id) do
      local cfg = (ConfigData.battle_dungeon)[dungeonStageId]
      if cfg == nil then
        error("read battle_dungeon error stageId:" .. dungeonStageId)
      else
        local dungeonStageData = (DungeonStageData.CreateDungeonStageData)(data, cfg)
        ;
        (table.insert)(data.dungeonStageList, dungeonStageData)
      end
    end
    ;
    (table.sort)(data.dungeonStageList, SortFunc)
  end
  return data
end

DungeonData.CreateDungeonData4Frage = function(dungeonTypeData, heroData)
  -- function num : 0_2 , upvalues : DungeonData, _ENV, DungeonStageData
  local data = (DungeonData.New)()
  data.isFrageDungeon = true
  data.dungeonId = proto_csmsg_SystemFunctionID.SystemFunctionID_friendship
  data.systemFunctionId = proto_csmsg_SystemFunctionID.SystemFunctionID_friendship
  data.dungeonTypeData = dungeonTypeData
  data.dungeonCfg = nil
  data.heroData = heroData
  data.itemId = heroData.dataId
  data.sortParam = heroData.camp
  data:__UpdateIsUnlock()
  if data:GetIsUnlock() then
    data.dungeonStageList = {}
    for _,dungeonStageId in ipairs(((ConfigData.friendship_hero)[heroData.dataId]).plot_stage) do
      local cfg = (ConfigData.battle_dungeon)[dungeonStageId]
      if cfg == nil then
        error("read battle_dungeon error stageId:" .. dungeonStageId)
      else
        local dungeonStageData = (DungeonStageData.CreateDungeonStageData)(data, cfg)
        ;
        (table.insert)(data.dungeonStageList, dungeonStageData)
      end
    end
  end
  do
    return data
  end
end

DungeonData.ctor = function(self)
  -- function num : 0_3
  self.dungeonTypeData = nil
  self.dungeonId = nil
  self.systemFunctionId = nil
  self.dungeonCfg = nil
  self.isUnlock = false
  self.dungeonStageList = {}
  self.subTitleId = nil
  self.isFrageDungeon = nil
  self.heroData = nil
  self.itemId = nil
  self.sortParam = nil
end

DungeonData.__UpdateIsUnlock = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if #((ConfigData.friendship_hero)[(self.heroData).dataId]).plot_stage <= 0 then
    self.isUnlock = not self.isFrageDungeon
    do return  end
    self.isUnlock = FunctionUnlockMgr:ValidateUnlock(self.systemFunctionId)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

DungeonData.CleanCacheData = function(self)
  -- function num : 0_5
  self.__isDoubleNoLimit = nil
end

DungeonData.CalUnLockedAndProgress = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for index,dungeonStageData in ipairs(self.dungeonStageList) do
    dungeonStageData:__UpdateStage()
  end
end

DungeonData.GetDungeonSystemFunctionId = function(self)
  -- function num : 0_7
  return self.systemFunctionId
end

DungeonData.GetDungeonId = function(self)
  -- function num : 0_8
  return self.dungeonId
end

DungeonData.GetIsUnlock = function(self)
  -- function num : 0_9
  return self.isUnlock
end

DungeonData.GetDungeonUnlockDes = function(self)
  -- function num : 0_10 , upvalues : _ENV
  return FunctionUnlockMgr:GetFuncUnlockDecription(self.systemFunctionId, true)
end

DungeonData.GetDungeonCfg = function(self)
  -- function num : 0_11
  return self.dungeonCfg
end

DungeonData.GetSubTitleId = function(self)
  -- function num : 0_12
  return self.subTitleId
end

DungeonData.GetDungeonHeroData = function(self)
  -- function num : 0_13
  return self.heroData
end

DungeonData.GetDungeonName = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self.isFrageDungeon then
    return (self.heroData):GetName(), (self.heroData):GetEnName()
  else
    return (LanguageUtil.GetLocaleText)((self.dungeonCfg).name), (LanguageUtil.GetLocaleText)((self.dungeonCfg).name_en)
  end
end

DungeonData.GetDungeonStageList = function(self)
  -- function num : 0_15
  return self.dungeonStageList
end

DungeonData.GetDungeonStageCount = function(self)
  -- function num : 0_16
  return #self.dungeonStageList
end

DungeonData.GetDungeonStageCompletedCount = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local completedCount = 0
  for index,dungeonStageData in ipairs(self.dungeonStageList) do
    if dungeonStageData:GetDungeonStageIsCompleted() then
      completedCount = completedCount + 1
    end
  end
  return completedCount
end

DungeonData.GetDungeonPlayLimit = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local limit = 0
  local cfgLimit = ((ConfigData.material_dungeon)[self.dungeonId]).frequency_day
  if cfgLimit == -1 then
    return -1
  end
  limit = limit + cfgLimit
  limit = limit + ((PlayerDataCenter.playerBonus):GetDungeonCountAdd(self.systemFunctionId) or 0)
  return limit
end

DungeonData.GetDungeonPlayedNum = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local playedNums = 0
  if PlayerDataCenter.dungeonDailyBattleTimes ~= nil and (PlayerDataCenter.dungeonDailyBattleTimes)[self.systemFunctionId] ~= nil then
    local usedData = ((PlayerDataCenter.dungeonDailyBattleTimes)[self.systemFunctionId]).data
    for k,v in pairs(usedData) do
      if v ~= nil then
        playedNums = playedNums + v
      end
    end
  end
  do
    return playedNums
  end
end

DungeonData.GetDungeonPlayLeftLimitNum = function(self)
  -- function num : 0_20
  local totaleLimit = self:GetDungeonPlayLimit()
  if totaleLimit == -1 then
    return -1
  end
  local playedNums = self:GetDungeonPlayedNum()
  return totaleLimit - playedNums, totaleLimit, playedNums
end

DungeonData.GetIsDungeonDouble = function(self)
  -- function num : 0_21
  if not self:GetIsDungeonDoubleWithLimit() then
    return self:GetIsDungeonDoubleNoLimit()
  end
end

DungeonData.GetIsDungeonDoubleNoLimit = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if self.__isDoubleNoLimit == nil then
    local stageDungeonStypDic = {}
    for _,dungeonStage in ipairs(self.dungeonStageList) do
      stageDungeonStypDic[dungeonStage:GetDungeonSeverType()] = true
    end
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
    local weekNum = timePassCtrl:GetLogicWeekNum()
    if weekNum == nil then
      self.__isDoubleNoLimit = false
      return false
    else
      local logics = (PlayerDataCenter.serverLogic)[eLogicType.DungeonRewardRate]
      if logics == nil then
        self.__isDoubleNoLimit = false
        return false
      end
      for _,logic in pairs(logics) do
        if stageDungeonStypDic[logic[1]] and logic[2] == weekNum then
          self.__isDoubleNoLimit = true
          return true
        end
      end
    end
  end
  do
    return self.__isDoubleNoLimit
  end
end

DungeonData.GetIsDungeonDoubleWithLimit = function(self)
  -- function num : 0_23
  local double = self:GetDungeonDoubleWithLimit()
  if double == -1 then
    return true
  end
  do return self:GetDungeonThisCyclePlayedNum() < self:GetDungeonDoubleWithLimit() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DungeonData.GetDungeonDoubleWithLimit = function(self)
  -- function num : 0_24
  if self.isFrageDungeon then
    return 0
  end
  return (self.dungeonCfg).double
end

DungeonData.GetDungeonThisCyclePlayedNum = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local dailyPlayedNum = 0
  for _,dungeonStage in ipairs(self.dungeonStageList) do
    dailyPlayedNum = dailyPlayedNum + dungeonStage:GetThisCyclePlayedNum()
  end
  return dailyPlayedNum
end

DungeonData.Update = function(self)
  -- function num : 0_26
end

DungeonData.Delete = function(self)
  -- function num : 0_27
end

return DungeonData

