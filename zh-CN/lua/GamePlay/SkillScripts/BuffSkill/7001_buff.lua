local bs_7001 = class("bs_7001", LuaSkillBase)
local base = LuaSkillBase
bs_7001.config = {
hurt_config = {crit_formula = 10010, lifesteal_formula = 10141, extra_arg = 700101}
}
bs_7001.ctor = function(self)
  -- function num : 0_0
end

bs_7001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_20013_14", 1, self.OnHurtResultStart)
  self:AddAfterHurtTrigger("bs_7001_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, nil, (self.config).extra_arg)
end

bs_7001.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_2 , upvalues : _ENV
  if skill.isCommonAttack and context.sender == self.caster then
    context.new_config = (self.config).hurt_config
    setmetatable(context.new_config, {__index = context.config})
  end
end

bs_7001.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if skill.isCommonAttack and sender == self.caster then
    local buffId = LuaSkillCtrl:GetSkillBindBuffId(self)
    LuaSkillCtrl:DispelBuff(self.caster, buffId, 1)
  end
end

bs_7001.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_7001

