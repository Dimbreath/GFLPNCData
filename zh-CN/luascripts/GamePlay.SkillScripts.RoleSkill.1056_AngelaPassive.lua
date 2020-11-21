-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1056 = class("bs_1056", LuaSkillBase)
local base = LuaSkillBase
bs_1056.config = {buffId = 115}
bs_1056.ctor = function(self)
    -- function num : 0_0
end

bs_1056.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1056_3", 1,
                    self.OnAfterHurt)
end

bs_1056.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                               isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    -- DECOMPILER ERROR at PC31: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC31: Unhandled construct in 'MakeBoolean' P1

    if sender == self.caster and skill.isCommonAttack and not isMiss and
        (self.arglist)[3] > 0 and LuaSkillCtrl:CallRange(1, 1000) <=
        (self.arglist)[1] * 2 then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1,
                              (self.arglist)[2])
    end
    if LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1,
                              (self.arglist)[2])
    end
end

bs_1056.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1056

