-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_34 = class("bs_34", bs_1)
local base = bs_1
bs_34.config = {effectId_trail = 10712, effectId_P = 10732, effectId_hit = 10713, effectId_hit2 = 10730, effectId_new = 10747, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10086, crit_formula = 0, crithur_ratio = 0}
, ex_hurttime = 3}
bs_34.config = setmetatable(bs_34.config, {__index = base.config})
bs_34.ctor = function(self)
  -- function num : 0_0
end

bs_34.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_34.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  -- function num : 0_2 , upvalues : _ENV, base
  if ((self.caster).recordTable).passive == true and ((self.caster).recordTable).passive_arg2 > 0 then
    local cusEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId_P, self)
    local collisionTrigger = BindCallback(self, self.OnCollision, target)
    self.skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 15, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, true, nil)
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_new, self)
    if self.isDoubleAttack then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
      self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
    else
      do
        do
          self:CancleCasterWait()
          ;
          (base.OnAttackTrigger)(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
        end
      end
    end
  end
end

bs_34.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, configData.audioId5)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
    skillResult:EndResult()
    if ((self.caster).recordTable).passive == true then
      local _Cskill = ((self.caster).recordTable).cs_Passive
      do
        LuaSkillCtrl:StartTimer(nil, (self.config).ex_hurttime, function()
    -- function num : 0_3_0 , upvalues : _ENV, _Cskill, target, self
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {((self.caster).recordTable).passive_arg1})
    skillResult:EndResult()
  end
)
      end
    end
  end
end

bs_34.OnCollision = function(self, target, collider, index, entity)
  -- function num : 0_4 , upvalues : _ENV
  if self.caster == nil or (self.caster).hp <= 0 then
    return 
  end
  local arg1 = ((self.caster).recordTable).passive_arg1
  if LuaSkillCtrl:RoleContainsBuffFeature(entity, eBuffFeatureType.NotBeSelected) == false then
    LuaSkillCtrl:CallEffect(entity, (self.config).effectId_hit2, self)
    if entity == target then
      LuaSkillCtrl:StartTimer(nil, (self.config).ex_hurttime, function()
    -- function num : 0_4_0 , upvalues : _ENV, self, entity, target
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
    skillResult:EndResult()
  end
)
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.caster).recordTable).lastAttackRole = target
    end
    local _Cskill = ((self.caster).recordTable).cs_Passive
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, entity)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {arg1})
    skillResult:EndResult()
  end
end

bs_34.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_34.LuaDispose = function(self)
  -- function num : 0_6 , upvalues : base
  self.skillEmission = nil
  ;
  (base.LuaDispose)(self)
end

return bs_34

