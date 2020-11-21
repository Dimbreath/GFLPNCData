-- params : ...
-- function num : 0 , upvalues : _ENV
local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynHero = class("DynHero", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynHero.ctor = function(self, heroData)
    -- function num : 0_0 , upvalues : _ENV, ExplorationEnum
    self.heroData = heroData
    self.heroCfg = heroData.heroCfg
    self.dataId = (self.heroCfg).id
    self.resCfg = (ConfigData.resource_model)[(self.heroCfg).src_id]
    if self.resCfg == nil then
        error("resource model cfg is null,id:" ..
                  tostring((self.heroCfg).src_id))
        return
    end
    self.totalDamage = 0
    self.belong = eBattleRoleBelong.player
    self.onBench = false
    self.attackRange = (self.heroCfg).range
    self.moveSpeed = (self.heroCfg).move_spd
    self.intensity = (self.heroCfg).intensity
    self.hpPer = ExplorationEnum.eHeroHpPercent
    self.baseAttr = {}
    self.ratioAttr = {}
    self.extraAttr = {}
end

DynHero.UpdateBaseHeroData = function(self, attrDic, baseSkillDic, athSkillList)
    -- function num : 0_1 , upvalues : _ENV, DynBattleSkill, ExplorationEnum
    if self.heroData == nil then return end
    self.originAttr = {}
    for k, v in pairs(attrDic) do
        -- DECOMPILER ERROR at PC11: Confused about usage of register: R9 in 'UnsetPending'

        (self.originAttr)[k] = v
    end
    self.originSkillList = {}
    for skillId, skillLevel in pairs(baseSkillDic) do
        local heroSkill = ((self.heroData).skillDic)[skillId]
        if heroSkill == nil then
            warn((string.format)(
                     "Cant get client heroSkill, skill id = %s, heroId = %s",
                     skillId, (self.heroData).dataId))
        else
            if skillLevel ~= heroSkill.level then
                warn((string.format)(
                         "Client heroSkill level is different, skill id = %s, heroId = %s, clientLevel = %s, serverLevel = %s",
                         skillId, (self.heroData).dataId, heroSkill.level,
                         skillLevel))
            end
            local battleSkill = (DynBattleSkill.New)(
                                    heroSkill:GetLogicSkillId(), skillLevel,
                                    (ExplorationEnum.eBattleSkillType).Original);
            (table.insert)(self.originSkillList, battleSkill)
        end
    end
    for k, athSkillId in ipairs(athSkillList) do
        local skillLevel = 1
        local skillData = (DynBattleSkill.New)(athSkillId, skillLevel,
                                               (ExplorationEnum.eBattleSkillType).AthSuit)
        self:AddItemSkill(skillData)
    end
end

DynHero.GetClientOriginAttr = function(self, attrId)
    -- function num : 0_2 , upvalues : _ENV
    if self.heroData == nil then return 0 end
    if (ConfigData.attribute)[attrId] == nil or
        (ConfigData.attribute)[attrId + 100] == nil or
        (ConfigData.attribute)[attrId + 200] == nil then return 0 end
    return (self.heroData):GetAttr(attrId)
end

DynHero.GetName = function(self)
    -- function num : 0_3 , upvalues : _ENV
    return (LanguageUtil.GetLocaleText)((self.heroCfg).name)
end

DynHero.GetCareer = function(self)
    -- function num : 0_4
    return (self.heroCfg).career
end

DynHero.GetCamp = function(self)
    -- function num : 0_5
    return (self.heroCfg).camp
end

DynHero.GetResName = function(self)
    -- function num : 0_6
    return (self.heroData):GetResName()
end

DynHero.GetResSrcId = function(self)
    -- function num : 0_7
    return (self.heroCfg).src_id
end

DynHero.GetLevel = function(self)
    -- function num : 0_8
    return (self.heroData).level
end

DynHero.GetCurExp = function(self)
    -- function num : 0_9
    return (self.heroData).curExp
end

DynHero.GetTotalExp = function(self)
    -- function num : 0_10
    return (self.heroData):GetLevelTotalExp()
end

DynHero.GetStar = function(self)
    -- function num : 0_11
    return (self.heroData).star
end

DynHero.UpdateTotalDamage = function(self, totalDamage)
    -- function num : 0_12
    self.totalDamage = totalDamage
end

DynHero.GetID = function(self)
    -- function num : 0_13
    return self.dataId
end

DynHero.IsBench = function(self)
    -- function num : 0_14
    return self.onBench
end

return DynHero

