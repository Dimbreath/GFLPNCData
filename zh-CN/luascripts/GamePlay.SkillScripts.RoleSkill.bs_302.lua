-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_302 = class("bs_302", LuaSkillBase)
local base = LuaSkillBase
bs_302.config = {
hurt_config1 = {def_formula = 9996, basehurt_formula = 10031, minhurt_formula = 9994, correct_formula = 9989}
, 
hurt_config2 = {def_formula = 9996, basehurt_formula = 10032, minhurt_formula = 9994, correct_formula = 9989}
, effectId1 = 10131, effectId2 = 10132, buffId = 134}
bs_302.ctor = function(self)
  -- function num : 0_0
end

bs_302.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_302_1", 1, self.OnAfterHurt)
end

bs_302.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
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

bs_302.OnAttackTrigger = function(self, target, date)
  -- function num : 0_3 , upvalues : _ENV
  local Effect_302_1 = LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self, nil, nil, 1, true)
  self.hurtIndex = 0
  local collisionTrigger = BindCallback(self, self.OnCollision1)
  self.__onOver = BindCallback(self, self.OnOver)
  local ariveFunc = BindCallback(self, (self.self).OnEmissionArrive)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 40, 8, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, Effect_302_1, true, false, ariveFunc)
end

bs_302.OnCollision1 = function(self, index, entity)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(entity, (self.config).effectId2, self)
  if self.hurtIndex == 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    skillResult:HurtResult((self.config).hurt_config1)
    skillResult:EndResult()
  else
    do
      if self.hurtIndex == 1 then
        local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
        skillResult1:HurtResult((self.config).hurt_config2)
        skillResult1:EndResult()
      end
    end
  end
end

bs_302.OnEmissionArrive = function(self, skillEmission)
  -- function num : 0_5 , upvalues : _ENV
  self.hurtIndex = self.hurtIndex + 1
  LuaSkillCtrl:CallRestartEmit(self, skillEmission, 8, self.caster, true, true, self.__onOver)
end

bs_302.OnOver = function(self)
  -- function num : 0_6
  self.hurtIndex = 0
end

bs_302.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_7 , upvalues : _ENV
  if target.hp <= hurt and skill.dataId == 302 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
  end
end

bs_302.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_302

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_302 = class("bs_302", LuaSkillBase)
local base = LuaSkillBase
bs_302.config = {
    hurt_config1 = {
        def_formula = 9996,
        basehurt_formula = 10031,
        minhurt_formula = 9994,
        correct_formula = 9989
    },
    hurt_config2 = {
        def_formula = 9996,
        basehurt_formula = 10032,
        minhurt_formula = 9994,
        correct_formula = 9989
    },
    effectId1 = 10131,
    effectId2 = 10132,
    buffId = 134
}
bs_302.ctor = function(self)
    -- function num : 0_0
end

bs_302.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_302_1", 1, self.OnAfterHurt)
end

bs_302.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
    if targetList.Count == 0 then return end
    LuaSkillCtrl:CallBreakAllSkill(self.caster);
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    self:CallCasterWait(30)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger,
                                       (targetList[0]).targetRole, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20,
                                           attackTrigger)
end

bs_302.OnAttackTrigger = function(self, target, date)
    -- function num : 0_3 , upvalues : _ENV
    local Effect_302_1 = LuaSkillCtrl:CallEffect(target,
                                                 (self.config).effectId1, self,
                                                 nil, nil, 1, true)
    self.hurtIndex = 0
    local collisionTrigger = BindCallback(self, self.OnCollision1)
    self.__onOver = BindCallback(self, self.OnOver)
    local ariveFunc = BindCallback(self, (self.self).OnEmissionArrive)
    local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self,
                                                                     self.caster,
                                                                     target, 40,
                                                                     8,
                                                                     eColliderInfluenceType.Enemy,
                                                                     collisionTrigger,
                                                                     nil, nil,
                                                                     Effect_302_1,
                                                                     true,
                                                                     false,
                                                                     ariveFunc)
end

bs_302.OnCollision1 = function(self, index, entity)
    -- function num : 0_4 , upvalues : _ENV
    LuaSkillCtrl:CallEffect(entity, (self.config).effectId2, self)
    if self.hurtIndex == 0 then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
        skillResult:HurtResult((self.config).hurt_config1)
        skillResult:EndResult()
    else
        do
            if self.hurtIndex == 1 then
                local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                          entity)
                skillResult1:HurtResult((self.config).hurt_config2)
                skillResult1:EndResult()
            end
        end
    end
end

bs_302.OnEmissionArrive = function(self, skillEmission)
    -- function num : 0_5 , upvalues : _ENV
    self.hurtIndex = self.hurtIndex + 1
    LuaSkillCtrl:CallRestartEmit(self, skillEmission, 8, self.caster, true,
                                 true, self.__onOver)
end

bs_302.OnOver = function(self)
    -- function num : 0_6
    self.hurtIndex = 0
end

bs_302.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit,
                              isRealDmg)
    -- function num : 0_7 , upvalues : _ENV
    if target.hp <= hurt and skill.dataId == 302 then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
    end
end

bs_302.OnCasterDie = function(self)
    -- function num : 0_8 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_302

