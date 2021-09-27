local bs_cuiruozuzhou = class("bs_cuiruozuzhou", LuaSkillBase)
local base = LuaSkillBase
bs_cuiruozuzhou.config = {buffId = 1208, effectId = 10084}
bs_cuiruozuzhou.ctor = function(self)
  -- function num : 0_0
end

bs_cuiruozuzhou.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetDeadHurt, "bs_cuiruozuzhou_3", 1, self.OnSetDeadHurt)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_cuiruozuzhou_4", 1, self.OnAfterHurt)
end

bs_cuiruozuzhou.OnSetDeadHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster then
    LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId, 1, 1000)
    self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  end
end

bs_cuiruozuzhou.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3
end

bs_cuiruozuzhou.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_cuiruozuzhou

