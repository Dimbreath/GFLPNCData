local bs_7007 = class("bs_7007", LuaSkillBase)
local base = LuaSkillBase
bs_7007.config = {effectId = 10701, 
hurt_config = {basehurt_formula = 10034}
}
bs_7007.ctor = function(self)
  -- function num : 0_0
end

bs_7007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_7007_4", 1, self.OnAfterHurt)
end

bs_7007.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if skill.isCommonAttack and sender == self.caster and not isMiss and hurt > 0 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 55, 10, target)
    if targetList.Count > 0 then
      local role = (targetList[0]).targetRole
      LuaSkillCtrl:CallEffect(role, (self.config).effectId, self, nil, target)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      print((self.arglist)[1])
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
      skillResult:EndResult()
    end
  end
end

bs_7007.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_7007

