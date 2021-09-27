local bs_10049 = class("bs_10049", LuaSkillBase)
local base = LuaSkillBase
bs_10049.config = {}
bs_10049.ctor = function(self)
  -- function num : 0_0
end

bs_10049.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.caster).recordTable).SkillTime = (self.arglist)[1]
  self:AddSetHurtTrigger("bs_10049_1", 1, self.OnSetHurt, nil, self.caster)
end

bs_10049.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and ((self.caster).recordTable).SkillTime > 0 then
    local damage = (math.max)(context.hurt * (self.arglist)[2] // 1000)
    LuaSkillCtrl:RemoveLife(damage, self, context.sender, true)
    context.hurt = 0
    LuaSkillCtrl:CallFloatText(self.caster, 8)
    self:PlayChipEffect()
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.caster).recordTable).SkillTime = ((self.caster).recordTable).SkillTime - 1
  end
end

bs_10049.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10049

