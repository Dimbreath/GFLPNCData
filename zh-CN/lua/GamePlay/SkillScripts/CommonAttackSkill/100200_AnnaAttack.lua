local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100200 = class("bs_100200", bs_1)
local base = bs_1
bs_100200.config = {effectId_11 = 100201, effectId_action_1 = 100203, effectId_22 = 100202, effectId_action_2 = 100204}
bs_100200.config = setmetatable(bs_100200.config, {__index = base.config})
bs_100200.ctor = function(self)
  -- function num : 0_0
end

bs_100200.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100200.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  -- function num : 0_2 , upvalues : _ENV
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    if extraTarget ~= nil then
      self:CallShoot(extraTarget, data, atkActionId)
    end
    self:CallShoot(target, data, atkActionId)
  else
    do
      self:BreakSkill()
      if self.isDoubleAttack then
        local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
        self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
      else
        do
          self:CancleCasterWait()
        end
      end
    end
  end
end

bs_100200.CallShoot = function(self, target, data, atkActionId)
  -- function num : 0_3 , upvalues : _ENV
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
end

bs_100200.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_4 , upvalues : base
  (base.SkillEventFunc)(self, configData, effect, eventId, target)
end

bs_100200.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100200

