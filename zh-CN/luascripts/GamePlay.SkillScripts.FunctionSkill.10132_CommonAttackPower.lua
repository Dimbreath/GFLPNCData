-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10132 = class("bs_10132", LuaSkillBase)
local base = LuaSkillBase
bs_10132.config = {buffId = 1030}
bs_10132.ctor = function(self)
  -- function num : 0_0
end

bs_10132.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10132_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10132_2", 1, self.OnAfterPlaySkill)
end

bs_10132.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
  end
end

bs_10132.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  end
end

bs_10132.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10132

