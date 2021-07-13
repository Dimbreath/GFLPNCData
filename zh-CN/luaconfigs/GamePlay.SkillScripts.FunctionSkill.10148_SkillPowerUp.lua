-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10148 = class("bs_10148", LuaSkillBase)
local base = LuaSkillBase
bs_10148.config = {buffId = 1016}
bs_10148.ctor = function(self)
  -- function num : 0_0
end

bs_10148.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10148_2", 2, self.OnAfterPlaySkill)
end

bs_10148.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], (self.arglist)[2], true)
  end
end

bs_10148.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10148

