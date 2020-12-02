-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50007 = class("bs_50007", LuaSkillBase)
local base = LuaSkillBase
bs_50007.config = {}
bs_50007.ctor = function(self)
  -- function num : 0_0
end

bs_50007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_50007_2", 1, self.OnSetHurt)
end

bs_50007.OnSetHurt = function(self, context)
  -- function num : 0_2
  if (context.sender).attackRange > 1 and context.target == self.caster then
    context.hurt = context.hurt * (1000 - (self.arglist)[1]) // 1000
  end
end

bs_50007.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50007

