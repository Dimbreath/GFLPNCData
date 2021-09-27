local bs_10285 = class("bs_10285", LuaSkillBase)
local base = LuaSkillBase
bs_10285.config = {effectId = 10865, buffId_live = 3009, 
heal_config = {baseheal_formula = 501, heal_number = 0, correct_formula = 9990}
}
bs_10285.ctor = function(self)
  -- function num : 0_0
end

bs_10285.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_10285_2", 1, self.OnSetDeadHurt)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).time_limit_10285 = 1
end

bs_10285.OnSetDeadHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and (context.target).hp <= context.hurt and ((self.caster).recordTable).time_limit_10285 > 0 then
    LuaSkillCtrl:CallBuff(self, context.target, (self.config).buffId_live, 1, 15, true)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable).time_limit_10285 = 0
    local healNum = (context.target).maxHp * (self.arglist)[1] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {healNum}, true, true)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self)
    LuaSkillCtrl:DispelBuff(context.target, (self.config).buffId_live, 0, true)
  end
end

bs_10285.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10285

