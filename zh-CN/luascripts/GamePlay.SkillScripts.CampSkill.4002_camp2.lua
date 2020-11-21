-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_4002 = class("bs_4002", LuaSkillBase)
local base = LuaSkillBase
bs_4002.config = {buffId = 99, buffDuration = 45}
bs_4002.ctor = function(self)
    -- function num : 0_0
end

bs_4002.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_4002_3", 1, self.OnSetHurt)
end

bs_4002.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if context.target == self.caster and self:IsReadyToTake() and
        (self.caster).hp <= context.hurt then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                              (self.config).buffTier, (self.config).buffDuration)
        self:OnSkillTake()
    end
end

bs_4002.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_4002

