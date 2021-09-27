local bs_309 = class("bs_309", LuaSkillBase)
local base = LuaSkillBase
bs_309.config = {
heal_config = {baseheal_formula = 1047, heal_number = 0, correct_formula = 9990}
, effectId2 = 10141, buffId = 66}
bs_309.ctor = function(self)
  -- function num : 0_0
end

bs_309.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_309_1", 1, self.OnSetHeal, nil, nil, nil, nil, nil, nil, 309)
end

bs_309.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.skill).dataId == 309 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 1, context.target)
    if targetList.Count == 0 then
      return 
    end
    for i = 0, targetList.Count - 1 do
      local distance = LuaSkillCtrl:GetRoleGridsDistance((targetList[i]).targetRole, context.target)
      if distance < 2 then
        LuaSkillCtrl:RemoveLife(context.heal * 300 // 1000, self, (targetList[i]).targetRole)
        if (self.arglist)[3] >= 0 then
          LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId, 1, 15, true)
        end
      end
    end
  end
end

bs_309.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 30, 10)
  if targetList.Count == 0 then
    return 
  end
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

bs_309.OnAttackTrigger = function(self, target, data)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self, self.SkillEventFunc)
end

bs_309.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if effect.dataId == (self.config).effectId1 and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
    skillResult:EndResult()
  end
end

bs_309.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_309

