-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_34 = class("bs_34", bs_1)
local base = bs_1
bs_34.config = {effectId = 10712, effectId_P = 10732, effectId_hit = 10713, effectId_hit2 = 10730, effectId_new = 10747, 
HurtConfig = {basehurt_formula = 10086, crit_formula = 0}
}
bs_34.config = setmetatable(bs_34.config, {__index = base.config})
bs_34.ctor = function(self)
  -- function num : 0_0
end

bs_34.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_34.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_2 , upvalues : _ENV, base
  if ((self.caster).recordTable).passive == true then
    local cusEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId_P, self)
    local collisionTrigger = BindCallback(self, self.OnCollision, target)
    self.skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 15, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, true, nil)
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_new, self)
  else
    do
      ;
      (base.OnAttackTrigger)(self, target, data, atkSpeedRatio, atkActionId)
    end
  end
end

bs_34.OnCollision = function(self, target, index, entity)
  -- function num : 0_3 , upvalues : _ENV
  local arg1 = ((self.caster).recordTable).passive_arg1
  local arg2 = ((self.caster).recordTable).passive_arg2
  if LuaSkillCtrl:RoleContainsBuffFeature(entity, eBuffFeatureType.NotBeSelected) == false then
    if arg2 > 0 then
      LuaSkillCtrl:CallEffect(entity, (self.config).effectId_hit2, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {arg1})
      skillResult:EndResult()
      if entity == target then
        LuaSkillCtrl:CallEffect(entity, (self.config).effectId_hit, self)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
        LuaSkillCtrl:HurtResult(skillResult, generalHurtConfig)
        skillResult:EndResult()
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R8 in 'UnsetPending'

        ;
        ((self.caster).recordTable).lastAttackRole = target
      end
    else
      do
        if entity == target then
          LuaSkillCtrl:CallEffect(entity, (self.config).effectId_hit, self)
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
          LuaSkillCtrl:HurtResult(skillResult, generalHurtConfig)
          skillResult:EndResult()
          -- DECOMPILER ERROR at PC87: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((self.caster).recordTable).lastAttackRole = target
        else
          do
            LuaSkillCtrl:CallEffect(entity, (self.config).effectId_hit2, self)
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
            LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {arg1})
            skillResult:EndResult()
          end
        end
      end
    end
  end
end

bs_34.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_34

