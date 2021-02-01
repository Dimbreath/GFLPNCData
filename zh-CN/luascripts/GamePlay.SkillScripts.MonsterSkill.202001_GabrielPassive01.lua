-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202001 = class("bs_202001", LuaSkillBase)
local base = LuaSkillBase
bs_202001.config = {}
bs_202001.ctor = function(self)
  -- function num : 0_0
end

bs_202001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["515_arg"] = (self.arglist)[1]
end

bs_202001.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202001

