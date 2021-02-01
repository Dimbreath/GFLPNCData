-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonTypeData = class("DungeonTypeData")
local DungeonData = require("Game.Dungeon.DungeonData")
DungeonTypeData.eDungeonType = {none = 0, fragDungeon = 1, matDungeon = 2, ATHDungeon = 3}
DungeonTypeData.systemFunctionID4DungeonType = {[(DungeonTypeData.eDungeonType).fragDungeon] = proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui, [(DungeonTypeData.eDungeonType).matDungeon] = proto_csmsg_SystemFunctionID.SystemFunctionID_MaterialDungeon, [(DungeonTypeData.eDungeonType).ATHDungeon] = proto_csmsg_SystemFunctionID.SystemFunctionID_ATHDungeon}
DungeonTypeData.CreateDungeonTypeData = function(eDungeonType)
  -- function num : 0_0 , upvalues : DungeonTypeData, _ENV, DungeonData
  local systemFuncId = (DungeonTypeData.systemFunctionID4DungeonType)[eDungeonType]
  local isUnlock, unlockDes = nil, nil
  isUnlock = FunctionUnlockMgr:ValidateUnlock(systemFuncId)
  if not isUnlock then
    unlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(systemFuncId)
  end
  local data = (DungeonTypeData.New)()
  data.dungeonType = eDungeonType
  data.isUnlock = isUnlock
  data.unlockDes = unlockDes
  data.systemFuncId = systemFuncId
  if eDungeonType == (DungeonTypeData.eDungeonType).fragDungeon then
    for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
      local dungeonData = (DungeonData.CreateDungeonData4Frage)(data, heroData)
      ;
      (table.insert)(data.dungeonDataList, dungeonData)
    end
    ;
    (table.sort)(data.dungeonDataList, function(dungeonA, dungeonB)
    -- function num : 0_0_0
    local heroIdA = dungeonA.itemId
    local heroIdB = dungeonB.itemId
    local isUnlockA = dungeonA:GetIsUnlock()
    local isUnlockB = dungeonB:GetIsUnlock()
    if heroIdA >= heroIdB then
      do return isUnlockA ~= isUnlockB end
      do return isUnlockA end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  else
    for dungeonId,cfg in pairs(ConfigData.material_dungeon) do
      if cfg.ui_type == eDungeonType then
        local dungeonData = (DungeonData.CreateDungeonData)(data, cfg)
        ;
        (table.insert)(data.dungeonDataList, dungeonData)
      end
    end
    ;
    (table.sort)(data.dungeonDataList, function(dungeonA, dungeonB)
    -- function num : 0_0_1
    local IdA = dungeonA:GetDungeonId()
    local IdB = dungeonB:GetDungeonId()
    do return IdA < IdB end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  return data
end

DungeonTypeData.ctor = function(self)
  -- function num : 0_1 , upvalues : DungeonTypeData
  self.dungeonType = (DungeonTypeData.eDungeonType).none
  self.systemFuncId = nil
  self.isUnlock = false
  self.unlockDes = nil
  self.dungeonDataList = {}
end

DungeonTypeData.Update = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(self.systemFuncId)
  self.isUnlock = isUnlock
  if isUnlock and self.unlockDes ~= nil then
    self.unlockDes = nil
  end
end

DungeonTypeData.UpdateDungeonAndStageUnlock = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for _,dungeonData in pairs(self.dungeonDataList) do
    dungeonData:__UpdateIsUnlock()
    if dungeonData:GetIsUnlock() then
      for _,dungeonStageData in pairs(dungeonData:GetDungeonStageList()) do
        dungeonStageData:__UpdateStage()
      end
    end
  end
end

DungeonTypeData.GetDungeonType = function(self)
  -- function num : 0_4
  return self.dungeonType
end

DungeonTypeData.GetDungeonTypeSystemFuncId = function(self)
  -- function num : 0_5
  return self.systemFuncId
end

DungeonTypeData.GetDungeonTypeIsUnlock = function(self)
  -- function num : 0_6
  return self.isUnlock
end

DungeonTypeData.GetDungeonTypeUnlockDes = function(self)
  -- function num : 0_7
  return self.unlockDes
end

DungeonTypeData.GetDungeonDataList = function(self)
  -- function num : 0_8
  return self.dungeonDataList
end

DungeonTypeData.GetDungeonTypePlayLimit = function(self)
  -- function num : 0_9 , upvalues : DungeonTypeData, _ENV
  local limit = 0
  local systemFunctionID = self.systemFuncId
  if self.dungeonType == (DungeonTypeData.eDungeonType).fragDungeon then
    local cfgLimit = ((ConfigData.material_dungeon)[proto_csmsg_SystemFunctionID.SystemFunctionID_friendship]).frequency_day
    if cfgLimit == -1 then
      return -1
    end
    limit = limit + cfgLimit
    limit = limit + ((PlayerDataCenter.playerBonus):GetDungeonCountAdd(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship) or 0)
  else
    do
      for _,dungeonData in ipairs(self.dungeonDataList) do
        local dungeonLimit = dungeonData:GetDungeonPlayLimit()
        if dungeonLimit == -1 then
          return -1
        end
        limit = limit + dungeonLimit
      end
      do
        limit = limit + ((PlayerDataCenter.playerBonus):GetDungeonCountAdd(systemFunctionID) or 0)
        return limit
      end
    end
  end
end

DungeonTypeData.GetDungeonTypePlayedNum = function(self)
  -- function num : 0_10 , upvalues : DungeonTypeData, _ENV
  local playedNums = 0
  local systemFunctionID = self.systemFuncId
  -- DECOMPILER ERROR at PC24: Unhandled construct in 'MakeBoolean' P1

  if self.dungeonType == (DungeonTypeData.eDungeonType).fragDungeon and PlayerDataCenter.dungeonDailyBattleTimes ~= nil and (PlayerDataCenter.dungeonDailyBattleTimes)[proto_csmsg_SystemFunctionID.SystemFunctionID_friendship] ~= nil then
    local usedData = ((PlayerDataCenter.dungeonDailyBattleTimes)[proto_csmsg_SystemFunctionID.SystemFunctionID_friendship]).data
    for k,v in pairs(usedData) do
      if v ~= nil then
        playedNums = playedNums + v
      end
    end
  end
  do
    for _,dungeonData in ipairs(self.dungeonDataList) do
      local dungeonPlayedNums = dungeonData:GetDungeonPlayedNum()
      playedNums = playedNums + dungeonPlayedNums
    end
    do
      return playedNums
    end
  end
end

DungeonTypeData.GetDungeonTypePlayLeftLimitNum = function(self)
  -- function num : 0_11
  local totaleLimit = self:GetDungeonTypePlayLimit()
  if totaleLimit == -1 then
    return -1
  end
  local playedNums = self:GetDungeonTypePlayedNum()
  return totaleLimit - playedNums, totaleLimit, playedNums
end

DungeonTypeData.GetIsHaveDouble = function(self)
  -- function num : 0_12 , upvalues : _ENV
  for _,dungeonData in ipairs(self.dungeonDataList) do
    if dungeonData:GetIsDungeonDouble() then
      return true
    end
  end
  return false
end

DungeonTypeData.Delete = function(self)
  -- function num : 0_13
end

return DungeonTypeData

