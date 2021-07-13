-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5021 = class("bs_5021", LuaSkillBase)
local base = LuaSkillBase
bs_5021.config = {}
bs_5021.ctor = function(self)
  -- function num : 0_0
end

bs_5021.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_5021_1", 10, self.OnSetHurt, self.caster)
end

bs_5021.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.sender == self.caster then
    context.hurt = context.hurt * (1000 + (self.arglist)[1]) // 1000
  end
end

bs_5021.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5021

