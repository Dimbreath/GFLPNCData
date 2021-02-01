-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonBattleRoom = class("DungeonBattleRoom")
local CS_BattleUtility = CS.BattleUtility
local ItemData = require("Game.PlayerData.Item.ItemData")
local DynMonster = require("Game.Exploration.Data.DynMonster")
local DynNeutral = require("Game.Exploration.Data.DynNeutral")
local DynEffectGrid = require("Game.Exploration.Data.DynEffectGrid")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DungeonBattleRoom.ctor = function(self)
  -- function num : 0_0
end

DungeonBattleRoom.CreateBattleDungeonRoom = function(bdCtrl, monsterGroup, dungeonCfg, dynPlayer)
  -- function num : 0_1 , upvalues : DungeonBattleRoom
  local batteRoom = (DungeonBattleRoom.New)()
  batteRoom:InitBattleRoom(bdCtrl, monsterGroup, dungeonCfg, dynPlayer)
  return batteRoom
end

DungeonBattleRoom.InitBattleRoom = function(self, bdCtrl, monsterGroup, dungeonCfg, dynPlayer)
  -- function num : 0_2 , upvalues : _ENV, ItemData, CS_BattleUtility, DynEffectGrid
  self.bdCtrl = bdCtrl
  self.battleId = monsterGroup.battleId
  self.dungeonType = dungeonCfg.dungeon_type
  self.formation = monsterGroup.form
  self.dynPlayer = dynPlayer
  self.rewardList = {}
  if monsterGroup.reward ~= nil then
    for k1,elem in ipairs((monsterGroup.reward).data) do
      for i = 1, elem.stacking do
        local itemData = (ItemData.New)(elem.id, elem.num)
        local pos = (math.random)(1, #self.rewardList + 1)
        ;
        (table.insert)(self.rewardList, pos, itemData)
      end
    end
    self.rewardExtraDic = (monsterGroup.reward).extra
  end
  local size_row, size_col, deploy_rows = ((self.bdCtrl).sceneCtrl):GetBattleFieldSizeBySceneId()
  self.battleMap = (CS_BattleUtility.GenBattleMap)(size_row, size_col, deploy_rows)
  self:InitMonsterOrNeutralData(monsterGroup.data)
  self.effectGridList = {}
  if monsterGroup.grids ~= nil then
    for k,v in pairs(monsterGroup.grids) do
      local effectGrid = (DynEffectGrid.New)(k, v)
      ;
      (table.insert)(self.effectGridList, effectGrid)
    end
  end
  do
    self:UpdateMonsterChip()
  end
end

DungeonBattleRoom.InitMonsterOrNeutralData = function(self, groupData)
  -- function num : 0_3 , upvalues : _ENV, ExplorationEnum, DynMonster, DynNeutral
  ((self.battleMap).monsterList):Clear()
  self.monsterList = {}
  ;
  ((self.battleMap).neutralList):Clear()
  self.neutralList = {}
  for k,v in pairs(groupData) do
    if v.cat ~= nil then
      if v.cat == (ExplorationEnum.EnemyRoleType).monster then
        local monster = (DynMonster.New)(v)
        ;
        (table.insert)(self.monsterList, monster)
      else
        do
          do
            if v.cat == (ExplorationEnum.EnemyRoleType).neutral then
              local neutral = (DynNeutral.New)(v)
              ;
              (table.insert)(self.neutralList, neutral)
            end
            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  ;
  (table.sort)(self.monsterList, function(a, b)
    -- function num : 0_3_0
    do return a.coordination < b.coordination end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i = 1, #self.monsterList do
    ((self.battleMap).monsterList):Add((self.monsterList)[i])
  end
  ;
  (table.sort)(self.neutralList, function(a, b)
    -- function num : 0_3_1
    do return a.coordination < b.coordination end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i = 1, #self.neutralList do
    ((self.battleMap).neutralList):Add((self.neutralList)[i])
  end
end

DungeonBattleRoom.UpdateMonsterChip = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local chipList = (self.dynPlayer):GetChipList()
  for k,chipData in pairs(chipList) do
    self:__ExecuteMonsterChip(chipData)
  end
  local epBuffChipDic = (self.dynPlayer):GetEpBuffChipDic()
  for k,buffChip in pairs(epBuffChipDic) do
    self:__ExecuteMonsterBuffChip(buffChip)
  end
  local hiddenChipDic = (self.dynPlayer):GetHiddenChipDic()
  for k,buffChip in pairs(hiddenChipDic) do
    self:__ExecuteMonsterBuffChip(buffChip)
  end
end

DungeonBattleRoom.__ExecuteMonsterChip = function(self, chipData, isRelative)
  -- function num : 0_5 , upvalues : _ENV
  local belong = eBattleRoleBelong.enemy
  if isRelative then
    belong = eBattleRoleBelong.player
  end
  local validRoleList = chipData:GetValidRoleList(self.monsterList, belong)
  for k,role in pairs(validRoleList) do
    chipData:ExecuteChipHero(role)
  end
end

DungeonBattleRoom.__ExecuteMonsterBuffChip = function(self, buffChip)
  -- function num : 0_6 , upvalues : _ENV
  local validRoleList = buffChip:GetValidRoleList(self.monsterList, eBattleRoleBelong.enemy)
  for k,role in pairs(validRoleList) do
    buffChip:ExecuteChipHero(role)
  end
end

return DungeonBattleRoom

