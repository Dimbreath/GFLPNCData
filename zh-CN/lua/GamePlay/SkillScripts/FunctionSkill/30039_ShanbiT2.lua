local bs_30039 = class("bs_30039", LuaSkillBase)
local base = LuaSkillBase
bs_30039.config = {}
bs_30039.ctor = function(self)
  -- function num : 0_0
end

bs_30039.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["30039_Flag"] = true
end

bs_30039.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30039

