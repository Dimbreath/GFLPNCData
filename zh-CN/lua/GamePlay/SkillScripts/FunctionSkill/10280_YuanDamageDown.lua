local bs_10280 = class("bs_10280", LuaSkillBase)
local base = LuaSkillBase
bs_10280.config = {}
bs_10280.ctor = function(self)
  -- function num : 0_0
end

bs_10280.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10280_setHurt", 1, self.OnSetHurt, nil, self.caster)
end

bs_10280.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.target == self.caster and (context.skill).SkillRange > 1 then
    context.hurt = context.hurt - context.hurt * (self.arglist)[1] // 1000
  end
end

bs_10280.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10280

