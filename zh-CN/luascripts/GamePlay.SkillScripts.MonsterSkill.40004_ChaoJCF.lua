-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40004 = class("bs_40004", LuaSkillBase)
local base = LuaSkillBase
bs_40004.config = {
aoe_config = {effect_shape = 1, aoe_select_code = 4, aoe_range = 10}
, effectCFId = 123, startEffectId = 10105, endEffectId = 10106, buffId = 67, defBuffId = 1002, maxHPId = 1003, buffTier = 1, startAnimId = 1002, loopAnimId = 1007, endAnimId = 1009, audioId1 = 48}
bs_40004.ctor = function(self)
  -- function num : 0_0
end

bs_40004.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_40004_1", 100, self.OnSetHurt)
end

bs_40004.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local actionTotalTime = 33 + (self.arglist)[1]
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.caster, data)
  self:CallCasterWait(actionTotalTime)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).startEffectId, self)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimId, 1, 14, attackTrigger)
  self.loopaudio = ((self.caster).auSource):PlayAudioById((self.config).audioId1)
end

bs_40004.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.target ~= self.caster then
    return 
  end
  if (self.caster):GetBuffTier((self.config).defBuffId) > 0 then
    local damageNum = context.hurt
    context.hurt = 0
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).maxHPId, damageNum)
    LuaSkillCtrl:CallHeal(damageNum, self, self.caster)
  end
end

bs_40004.OnAttackTrigger = function(self, target, data)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectCFId, self)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).defBuffId, 1, (self.arglist)[1])
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
  skillResult:BuffResult((self.config).buffId, (self.config).buffTier, (self.arglist)[1])
  skillResult:EndResult()
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).loopAnimId, 1)
  self.damTimer = LuaSkillCtrl:StartTimer(self, (self.arglist)[1], self.CallBack, self, 0, 0)
end

bs_40004.CallBack = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.loopaudio ~= nil then
    AudioManager:StopAudioByBack(self.loopaudio)
  end
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).endAnimId, 1)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).endEffectId, self)
end

bs_40004.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40004

