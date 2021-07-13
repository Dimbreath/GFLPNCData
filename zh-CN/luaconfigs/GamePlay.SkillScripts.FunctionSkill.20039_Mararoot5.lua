-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20039 = class("bs_20039", LuaSkillBase)
local base = LuaSkillBase
bs_20039.config = {}
bs_20039.ctor = function(self)
  -- function num : 0_0
end

bs_20039.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30001 and (self.caster).roleDataId ~= 30002 then
    return 
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["20039_root5arg"] = true
end

bs_20039.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20039

