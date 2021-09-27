local bs_301 = class("bs_301", LuaSkillBase)
local base = LuaSkillBase
bs_301.config = {
hurt_config = {def_formula = 9996, basehurt_formula = 10031, minhurt_formula = 9994, correct_formula = 9989}
, buffId1 = 130, buffId2 = 66, buffId3 = 131, buffId4 = 132, effectId1 = 10128, effectId2 = 10129, effectId3 = 10130}
bs_301.ctor = function(self)
  -- function num : 0_0
end

bs_301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_301.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 32, 10)
  if targetList.Count == 0 then
    return 
  end
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

bs_301.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  local Effect_301 = LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self, nil, nil, 1, true)
  local roadTrigger = BindCallback(self, self.CallBack, target)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 40, 3, eColliderInfluenceType.Enemy, roadTrigger, nil, nil, Effect_301, false, true, nil)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["301_effect_bj"] = LuaSkillCtrl:CallEffect(target, (self.config).effectId3, self)
end

bs_301.CallBack = function(self, target, collider, index, entity)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(entity, (self.config).effectId1, self)
  LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId1, 1, 10)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  skillResult:HurtResult((self.config).hurt_config)
  skillResult:EndResult()
  if entity == target then
    LuaSkillCtrl:StartTimer(self, 10, function()
    -- function num : 0_4_0 , upvalues : _ENV, self, entity
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId2, 1, (self.arglist)[2])
  end
, self, 0, 0)
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId3, 1, (self.arglist)[2] + (self.arglist)[3] + 10)
    if (self.arglist)[4] >= 0 then
      LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId4, 1, (self.arglist)[2] + (self.arglist)[3] + 10)
    end
  end
  if entity == target and ((self.caster).recordTable)["301_effect_bj"] ~= nil then
    (((self.caster).recordTable)["301_effect_bj"]):Die()
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["301_effect_bj"] = nil
  end
end

bs_301.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_301

