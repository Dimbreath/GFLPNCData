local bs_30041 = class("bs_30041", LuaSkillBase)
local base = LuaSkillBase
bs_30041.config = {}
bs_30041.ctor = function(self)
  -- function num : 0_0
end

bs_30041.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["30041_Flag"] = true
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["30041_arg"] = (self.arglist)[1]
end

bs_30041.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30041

