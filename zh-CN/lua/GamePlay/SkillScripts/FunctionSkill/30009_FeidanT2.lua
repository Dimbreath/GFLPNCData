local bs_30009 = class("bs_30009", LuaSkillBase)
local base = LuaSkillBase
bs_30009.config = {}
bs_30009.ctor = function(self)
  -- function num : 0_0
end

bs_30009.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["30009_arg"] = true
end

bs_30009.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30009

