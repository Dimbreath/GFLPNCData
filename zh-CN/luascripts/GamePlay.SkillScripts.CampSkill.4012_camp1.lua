-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_4012 = class("bs_4012", LuaSkillBase)
local base = LuaSkillBase
bs_4012.config = {buffId = 84, buffDuration = 60, buffTier = 10}
bs_4012.ctor = function(self)
    -- function num : 0_0
end

bs_4012.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_4012_3", 1,
                    self.OnAfterHurt)
end

bs_4012.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                               isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and skill.isCommonAttack and isCrit then
        LuaSkillCtrl:CallBuff(self, sender, (self.config).buffId,
                              (self.config).buffTier, (self.config).buffDuration)
    end
end

bs_4012.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_4012

