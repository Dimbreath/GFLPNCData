local bs_10192 = class("bs_10192", LuaSkillBase)
local base = LuaSkillBase
bs_10192.config = {buffId = 1070}
bs_10192.ctor = function(self)
  -- function num : 0_0
end

bs_10192.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10192_4", 1, self.OnSetHeal, self.caster, nil, nil, (self.caster).belongNum)
end

bs_10192.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).belongNum == (self.caster).belongNum and context.sender == self.caster and not context.isTriggerSet and LuaSkillCtrl:GetRoleEfcGrid(context.target) == 10 then
    self:PlayChipEffect()
    context.heal = context.heal + context.heal * (self.arglist)[2] // 1000
  end
end

bs_10192.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10192

