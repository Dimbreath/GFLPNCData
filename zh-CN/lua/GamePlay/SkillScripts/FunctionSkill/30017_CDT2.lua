local bs_30017 = class("bs_30017", LuaSkillBase)
local base = LuaSkillBase
bs_30017.config = {buffId = 1142, buffTier = 1}
bs_30017.ctor = function(self)
  -- function num : 0_0
end

bs_30017.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30017_1", 2, self.OnAfterPlaySkill)
end

bs_30017.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  end
end

bs_30017.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30017

