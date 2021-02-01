-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50008 = class("bs_50008", LuaSkillBase)
local base = LuaSkillBase
bs_50008.config = {}
bs_50008.ctor = function(self)
  -- function num : 0_0
end

bs_50008.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_50008_2", 1, self.OnSetHurt)
end

bs_50008.OnSetHurt = function(self, context)
  -- function num : 0_2
  if (context.sender).attackRange == 1 and context.target == self.caster then
    context.hurt = context.hurt * (1000 - (self.arglist)[1]) // 1000
  end
end

bs_50008.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50008

