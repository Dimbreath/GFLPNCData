local bs_20116 = class("bs_20116", LuaSkillBase)
local base = LuaSkillBase
bs_20116.config = {effectId = 10335}
bs_20116.ctor = function(self)
  -- function num : 0_0
end

bs_20116.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_20116_2", 2, self.OnAfterPlaySkill)
end

bs_20116.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    local damage = (self.caster).maxHp * (self.arglist)[1] // 1000
    LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true, true)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  end
end

bs_20116.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20116

