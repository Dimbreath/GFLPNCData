local bs_10197 = class("bs_10197", LuaSkillBase)
local base = LuaSkillBase
bs_10197.config = {}
bs_10197.ctor = function(self)
  -- function num : 0_0
end

bs_10197.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10197_2", 1, self.OnSetHurt, nil, self.caster, eBattleRoleBelong.neutral)
end

bs_10197.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.sender).belongNum == 0 and context.target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
    self:PlayChipEffect()
    context.hurt = 0
  end
end

bs_10197.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10197

