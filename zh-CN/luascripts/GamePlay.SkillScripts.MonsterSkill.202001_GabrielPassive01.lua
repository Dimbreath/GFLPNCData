-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202001 = class("bs_202001", LuaSkillBase)
local base = LuaSkillBase
bs_202001.config = {}
bs_202001.ctor = function(self)
  -- function num : 0_0
end

bs_202001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_202001_11", 1, self.OnBeforePlaySkill)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["515_arg"] = (self.arglist)[1]
end

bs_202001.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_2
end

bs_202001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202001

