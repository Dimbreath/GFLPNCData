local bs_20035 = class("bs_20035", LuaSkillBase)
local base = LuaSkillBase
bs_20035.config = {}
bs_20035.ctor = function(self)
  -- function num : 0_0
end

bs_20035.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30001 and (self.caster).roleDataId ~= 30002 then
    return 
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["20035_root1arg"] = (self.arglist)[1]
end

bs_20035.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20035

