-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10009 = class("bs_10009", LuaSkillBase)
local base = LuaSkillBase
bs_10009.config = {
    hurt_config = {basehurt_formula = 10007},
    effectIdAttack = 1006
}
bs_10009.ctor = function(self)
    -- function num : 0_0
end

bs_10009.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10009_3", 1,
                    self.OnAfterHurt)
end

bs_10009.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and skill.isCommonAttack and
        target:ContainFeature(eBuffFeatureType.Stun) then
        self:PlayChipEffect()
        local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
        self:CallCasterLookAt(targetList)
        LuaSkillCtrl:CallEffect(targetList, (self.config).effectIdAttack, self,
                                self.SkillEventFunc)
    end
end

bs_10009.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
        skillResult:EndResult()
    end
end

bs_10009.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10009

