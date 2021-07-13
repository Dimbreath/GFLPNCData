-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20046 = class("bs_20046", LuaSkillBase)
local base = LuaSkillBase
bs_20046.config = {}
bs_20046.ctor = function(self)
  -- function num : 0_0
end

bs_20046.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30003 then
    return 
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["20046_root4arg1"] = (self.arglist)[1]
end

bs_20046.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20046

