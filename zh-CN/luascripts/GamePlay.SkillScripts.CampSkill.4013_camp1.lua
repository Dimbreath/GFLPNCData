-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_4013 = class("bs_4013", LuaSkillBase)
local base = LuaSkillBase
bs_4013.config = {buffId = 84, buffDuration = 60, buffTier = 20}
bs_4013.ctor = function(self)
  -- function num : 0_0
end

bs_4013.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_4013_3", 1, self.OnAfterHurt)
end

bs_4013.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and isCrit then
    LuaSkillCtrl:CallBuff(self, sender, (self.config).buffId, (self.config).buffTier, (self.config).buffDuration, true)
  end
end

bs_4013.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_4013

