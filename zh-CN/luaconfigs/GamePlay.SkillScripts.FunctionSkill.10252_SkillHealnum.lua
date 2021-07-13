-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10252 = class("bs_10252", LuaSkillBase)
local base = LuaSkillBase
bs_10252.config = {buffId = 1142, buffTier = 1}
bs_10252.ctor = function(self)
  -- function num : 0_0
end

bs_10252.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10252_1", 2, self.OnAfterPlaySkill)
end

bs_10252.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  end
end

bs_10252.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10252

