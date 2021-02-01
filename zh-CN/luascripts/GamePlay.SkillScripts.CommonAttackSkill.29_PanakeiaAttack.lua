-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_29 = class("bs_29", bs_1)
local base = bs_1
bs_29.config = {action1 = 1004, action2 = 1004, action3 = 1001, effectId = 10653, effectId_green = 10653, effectId_zong = 10656, effectId_p = 10658, effectId_heal = 10660, buffId = 216, 
HealConfig = {baseheal_formula = 501}
, effectStartId = 10663, effectStartId3 = 10663, effectStartId_zong = 10662, effectStartId_green = 10663}
bs_29.config = setmetatable(bs_29.config, {__index = base.config})
bs_29.ctor = function(self)
  -- function num : 0_0
end

bs_29.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.again = 0
end

bs_29.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : base, _ENV
  if ((self.caster).recordTable).rool_num == nil then
    (base.RealPlaySkill)(self, target, data)
  end
  if ((self.caster).recordTable).rool_num ~= nil then
    self:CallSelectEffect()
    local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
    local atkSpeedRatio = 1
    local atkActionId = (self.config).action1
    local atkTriggerFrame = 0
    if LuaSkillCtrl:CallRange(1, 1000) <= ((self.caster).recordTable).rool_num and target:GetBuffTier((self.config).buffId) > 0 then
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkActionId = (self.config).action3
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
    else
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2)
      atkActionId = (self.config).action2
      atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
    end
    local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId)
    local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
    if waitTime > 0 then
      self:CallCasterWait(waitTime)
    end
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
  end
end

bs_29.OnAttackTrigger2 = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_3 , upvalues : _ENV
  if atkActionId == data.action2 then
    LuaSkillCtrl:CallEffect(target, (self.config).effectStartId_green, self)
    LuaSkillCtrl:CallEffectWithArg(target, data.effectId_green, self, true, self.SkillEventFunc2, data, 1)
  end
  if atkActionId == data.action3 then
    LuaSkillCtrl:CallEffect(target, (self.config).effectStartId_zong, self)
    LuaSkillCtrl:CallEffectWithArg(target, data.effectId_zong, self, true, self.SkillEventFunc2, data, 2)
  end
end

bs_29.SkillEventFunc2 = function(self, data, Id, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if Id == 2 and eventId == eBattleEffectEvent.Trigger then
    local target_now = target.targetRole
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target_now)
    LuaSkillCtrl:HurtResult(skillResult, generalHurtConfig)
    skillResult:EndResult()
    if target_now:GetBuffTier((self.config).buffId) > 0 then
      local num = 1 - target_now.attackRange
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, num, target_now)
      if targetlist.Count > 0 then
        local num_1 = target_now:GetBuffTier((self.config).buffId)
        local num_2 = targetlist.Count
        local arg = ((self.caster).recordTable).heal_num
        local heal_num = (self.caster).skill_intensity * arg * num_1 // num_2 // 1000
        for i = 0, targetlist.Count - 1 do
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[i]).targetRole)
          LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {heal_num})
          skillResult:EndResult()
        end
        if ((self.caster).recordTable).skill ~= nil then
          if ((self.caster).recordTable).skill > 0 then
            if LuaSkillCtrl:CallRange(1, 1000) <= ((self.caster).recordTable).skill_rool and self.again == 0 then
              LuaSkillCtrl:CallEffect(target_now, (self.config).effectId_heal, self)
              self.again = 1
              return 
            else
              LuaSkillCtrl:DispelBuff(target_now, (self.config).buffId, 0, true)
              LuaSkillCtrl:CallEffect(target_now, (self.config).effectId_heal, self)
              self.again = 0
            end
          else
            LuaSkillCtrl:DispelBuff(target_now, (self.config).buffId, 0, true)
            LuaSkillCtrl:CallEffect(target_now, (self.config).effectId_heal, self)
          end
        end
      else
        do
          do
            if targetlist.Count == 0 then
              if ((self.caster).recordTable).skill > 0 then
                if LuaSkillCtrl:CallRange(1, 1000) <= ((self.caster).recordTable).skill_rool then
                  LuaSkillCtrl:CallEffect(target_now, (self.config).effectId_heal, self)
                  return 
                else
                  LuaSkillCtrl:DispelBuff(target_now, (self.config).buffId, 0, true)
                  LuaSkillCtrl:CallEffect(target_now, (self.config).effectId_heal, self)
                end
              else
                LuaSkillCtrl:DispelBuff(target_now, (self.config).buffId, 0, true)
                LuaSkillCtrl:CallEffect(target_now, (self.config).effectId_heal, self)
              end
            end
            if Id == 1 and eventId == eBattleEffectEvent.Trigger then
              local target_now = target.targetRole
              local skillResult = LuaSkillCtrl:CallSkillResult(effect, target_now)
              LuaSkillCtrl:HurtResult(skillResult, generalHurtConfig)
              skillResult:EndResult()
              LuaSkillCtrl:CallEffect(target_now, (self.config).effectId_p, self)
              LuaSkillCtrl:CallBuff(self, target_now, (self.config).buffId, 1, nil, true)
            end
          end
        end
      end
    end
  end
end

bs_29.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_29

