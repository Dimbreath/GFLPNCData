local bs_10082 = class("bs_10082", LuaSkillBase)
local base = LuaSkillBase
bs_10082.config = {}
bs_10082.ctor = function(self)
  -- function num : 0_0
end

bs_10082.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.caster).recordTable).SkillTime = (self.arglist)[1]
  self:AddSetHurtTrigger("bs_10082_1", 1, self.OnSetHurt, nil, self.caster)
end

bs_10082.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if self:IsReadyToTake() and context.target == self.caster and ((self.caster).recordTable).SkillTime > 0 and not context.isTriggerSet then
    local damage = (math.max)(context.hurt * (self.arglist)[2] // 1000)
    LuaSkillCtrl:RemoveLife(damage, self, context.sender, true)
    context.hurt = 0
    LuaSkillCtrl:CallFloatText(self.caster, 8)
    self:PlayChipEffect()
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.caster).recordTable).SkillTime = ((self.caster).recordTable).SkillTime - 1
    self:OnSkillTake()
  end
end

bs_10082.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10082

