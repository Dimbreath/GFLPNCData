local bs_10035 = class("bs_10035", LuaSkillBase)
local base = LuaSkillBase
bs_10035.config = {}
bs_10035.ctor = function(self)
  -- function num : 0_0
end

bs_10035.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddBeforeAddBuffTrigger("bs_10035_2", 1, self.OnBeforeAddBuff, self.caster, nil, nil, nil, nil, eBuffType.Debeneficial)
end

bs_10035.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  if (context.buff).buffType == 2 and (context.buff).maker == self.caster and self:IsReadyToTake() and LuaSkillCtrl:CallRange(1, 100) < (self.arglist)[1] then
    (context.buff).tier = (context.buff).tier + 1
    self:PlayChipEffect()
    self:OnSkillTake()
  end
end

bs_10035.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10035

