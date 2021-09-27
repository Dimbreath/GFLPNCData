local BaseBattleRoom = class("BaseBattleRoom")
local DynMonster = require("Game.Exploration.Data.DynMonster")
local DynDungeonRole = require("Game.Exploration.Data.DynDungeonRole")
local DynEffectGrid = require("Game.Exploration.Data.DynEffectGrid")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
BaseBattleRoom.__InitMonsterOrNeutralData = function(self, groupData)
  -- function num : 0_0 , upvalues : _ENV, ExplorationEnum, DynMonster, DynDungeonRole
  if self.battleMap == nil then
    error("battle map not initialization")
    return 
  end
  self.occupyCoords = {}
  ;
  ((self.battleMap).monsterList):Clear()
  self.monsterList = {}
  ;
  ((self.battleMap).waitToCasterMonsterList):Clear()
  local waitToCasterMonsterList = {}
  ;
  ((self.battleMap).neutralList):Clear()
  local neutralList = {}
  ;
  ((self.battleMap).pdungeonRoleList):Clear()
  local pdungeonRoleList = {}
  for k,v in pairs(groupData) do
    if (v.stc).cat ~= nil then
      if (v.stc).cat == (ExplorationEnum.EnemyRoleType).monster then
        local monster = (DynMonster.New)(v)
        ;
        (table.insert)(self.monsterList, monster)
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self.occupyCoords)[monster.coordination] = true
      else
        do
          if (v.stc).cat == (ExplorationEnum.EnemyRoleType).neutral then
            local neutral = (DynDungeonRole.New)(v)
            ;
            (table.insert)(neutralList, neutral)
            -- DECOMPILER ERROR at PC72: Confused about usage of register: R11 in 'UnsetPending'

            ;
            (self.occupyCoords)[neutral.coordination] = true
          else
            do
              if (v.stc).cat == (ExplorationEnum.EnemyRoleType).player then
                local summoenr = (DynDungeonRole.New)(v)
                summoenr:SetSummonerBelong(eBattleRoleBelong.player)
                ;
                (table.insert)(pdungeonRoleList, summoenr)
                -- DECOMPILER ERROR at PC94: Confused about usage of register: R11 in 'UnsetPending'

                ;
                (self.occupyCoords)[summoenr.coordination] = true
              else
                do
                  do
                    if (v.stc).cat == (ExplorationEnum.EnemyRoleType).towerSumMonster then
                      local monsterSummoner = (DynMonster.New)(v)
                      ;
                      (table.insert)(waitToCasterMonsterList, monsterSummoner)
                    end
                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
        end
      end
    end
  end
  if #self.monsterList > 0 then
    (table.sort)(self.monsterList, function(a, b)
    -- function num : 0_0_0
    do return a.coordination < b.coordination end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    for i = 1, #self.monsterList do
      local monster = (self.monsterList)[i]
      local bloodNum = monster:GetBossBloodNum()
      if bloodNum > 0 then
        (self.battleMap):SetBossBlood(i - 1, bloodNum)
      end
      ;
      ((self.battleMap).monsterList):Add(monster)
    end
  end
  do
    if #neutralList > 0 then
      (table.sort)(neutralList, function(a, b)
    -- function num : 0_0_1
    do return a.coordination < b.coordination end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      for i = 1, #neutralList do
        ((self.battleMap).neutralList):Add(neutralList[i])
      end
    end
    do
      if #pdungeonRoleList > 0 then
        (table.sort)(pdungeonRoleList, function(a, b)
    -- function num : 0_0_2
    do return a.coordination < b.coordination end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        for i = 1, #pdungeonRoleList do
          ((self.battleMap).pdungeonRoleList):Add(pdungeonRoleList[i])
        end
      end
      do
        if #waitToCasterMonsterList > 0 then
          (table.sort)(waitToCasterMonsterList, function(a, b)
    -- function num : 0_0_3
    do return a.uid < b.uid end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
          for i = 1, #waitToCasterMonsterList do
            local waitToCasterMonster = waitToCasterMonsterList[i]
            local bloodNum = waitToCasterMonster:GetBossBloodNum()
            if bloodNum > 0 then
              (self.battleMap):SetBossBlood(i - 1, 0)
            end
            ;
            ((self.battleMap).waitToCasterMonsterList):Add(waitToCasterMonster)
            ;
            (table.insert)(self.monsterList, waitToCasterMonsterList[i])
          end
        end
      end
    end
  end
end

BaseBattleRoom.__InitBattleGrid = function(self, grids)
  -- function num : 0_1 , upvalues : _ENV, DynEffectGrid
  self.effectGridList = {}
  if grids ~= nil then
    for k,v in pairs(grids) do
      local effectGrid = (DynEffectGrid.New)(k, v)
      ;
      (table.insert)(self.effectGridList, effectGrid)
    end
  end
  do
    ;
    (table.sort)(self.effectGridList, function(a, b)
    -- function num : 0_1_0
    do return a.coord < b.coord end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
end

BaseBattleRoom.ExecuteMonsterChip = function(self, dynPlayer)
  -- function num : 0_2 , upvalues : _ENV
  local chipList = self.monsterChipList
  if chipList ~= nil then
    for k,chipData in pairs(chipList) do
      self:__ExecuteMonsterChip(chipData, true)
    end
  end
  do
    self:ExecutePlayerChipForMonster(dynPlayer)
  end
end

BaseBattleRoom.ExecutePlayerChipForMonster = function(self, dynPlayer)
  -- function num : 0_3 , upvalues : _ENV
  local chipList = dynPlayer:GetChipList()
  for k,chipData in pairs(chipList) do
    if chipData:IsForEnemyChip() then
      self:__ExecuteMonsterChip(chipData)
    end
  end
end

BaseBattleRoom.RollbackPlayerChipForMonster = function(self, dynPlayer)
  -- function num : 0_4 , upvalues : _ENV
  local chipList = dynPlayer:GetChipList()
  for k,chipData in pairs(chipList) do
    if chipData:IsForEnemyChip() then
      self:__RollbackMonsterChip(chipData)
    end
  end
end

BaseBattleRoom.__ExecuteMonsterChip = function(self, chipData, isRelative)
  -- function num : 0_5 , upvalues : _ENV
  local belong = eBattleRoleBelong.enemy
  if isRelative then
    belong = eBattleRoleBelong.player
  end
  local validRoleList = chipData:GetValidRoleList(self.monsterList, belong)
  for k,role in pairs(validRoleList) do
    chipData:ExecuteChipData(role)
  end
end

BaseBattleRoom.__RollbackMonsterChip = function(self, chipData)
  -- function num : 0_6 , upvalues : _ENV
  for k,role in pairs(self.monsterList) do
    chipData:RollbackChipData(role)
  end
end

BaseBattleRoom.__ExecuteMonsterBuffChip = function(self, buffChip)
  -- function num : 0_7 , upvalues : _ENV
  local validRoleList = buffChip:GetValidRoleList(self.monsterList, eBattleRoleBelong.enemy)
  for k,role in pairs(validRoleList) do
    buffChip:ExecuteBuffChip(role)
  end
end

BaseBattleRoom.__RollbackMonsterBuffChip = function(self, buffChip)
  -- function num : 0_8 , upvalues : _ENV
  for k,role in pairs(self.monsterList) do
    buffChip:RollbackBuffChip(role)
  end
end

BaseBattleRoom.ExecuteMonsterTempChip = function(self, chipTemporaryDic)
  -- function num : 0_9 , upvalues : _ENV
  for k,buffData in pairs(chipTemporaryDic) do
    self:__ExecuteMonsterBuffChip(buffData)
  end
end

BaseBattleRoom.RollbackMonsterTempChip = function(self, chipTemporaryDic)
  -- function num : 0_10 , upvalues : _ENV
  for k,buffData in pairs(chipTemporaryDic) do
    self:__RollbackMonsterBuffChip(buffData)
  end
end

BaseBattleRoom.GetSceneId = function(self)
  -- function num : 0_11
end

BaseBattleRoom.GetIsInWeeklyChallenge = function(self)
  -- function num : 0_12
  return false
end

BaseBattleRoom.GetIsInBigBossRoom = function(self)
  -- function num : 0_13
  return false
end

BaseBattleRoom.IsInTDBattle = function(self)
  -- function num : 0_14
  return false
end

return BaseBattleRoom

