-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202601 = class("bs_202601", LuaSkillBase)
local base = LuaSkillBase
bs_202601.config = {}
bs_202601.ctor = function(self)
  -- function num : 0_0
end

bs_202601.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_202601_2", 1, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_202601_11", 1, self.OnBeforePlaySkill)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["521_Roll"] = (self.arglist)[1]
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["521_arg2"] = (self.arglist)[2]
end

bs_202601.OnSetHurt = function(self, context)
  -- function num : 0_2
end

bs_202601.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_3
end

bs_202601.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202601

