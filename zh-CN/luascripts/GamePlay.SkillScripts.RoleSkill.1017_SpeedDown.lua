-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1017 = class("bs_1017", LuaSkillBase)
local base = LuaSkillBase
bs_1017.config = {buffId = 96, buffTier = 1}
bs_1017.ctor = function(self)
  -- function num : 0_0
end

bs_1017.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1017_3", 1, self.OnAfterHurt)
end

bs_1017.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and target ~= self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, (self.arglist)[3])
  end
end

bs_1017.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1017

