local bs_10288 = class("bs_10288", LuaSkillBase)
local base = LuaSkillBase
bs_10288.config = {buffId = 1197, buffTier = 1}
bs_10288.ctor = function(self)
  -- function num : 0_0
end

bs_10288.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10288_1", 1, self.OnAfterPlaySkill)
end

bs_10288.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, (self.arglist)[2], true)
  end
end

bs_10288.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10288

