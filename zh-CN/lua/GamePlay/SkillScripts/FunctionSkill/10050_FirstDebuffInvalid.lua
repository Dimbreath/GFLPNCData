local bs_10050 = class("bs_10050", LuaSkillBase)
local base = LuaSkillBase
bs_10050.config = {}
bs_10050.ctor = function(self)
  -- function num : 0_0
end

bs_10050.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.caster).recordTable).buffTime = (self.arglist)[1]
  self:AddBeforeAddBuffTrigger("bs_10050_2", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

bs_10050.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if (context.buff).buffType == 2 and target == self.caster and ((self.caster).recordTable).buffTime > 0 then
    (context.buff).tier = 0
    self:PlayChipEffect()
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.caster).recordTable).buffTime = ((self.caster).recordTable).buffTime - 1
  end
end

bs_10050.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10050

