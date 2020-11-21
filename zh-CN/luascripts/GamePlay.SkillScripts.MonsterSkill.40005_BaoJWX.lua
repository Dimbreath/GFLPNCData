-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40005 = class("bs_40005", LuaSkillBase)
local base = LuaSkillBase
bs_40005.config = {}
bs_40005.ctor = function(self)
    -- function num : 0_0
end

bs_40005.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.HurtResultStart, "bs_40005_14", 1,
                    self.OnHurtResultStart)
end

bs_40005.OnHurtResultStart = function(self, skill, context)
    -- function num : 0_2
    if context.target == self.caster then context.isCrit = false end
end

bs_40005.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_3
    if target ~= self.caster or isCrit then end
end

bs_40005.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40005

