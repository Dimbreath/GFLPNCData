-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10184 = class("bs_10184", LuaSkillBase)
local base = LuaSkillBase
bs_10184.config = {sheildBuffId = 174, buffId = 1066}
bs_10184.ctor = function(self)
  -- function num : 0_0
end

bs_10184.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_10184_3", 1, self.OnSetHurt)
end

bs_10184.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.sender == self.caster and not (context.skill).isPassive then
    local restTier = (context.target):GetBuffTier((self.config).sheildBuffId)
    if restTier > 0 then
      context.hurt = context.hurt + context.hurt * (self.arglist)[1] // 1000
    end
  end
end

bs_10184.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10184

