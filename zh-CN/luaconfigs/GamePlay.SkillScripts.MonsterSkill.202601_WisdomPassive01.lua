-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202601 = class("bs_202601", LuaSkillBase)
local base = LuaSkillBase
bs_202601.config = {}
bs_202601.ctor = function(self)
  -- function num : 0_0
end

bs_202601.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["521_Roll"] = (self.arglist)[1]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["521_arg2"] = (self.arglist)[2]
end

bs_202601.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202601

