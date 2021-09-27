local bs_10295 = class("bs_10295", LuaSkillBase)
local base = LuaSkillBase
bs_10295.config = {buffId = 26}
bs_10295.ctor = function(self)
  -- function num : 0_0
end

bs_10295.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10295_2", 1, self.OnSetHurt, nil, self.caster)
end

bs_10295.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and self:IsReadyToTake() and (context.skill).isCommonAttack and not context.isTriggerSet and LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[1] then
    LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId, 1, (self.arglist)[2])
  end
end

bs_10295.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10295

