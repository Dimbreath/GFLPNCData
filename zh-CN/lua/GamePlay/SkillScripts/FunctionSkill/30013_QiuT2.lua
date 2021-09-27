local bs_30013 = class("bs_30013", LuaSkillBase)
local base = LuaSkillBase
bs_30013.config = {}
bs_30013.ctor = function(self)
  -- function num : 0_0
end

bs_30013.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["30013_arg"] = true
end

bs_30013.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30013

