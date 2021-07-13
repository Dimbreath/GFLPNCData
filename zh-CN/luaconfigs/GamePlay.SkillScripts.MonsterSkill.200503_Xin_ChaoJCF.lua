-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200503 = class("bs_200503", LuaSkillBase)
local base = LuaSkillBase
bs_200503.config = {
aoe_config = {effect_shape = 1, aoe_select_code = 4, aoe_range = 10}
, effectCFId = 123, startEffectId = 10105, endEffectId = 10106, buffId_67 = 67, buffId_1002 = 1002, buffID_1158 = 1158, maxHPId = 1003, buffTier = 1, startAnimId = 1002, loopAnimId = 1007, endAnimId = 1009, audioId1 = 48, buffId_196 = 196, 
HealConfig = {baseheal_formula = 501}
, skill_time = 33, skill_speed = 1, start_time = 14}
bs_200503.ctor = function(self)
  -- function num : 0_0
end

bs_200503.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_200503_1", 100, self.OnSetHurt, nil, self.caster)
end

bs_200503.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_196, 1, (self.arglist)[1] + (self.config).skill_time)
  local actionTotalTime = (self.config).skill_time + (self.arglist)[1]
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.caster, data)
  self:CallCasterWait(actionTotalTime)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).startEffectId, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimId, (self.config).skill_speed, (self.config).start_time, attackTrigger)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffID_1158, 1)
end

bs_200503.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.target ~= self.caster then
    return 
  end
  if (self.caster):GetBuffTier((self.config).buffId_1002) > 0 and not context.isRealDmg then
    local damageNum = context.hurt
    context.hurt = 0
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {damageNum})
    skillResult:EndResult()
  end
end

bs_200503.OnAttackTrigger = function(self, target, data)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectCFId, self, nil, nil, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1002, 1, (self.arglist)[1])
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
  skillResult:BuffResult((self.config).buffId_67, (self.config).buffTier, (self.arglist)[1])
  skillResult:EndResult()
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).loopAnimId, 1)
  LuaSkillCtrl:StartTimer(self, (self.arglist)[1], self.CallBack, self, 0, 0)
end

bs_200503.CallBack = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  end
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).endAnimId, 1)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).endEffectId, self)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
end

bs_200503.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_200503.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  (base.LuaDispose)(self)
  self.loopaudio = nil
  self.effect = nil
end

return bs_200503

