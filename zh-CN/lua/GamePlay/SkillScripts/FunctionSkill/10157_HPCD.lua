local bs_10157 = class("bs_10157", LuaSkillBase)
local base = LuaSkillBase
bs_10157.config = {buffTier = 1, buffId_shixue = 257}
bs_10157.ctor = function(self)
  -- function num : 0_0
end

bs_10157.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10157_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10157_2", 2, self.OnAfterBattleStart)
end

bs_10157.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and (self.caster).hp <= (self.caster).maxHp * (self.arglist)[1] // 1000 and self:IsReadyToTake() then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_shixue, (self.arglist)[2], nil, true)
    self:OnSkillTake()
  end
end

bs_10157.OnAfterBattleStart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if (self.caster).hp <= (self.caster).maxHp * (self.arglist)[1] // 1000 and self:IsReadyToTake() then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_shixue, (self.arglist)[2])
    self:OnSkillTake()
  end
end

bs_10157.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10157

