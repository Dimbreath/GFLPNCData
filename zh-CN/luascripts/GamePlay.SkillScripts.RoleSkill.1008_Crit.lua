-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1008 = class("bs_1008", LuaSkillBase)
local base = LuaSkillBase
bs_1008.config = {
    buffId1 = 77,
    buffTier1 = 1,
    buffId2 = 97,
    buffTier2 = 1,
    attBuffId1 = 78,
    attBuffTier1 = 1,
    attBuffId2 = 98,
    attBuffTier2 = 1
}
bs_1008.ctor = function(self)
    -- function num : 0_0
end

bs_1008.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1008_3", 1,
                    self.OnAfterHurt)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1,
                          (self.config).buffTier)
    if (self.arglist)[4] == 1 then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2,
                              (self.config).buffTier)
    end
end

bs_1008.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                               isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if target == self.caster then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).attBuffId1,
                              (self.config).attBuffTier, (self.arglist)[1])
        if (self.arglist)[4] == 1 then
            LuaSkillCtrl:CallBuff(self, self.caster, (self.config).attBuffId2,
                                  (self.config).attBuffTier, (self.arglist)[1])
        end
    end
end

bs_1008.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1008

