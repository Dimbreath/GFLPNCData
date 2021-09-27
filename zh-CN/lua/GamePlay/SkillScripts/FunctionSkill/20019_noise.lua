local bs_20019 = class("bs_20019", LuaSkillBase)
local base = LuaSkillBase
bs_20019.config = {}
bs_20019.ctor = function(self)
  -- function num : 0_0
end

bs_20019.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_20019_6", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

bs_20019.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and (context.buff).buffType == 2 and LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[1] and self:IsReadyToTake() then
    self:PlayChipEffect()
    context.active = false
  end
end

bs_20019.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20019

