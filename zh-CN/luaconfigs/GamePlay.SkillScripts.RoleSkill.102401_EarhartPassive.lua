-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102401 = class("bs_102401", LuaSkillBase)
local base = LuaSkillBase
bs_102401.config = {buffId_236 = 236, buffId_235 = 235, effectId = 10738}
bs_102401.ctor = function(self)
  -- function num : 0_0
end

bs_102401.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_102401_3", 1, self.OnAfterHurt, self.caster)
end

bs_102401.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and isCrit and sender:GetBuffTier((self.config).buffId_236) == 0 and skill.isCommonAttack and (self.arglist)[2] > 0 then
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, (self.arglist)[1])
  end
  if sender == self.caster and isCrit and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_235, 1, (self.arglist)[4], true)
  end
end

bs_102401.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102401

