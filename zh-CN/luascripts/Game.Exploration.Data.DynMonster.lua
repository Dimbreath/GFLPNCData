-- params : ...
-- function num : 0 , upvalues : _ENV
local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynMonster = class("DynMonster", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynMonster.ctor = function(self, monsterData)
    -- function num : 0_0 , upvalues : _ENV, DynBattleSkill, ExplorationEnum
    self.dataId = monsterData.monsterId
    self.monsterCfg = (ConfigData.monster)[self.dataId]
    if self.monsterCfg == nil then
        error("monster Cfg is null,id:" .. tostring(self.dataId))
        return
    end
    self.resCfg = (ConfigData.resource_model)[(self.monsterCfg).src_id]
    if self.resCfg == nil then
        error("resource model cfg is null,id:" ..
                  tostring((self.monsterCfg).src_id))
        return
    end
    self.belong = eBattleRoleBelong.enemy
    self.onBench = false
    self.attackRange = (self.monsterCfg).range
    self.moveSpeed = (self.monsterCfg).move_spd
    self.intensity = (self.monsterCfg).intensity
    self.baseAttr = {}
    self.ratioAttr = {}
    self.extraAttr = {}
    self.originAttr = {}
    for k, v in pairs(monsterData.attr) do
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R7 in 'UnsetPending'

        (self.originAttr)[k] = v
    end
    self.originSkillList = {}
    for k, skillId in pairs(monsterData.skillList) do
        local battleSkill = (DynBattleSkill.New)(skillId, 1,
                                                 (ExplorationEnum.eBattleSkillType).Original);
        (table.insert)(self.originSkillList, battleSkill)
    end
    self.coordination = monsterData.coordination
    self:SetCoord(monsterData.coordination)
    self.hpPer = monsterData.hpPer
end

DynMonster.GetMonsterInfo = function(self)
    -- function num : 0_1 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.monsterCfg).info)
end

DynMonster.GetName = function(self)
    -- function num : 0_2 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.monsterCfg).name)
end

DynMonster.GetCareer = function(self)
    -- function num : 0_3
    return (self.monsterCfg).career
end

DynMonster.GetCamp = function(self)
    -- function num : 0_4
    return (self.monsterCfg).camp
end

DynMonster.GetResName = function(self)
    -- function num : 0_5
    return (self.resCfg).res_Name
end

DynMonster.GetResSrcId = function(self)
    -- function num : 0_6
    return (self.monsterCfg).src_id
end

return DynMonster

