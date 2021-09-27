local bs_30007 = class("bs_30007", LuaSkillBase)
local base = LuaSkillBase
bs_30007.config = {}
bs_30007.ctor = function(self)
  -- function num : 0_0
end

bs_30007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["30007_arg"] = true
end

bs_30007.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30007

