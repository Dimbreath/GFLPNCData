local DungeonDyncData = class("DungeonDyncData")
local DungeonTypeData = require("Game.Dungeon.DungeonTypeData")
local DungeonDyncElemData = require("Game.Dungeon.DungeonDyncElemData")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local FormationUtil = require("Game.Formation.FormationUtil")
DungeonDyncData.ctor = function(self)
  -- function num : 0_0
  self.dungeonDyncDataDic = {}
end

DungeonDyncData.UpdDungeonDyncData = function(self, dungeonDync)
  -- function num : 0_1 , upvalues : _ENV, DungeonDyncElemData
  local removeDic = {}
  for k,v in pairs(self.dungeonDyncDataDic) do
    if dungeonDync[k] == nil then
      removeDic[k] = true
    end
  end
  for k,v in pairs(removeDic) do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R8 in 'UnsetPending'

    (self.dungeonDyncDataDic)[k] = nil
  end
  for k,v in pairs(dungeonDync) do
    local elem = (self.dungeonDyncDataDic)[k]
    if elem == nil then
      elem = (DungeonDyncElemData.New)()
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.dungeonDyncDataDic)[k] = elem
    end
    elem:UpdDungeonDyncElemData(v)
  end
  self:_ClearDailyDgHero()
  self:ClearDailyDgFmtFriendSupportHeroDataCache()
end

DungeonDyncData.GetDailyDungeonDyncData = function(self)
  -- function num : 0_2 , upvalues : _ENV, eDungeonEnum, DungeonDyncElemData
  local dungeonUITypeDic = (ConfigData.material_dungeon).dungeonUITypeDic
  local dungeonIdList = dungeonUITypeDic[(eDungeonEnum.eDungeonType).DailyDungeon]
  if dungeonIdList == nil then
    error("Cant get dungeonUITypeDic, eDungeonEnum.eDungeonType.DailyDungeon")
    return 
  end
  for k,dungeonId in ipairs(dungeonIdList) do
    if (self.dungeonDyncDataDic)[dungeonId] ~= nil then
      return (self.dungeonDyncDataDic)[dungeonId]
    end
  end
  local moduleId = dungeonIdList[1]
  local dungeonDyncElemData = (DungeonDyncElemData.CreateDefaultDungeonDyncElemData)(moduleId)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.dungeonDyncDataDic)[dungeonDyncElemData.moduleId] = dungeonDyncElemData
  return dungeonDyncElemData
end

DungeonDyncData._ClearDailyDgHero = function(self)
  -- function num : 0_3 , upvalues : _ENV, FormationUtil
  local dungeonDyncElem = (PlayerDataCenter.dungeonDyncData):GetDailyDungeonDyncData()
  local fmtIdOffset = (FormationUtil.GetFmtIdOffsetByDungeonType)(proto_csmsg_DungeonType.DungeonType_Daily)
  for i = 1, (ConfigData.game_config).formationCount do
    local fmtId = i + fmtIdOffset
    local formationData = (PlayerDataCenter.formationDic)[fmtId]
    if formationData ~= nil then
      local deadHeroIdxList = {}
      local heroIdData = formationData.data
      for idx,heroId in pairs(heroIdData) do
        if (dungeonDyncElem.charHpPer)[heroId] == 0 then
          (table.insert)(deadHeroIdxList, idx)
        end
      end
      for k,idx in ipairs(deadHeroIdxList) do
        heroIdData[idx] = nil
      end
      do
        do
          if not dungeonDyncElem:HasDgDyncLastAstHero() or dungeonDyncElem:GetDgDyncLastAstHeroHpPer() == 0 then
            formationData:CleanSupportData()
          end
          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

DungeonDyncData.GetDailyDungeonState = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dungeonDyncElemData = self:GetDailyDungeonDyncData()
  if dungeonDyncElemData.isDailyDungeonNew then
    return false, false
  end
  local matDungeonCfg = (ConfigData.material_dungeon)[dungeonDyncElemData.moduleId]
  if matDungeonCfg == nil then
    error("Cant get ConfigData.material_dungeon, id : " .. tostring(dungeonDyncElemData.moduleId))
    return false, false
  end
  local isFinish = #matDungeonCfg.stage_id <= dungeonDyncElemData.idx
  local inDungeon = not isFinish
  do return isFinish, inDungeon end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DungeonDyncData.CacheDailyDgFmtFriendSupportHeroData = function(self, supportHeroData)
  -- function num : 0_5
  self._dailyDgFmtFriendSupportHeroData = supportHeroData
end

DungeonDyncData.GetDailyDgFmtFriendSupportHeroDataCache = function(self)
  -- function num : 0_6
  return self._dailyDgFmtFriendSupportHeroData
end

DungeonDyncData.ClearDailyDgFmtFriendSupportHeroDataCache = function(self)
  -- function num : 0_7
  self._dailyDgFmtFriendSupportHeroData = nil
end

return DungeonDyncData

