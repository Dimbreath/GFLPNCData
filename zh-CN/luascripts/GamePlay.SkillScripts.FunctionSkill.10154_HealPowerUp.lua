-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10154 = class("bs_10154", LuaSkillBase)
local base = LuaSkillBase
bs_10154.config = {buffId = 1030}
bs_10154.ctor = function(self)
    -- function num : 0_0
end

bs_10154.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_10152_5", 1,
                    self.OnAfterHeal)
end

bs_10154.OnAfterHeal = function(self, sender, target, skill, heal)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and LuaSkillCtrl:CallRange(1, 1000) <
        (self.arglist)[1] then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId,
                              (self.arglist)[2])
    end
end

bs_10154.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10154

