local bs_103903 = class("bs_103903", LuaSkillBase)
local base = LuaSkillBase
bs_103903.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 3000, def_formula = 9996, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000, hurt_type = -1}
, buffId = 66, buffTier = 1, effectUltID = 103901, effectHurt = 103902, effectSj = 103903, effect_speed = 10, effect_radius = 50, audioIdStart = 103902, audioIdMovie = 103903}
bs_103903.ctor = function(self)
  -- function num : 0_0
end

bs_103903.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.effectStart = nil
end

bs_103903.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
  ;
  (self.caster):LookAtTarget(inputTarget)
  self:CallCasterWait((self.arglist)[2] * 2)
  LuaSkillCtrl:CallRoleAction(self.caster, 1010)
  self.effectStart = LuaSkillCtrl:CallEffect(inputTarget, (self.config).effectUltID, self, nil, nil, nil, true)
  local totalEmitTime = (self.arglist)[2]
  LuaSkillCtrl:StartTimer(self, 2, (BindCallback(self, self.CallEffectAndEmissions, inputTarget)), nil, totalEmitTime - 1, 2)
end

bs_103903.CallEffectAndEmissions = function(self, inputTarget)
  -- function num : 0_3 , upvalues : _ENV
  local cusEffect = LuaSkillCtrl:CallEffect(inputTarget, (self.config).effectHurt, self, nil, nil, 0.1)
  local collisionTrigger = BindCallback(self, self.OnCollision, cusEffect)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, inputTarget, 30, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true, BindCallback(self, self.OnArive, cusEffect))
end

bs_103903.OnArive = function(self, cusEffect)
  -- function num : 0_4
  if cusEffect ~= nil and not cusEffect:IsDie() then
    cusEffect:Die()
  end
end

bs_103903.OnCollision = function(self, cusEffect, collider, index, entity)
  -- function num : 0_5 , upvalues : _ENV
  if cusEffect ~= nil and not cusEffect:IsDie() then
    cusEffect:Die()
  end
  if self.caster == nil or (self.caster).hp <= 0 or entity == nil or entity.hp <= 0 then
    return 
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]}, false)
  LuaSkillCtrl:CallEffect(entity, (self.config).effectSj, self)
  skillResult:EndResult()
  LuaSkillCtrl:ClearColliderOrEmission(collider)
end

bs_103903.PlayUltEffect = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_103903.OnUltRoleAction = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

bs_103903.OnSkipUltView = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnSkipUltView)(self)
  if self.roleActionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.roleActionAudio)
    self.roleActionAudio = nil
  end
end

bs_103903.OnMovieFadeOut = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  ;
  (base.OnMovieFadeOut)(self)
end

bs_103903.OnBreakSkill = function(self, role)
  -- function num : 0_10 , upvalues : base
  if role == self.caster then
    self:CancleCasterWait()
  end
  ;
  (base.OnBreakSkill)(self, role)
end

bs_103903.OnCasterDie = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnCasterDie)(self)
  if self.effectStart ~= nil then
    (self.effectStart):Die()
    self.effectStart = nil
  end
end

bs_103903.LuaDispose = function(self)
  -- function num : 0_12 , upvalues : base
  (base.LuaDispose)(self)
  if self.effectStart ~= nil then
    (self.effectStart):Die()
    self.effectStart = nil
  end
end

return bs_103903

