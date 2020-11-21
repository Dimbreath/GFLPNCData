-- params : ...
-- function num : 0 , upvalues : _ENV
local DynCampFetter = class("DynCampFetter")
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
DynCampFetter.ctor = function(self, campConCfg, campId, heroCount)
    -- function num : 0_0 , upvalues : _ENV, ChipBattleData
    self.campId = campId
    self.campConCfg = campConCfg
    self.count = heroCount
    self.heroList = {}
    self.level = 1
    for i = #(self.campConCfg).camp_hero_num, 1, -1 do
        local num = ((self.campConCfg).camp_hero_num)[i]
        if num <= self.count then self.level = (self.campConCfg)[i] end
    end
    self.battleChipList = {}
    for k, chipId in ipairs((self.campConCfg).chip_id) do
        local chipCfg = (ConfigData.chip)[chipId]
        if chipCfg == nil then
            error("chip cfg is null,id:" .. tostring(chipId))
        else
            local chipBattleData = (ChipBattleData.New)(chipCfg, self.level);
            (table.insert)(self.battleChipList, chipBattleData)
        end
    end
end

DynCampFetter.ExecuteCampFetter = function(self, battleRoleList, belong)
    -- function num : 0_1 , upvalues : _ENV
    for k, chipBattleData in pairs(self.battleChipList) do
        local validRoleList = chipBattleData:GetValidRoleList(battleRoleList,
                                                              belong)
        for k, battleRole in pairs(validRoleList) do
            chipBattleData:ExecutePropHero(battleRole, self.level)
            battleRole:AddCampFetterChip(chipBattleData)
        end
    end
end

DynCampFetter.RollbackCampFetter = function(self, battleRoleList)
    -- function num : 0_2 , upvalues : _ENV
    for k, chipBattleData in pairs(self.battleChipList) do
        for k, battleRole in pairs(battleRoleList) do
            if battleRole:ContainCampFetterChip(chipBattleData) then
                chipBattleData:RollbackHero(battleRole, self.level)
            end
        end
    end
end

return DynCampFetter

