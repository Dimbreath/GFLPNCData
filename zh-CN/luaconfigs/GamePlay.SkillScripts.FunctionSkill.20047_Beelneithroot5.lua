-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20047 = class("bs_20047", LuaSkillBase)
local base = LuaSkillBase
bs_20047.config = {buffId1 = 164, buffId2 = 256, skillDelay = 60}
bs_20047.ctor = function(self)
  -- function num : 0_0
end

bs_20047.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30003 then
    return 
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["20047_root2arg1"] = (self.arglist)[1]
end

bs_20047.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20047

