local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_532 = class("bs_532", bs_1)
local base = bs_1
bs_532.config = {
HurtConfig = {}
, 
heal_config = {baseheal_formula = 10174, heal_number = 0, correct_formula = 9990}
, effectId_trail1 = 10912, effectId_trail = 10579, effectId_trailBoom = 10916}
bs_532.config = setmetatable(bs_532.config, {__index = base.config})
bs_532.ctor = function(self)
  -- function num : 0_0
end

bs_532.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.three = false
end

bs_532.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : _ENV
  self.three = ((self.caster).recordTable)["203204_attakflag"]
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  if self.three then
    ((self.caster).recordTable)["203204_attakflag"] = false
  end
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.caster).recordTable).lastAttackRole = target
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if waitTime > 0 then
    self:CallCasterWait(waitTime + 2)
  end
  if self.three == true then
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
  end
end

bs_532.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  -- function num : 0_3 , upvalues : _ENV, base
  if self.three == true then
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    self:CallColliderEmission(target)
    if extraTarget ~= nil then
      self:CallColliderEmission(extraTarget)
    end
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

bs_532.CallColliderEmission = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  local collisionTrigger = BindCallback(self, self.OnCollision, target)
  local cusEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId_trail1, self, nil, nil, 0.5)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 5, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true, (BindCallback(self, self.OnEmissionArive)), nil)
end

bs_532.OnEmissionArive = function(self, emission)
  -- function num : 0_5
  if self.cusEffect ~= nil then
    (self.cusEffect):Die()
    self.cusEffect = nil
  end
end

bs_532.OnCollision = function(self, target, collider, index, entity)
  -- function num : 0_6 , upvalues : _ENV
  if self.caster == nil or (self.caster).hp <= 0 or entity:GetBuffTier((self.config).buffId_tip) > 0 then
    return 
  end
  local _Cskill = ((self.caster).recordTable).cs_Skill
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
  skillResult:EndResult()
  if ((self.caster).recordTable)["203204_arg"] ~= nil then
    local arg = ((self.caster).recordTable)["203204_arg"]
    local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult1, (self.config).heal_config, {arg})
    skillResult:EndResult()
  end
  do
    LuaSkillCtrl:CallEffect(entity, (self.config).effectId_trailBoom, self)
  end
end

bs_532.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
  if self.cusEffect ~= nil then
    (self.cusEffect):Die()
    self.cusEffect = nil
  end
end

bs_532.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  if self.cusEffect ~= nil then
    (self.cusEffect):Die()
    self.cusEffect = nil
  end
end

return bs_532

