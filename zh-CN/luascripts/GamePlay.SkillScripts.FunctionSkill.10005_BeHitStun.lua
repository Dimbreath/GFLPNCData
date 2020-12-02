-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10005 = class("bs_10005", LuaSkillBase)
local base = LuaSkillBase
bs_10005.config = {buffId = 66, effectIdSelf = 1001, effectIdAttack = 1002}
bs_10005.ctor = function(self)
  -- function num : 0_0
end

bs_10005.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10005_1", 1, self.OnAfterHurt)
end

bs_10005.OnAfterHurt = function(self, sender, target, skill, realValue, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectIdSelf, self)
    LuaSkillCtrl:CallEffect(sender, (self.config).effectIdAttack, self)
    LuaSkillCtrl:CallBuff(self, sender, (self.config).buffId, (self.arglist)[3], (self.arglist)[2])
  end
end

bs_10005.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10005

