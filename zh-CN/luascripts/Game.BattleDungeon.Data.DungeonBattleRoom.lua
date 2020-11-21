-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonBattleRoom = class("DungeonBattleRoom")
local CS_BattleUtility = CS.BattleUtility
local ItemData = require("Game.PlayerData.Item.ItemData")
local DynMonster = require("Game.Exploration.Data.DynMonster")
local DynEffectGrid = require("Game.Exploration.Data.DynEffectGrid")
DungeonBattleRoom.ctor = function(self)
    -- function num : 0_0
end

DungeonBattleRoom.CreateBattleDungeonRoom =
    function(monsterGroup, dungeonCfg, dynPlayer)
        -- function num : 0_1 , upvalues : DungeonBattleRoom
        local batteRoom = (DungeonBattleRoom.New)()
        batteRoom:InitBattleRoom(monsterGroup, dungeonCfg, dynPlayer)
        return batteRoom
    end

DungeonBattleRoom.InitBattleRoom = function(self, monsterGroup, dungeonCfg,
                                            dynPlayer)
    -- function num : 0_2 , upvalues : _ENV, ItemData, CS_BattleUtility, DynMonster, DynEffectGrid
    self.battleId = monsterGroup.battleId
    self.dungeonType = dungeonCfg.dungeon_type
    self.formation = monsterGroup.form
    self.dynPlayer = dynPlayer
    self.rewardList = {}
    if monsterGroup.reward ~= nil then
        for k1, elem in ipairs((monsterGroup.reward).data) do
            for i = 1, elem.stacking do
                local itemData = (ItemData.New)(elem.id, elem.num)
                local pos = (math.random)(1, #self.rewardList + 1);
                (table.insert)(self.rewardList, pos, itemData)
            end
        end
        self.rewardExtraDic = (monsterGroup.reward).extra
    end
    self.battleMap = (CS_BattleUtility.GenBattleMap)(dungeonCfg.size_row,
                                                     dungeonCfg.size_col,
                                                     dungeonCfg.deploy_rows);
    ((self.battleMap).monsterList):Clear()
    self.monsterList = {}
    for k, v in pairs(monsterGroup.data) do
        local monster = (DynMonster.New)(v);
        (table.insert)(self.monsterList, monster)
    end
    (table.sort)(self.monsterList, function(a, b)
        -- function num : 0_2_0
        do return a.coordination < b.coordination end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    for i = 1, #self.monsterList do
        ((self.battleMap).monsterList):Add((self.monsterList)[i])
    end
    self.effectGridList = {}
    if monsterGroup.grids ~= nil then
        for k, v in pairs(monsterGroup.grids) do
            local effectGrid = (DynEffectGrid.New)(k, v);
            (table.insert)(self.effectGridList, effectGrid)
        end
    end
    do self:UpdateMonsterChip() end
end

DungeonBattleRoom.UpdateMonsterChip = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local chipList = (self.dynPlayer):GetChipList()
    for k, chipData in pairs(chipList) do self:__ExecuteMonsterChip(chipData) end
    local epBuffChipDic = (self.dynPlayer):GetEpBuffChipDic()
    for k, buffChip in pairs(epBuffChipDic) do
        self:__ExecuteMonsterBuffChip(buffChip)
    end
    local hiddenChipDic = (self.dynPlayer):GetHiddenChipDic()
    for k, buffChip in pairs(hiddenChipDic) do
        self:__ExecuteMonsterBuffChip(buffChip)
    end
end

DungeonBattleRoom.__ExecuteMonsterChip =
    function(self, chipData, isRelative)
        -- function num : 0_4 , upvalues : _ENV
        local belong = eBattleRoleBelong.enemy
        if isRelative then belong = eBattleRoleBelong.player end
        local validRoleList =
            chipData:GetValidRoleList(self.monsterList, belong)
        for k, role in pairs(validRoleList) do
            chipData:ExecuteChipHero(role)
        end
    end

DungeonBattleRoom.__ExecuteMonsterBuffChip =
    function(self, buffChip)
        -- function num : 0_5 , upvalues : _ENV
        local validRoleList = buffChip:GetValidRoleList(self.monsterList,
                                                        eBattleRoleBelong.enemy)
        for k, role in pairs(validRoleList) do
            buffChip:ExecuteChipHero(role)
        end
    end

return DungeonBattleRoom

