-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10139 = class("bs_10139", LuaSkillBase)
local base = LuaSkillBase
bs_10139.config = {buffId = 1009}
bs_10139.ctor = function(self)
  -- function num : 0_0
end

bs_10139.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10139_1", 1, self.OnAfterPlaySkill)
end

bs_10139.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], (self.arglist)[2])
  end
end

bs_10139.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10139

