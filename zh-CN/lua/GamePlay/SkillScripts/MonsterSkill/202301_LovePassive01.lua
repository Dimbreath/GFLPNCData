local bs_202301 = class("bs_202301", LuaSkillBase)
local base = LuaSkillBase
bs_202301.config = {buffId_190 = 190, effectId = 10491, 
HealConfig = {baseheal_formula = 501}
}
bs_202301.ctor = function(self)
  -- function num : 0_0
end

bs_202301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_202301_3", 1, self.OnSetDeadHurt, nil, nil, nil, (self.caster).belongNum)
  self.time = 1
end

bs_202301.OnSetDeadHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).belongNum == (self.caster).belongNum and self.time > 0 and context.target ~= self.caster and (context.target).roleDataId ~= 15 then
    local hurt = (context.target).hp - 1
    context.hurt = 0
    LuaSkillCtrl:RemoveLife(hurt, self, context.target)
    local number = (self.caster).maxHp * (self.arglist)[1] // 1000
    LuaSkillCtrl:RemoveLife(number, self, self.caster, false, nil, true, false, eHurtType.RealDmg)
    LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {number})
    skillResult:EndResult()
    self.time = 0
  end
end

bs_202301.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202301

