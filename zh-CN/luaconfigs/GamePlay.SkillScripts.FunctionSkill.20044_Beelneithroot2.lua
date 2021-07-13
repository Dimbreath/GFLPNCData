-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20044 = class("bs_20044", LuaSkillBase)
local base = LuaSkillBase
bs_20044.config = {}
bs_20044.ctor = function(self)
  -- function num : 0_0
end

bs_20044.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30003 then
    return 
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["20044_root2arg1"] = (self.arglist)[1]
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["20044_root2arg2"] = (self.arglist)[2]
end

bs_20044.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20044

