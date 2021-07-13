-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_6 = class("bs_6", bs_1)
local base = bs_1
bs_6.config = {effectId_11 = 10043, effectId_action_1 = 10045, effectId_22 = 10044, effectId_action_2 = 10046, audioId4 = 8}
bs_6.config = setmetatable(bs_6.config, {__index = base.config})
bs_6.ctor = function(self)
  -- function num : 0_0
end

bs_6.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_6.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  -- function num : 0_2 , upvalues : _ENV
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
    if (self.config).audioId4 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId4)
    end
    if atkActionId == (self.config).action1 then
      LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_1, self)
      LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId_11, self, true, false, self.SkillEventFunc, data)
    else
      LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_2, self)
      LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId_22, self, true, false, self.SkillEventFunc, data)
    end
  else
    self:BreakSkill()
  end
  if self.isDoubleAttack then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  else
    do
      self:CancleCasterWait()
    end
  end
end

bs_6.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_3 , upvalues : base
  (base.SkillEventFunc)(self, configData, effect, eventId, target)
end

bs_6.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6

