-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10220 = class("bs_10220", LuaSkillBase)
local base = LuaSkillBase
bs_10220.config = {buffId = 1077, buffTier = 1}
bs_10220.ctor = function(self)
  -- function num : 0_0
end

bs_10220.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10220_3", 3, self.OnAfterPlaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_10220_1", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_10220_15", 1, self.OnHurtResultEnd)
  self.flag = false
end

bs_10220.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
  local tier = (self.caster):GetBuffTier((self.config).buffId)
  if tier == 0 and skill.maker == self.caster and not skill.isCommonAttack then
    self.flag = true
  end
end

bs_10220.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.sender == self.caster and skill.isCommonAttack and self.flag then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  end
end

bs_10220.OnHurtResultEnd = function(self, skill, targetRole, hurtValue)
  -- function num : 0_4 , upvalues : _ENV
  if skill.maker == self.caster and skill.isCommonAttack and self.flag then
    local buffTier = (self.caster):GetBuffTier((self.config).buffId)
    if buffTier <= 0 then
      return 
    end
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    self.flag = false
  end
end

bs_10220.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10220

