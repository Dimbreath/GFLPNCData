-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_36 = class("bs_36", bs_1)
local base = bs_1
bs_36.config = {effectId_trail = 10736, effectId_start3 = 10738, effectId_start4 = 10738, effectId_JQ = 10740, effectId_JQL = 10742, effectId_JQR = 10743, effectId_JQhit = 10741, buffId_236 = 236, 
HurtConfig = {basehurt_formula = 10110}
, skill_time = 18, start_time = 8, actionId = 1008, action_speed = 1, baseActionSpd = 1}
bs_36.config = setmetatable(bs_36.config, {__index = base.config})
bs_36.ctor = function(self)
  -- function num : 0_0
end

bs_36.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_36.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : _ENV, base
  if (self.caster):GetBuffTier((self.config).buffId_236) > 0 then
    local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
    local atkSpeedRatio = 1
    local atkActionId = data.action1
    local atkTriggerFrame = 0
    atkSpeedRatio = self:CalcAtkActionSpeedForAirplane(atkSpeed, 2) * (self.config).baseActionSpd
    atkActionId = data.action2
    atkTriggerFrame = self:GetAtkTriggerFrameForAirplane(2, atkSpeed)
    local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data, (self.config).action_speed, (self.config).actionId, (self.config).start_time)
    self:CallCasterWait((self.config).skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
  else
    do
      ;
      (base.RealPlaySkill)(self, target, data)
    end
  end
end

bs_36.CalcAtkActionSpeedForAirplane = function(self, atkInterval, atkId)
  -- function num : 0_3
  local atkTotalFrames = (self.config).skill_time
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

bs_36.GetAtkTriggerFrameForAirplane = function(self, atkId, atkInterval)
  -- function num : 0_4
  local atkTotalFrames = (self.config).skill_time
  local triggerFrameCfg = (self.config).start_time
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

bs_36.OnAttackTrigger2 = function(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_JQ, self, self.SkillEventFunc2)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_JQL, self)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_JQR, self)
  if self.isDoubleAttack then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  else
    do
      self:CancleCasterWait()
    end
  end
end

bs_36.SkillEventFunc2 = function(self, effect, eventId, target)
  -- function num : 0_6 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Create then
    local arg1 = ((self.caster).recordTable).skill_arg1
    LuaSkillCtrl:CallEffect(target.targetRole, (self.config).effectId_JQhit, self)
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {arg1})
    skillResult:EndResult()
  end
end

bs_36.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_36

