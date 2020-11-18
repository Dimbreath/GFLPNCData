-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10042 = class("bs_10042", LuaSkillBase)
local base = LuaSkillBase
bs_10042.config = {buffId = 26, buffTier = 1}
bs_10042.ctor = function(self)
  -- function num : 0_0
end

bs_10042.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10042_3", 1, self.OnAfterHurt)
end

bs_10042.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 100) < (self.arglist)[1] then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, (self.arglist)[2])
  end
end

bs_10042.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10042

