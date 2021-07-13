-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102501 = class("bs_102501", LuaSkillBase)
local base = LuaSkillBase
bs_102501.config = {}
bs_102501.ctor = function(self)
  -- function num : 0_0
end

bs_102501.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).passive = true
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).passive_arg1 = (self.arglist)[1]
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).passive_arg2 = (self.arglist)[2]
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).cs_Passive = self.cskill
end

bs_102501.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102501

