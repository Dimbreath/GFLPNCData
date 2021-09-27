local bs_10028 = class("bs_10028", LuaSkillBase)
local base = LuaSkillBase
bs_10028.config = {buffId = 76, effectId = 1002}
bs_10028.ctor = function(self)
  -- function num : 0_0
end

bs_10028.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetHurtTrigger("bs_10028_2", 1, self.OnSetHurt, nil, self.caster)
  self:AddAfterHurtTrigger("bs_10028_3", 1, self.OnAfterHurt, nil, self.caster)
  self.hurtBack = 0
end

bs_10028.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.target == self.caster and (self.caster):GetBuffTier((self.config).buffId) > 0 then
    self.hurtBack = context.hurt * (self.arglist)[2] // 1000
  end
end

bs_10028.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and (self.caster):GetBuffTier((self.config).buffId) > 0 and self.hurtBack > 0 then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count < 1 then
      return 
    end
    for i = 0, targetList.Count - 1 do
      local targetRole = (targetList[i]).targetRole
      LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self)
      LuaSkillCtrl:RemoveLife(self.hurtBack, self, targetRole)
    end
    self.hurtBack = 0
  end
end

bs_10028.PlaySkill = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, (self.arglist)[1])
end

bs_10028.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10028

