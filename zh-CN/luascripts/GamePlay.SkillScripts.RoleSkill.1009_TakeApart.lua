-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1009 = class("bs_1009", LuaSkillBase)
local base = LuaSkillBase
bs_1009.config = {buffId = 79, buffTier = 1}
bs_1009.ctor = function(self)
  -- function num : 0_0
end

bs_1009.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1009_3", 1, self.OnAfterHurt)
end

bs_1009.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and target ~= self.caster then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, (self.arglist)[2])
  end
end

bs_1009.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1009

