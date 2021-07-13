-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10066 = class("bs_10066", LuaSkillBase)
local base = LuaSkillBase
bs_10066.config = {buffId = 1139, buffTier = 1}
bs_10066.ctor = function(self)
  -- function num : 0_0
end

bs_10066.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_10066_3", 1, self.OnAfterHurt, self.caster)
end

bs_10066.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier)
    self:PlayChipEffect()
    self:OnSkillTake()
  end
end

bs_10066.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10066

