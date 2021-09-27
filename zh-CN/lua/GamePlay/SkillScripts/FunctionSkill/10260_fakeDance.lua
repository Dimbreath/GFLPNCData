local bs_10260 = class("bs_10260", LuaSkillBase)
local base = LuaSkillBase
bs_10260.config = {effectId1 = 10704, effectId2 = 10702, 
hurt_config = {basehurt_formula = 10034}
}
bs_10260.ctor = function(self)
  -- function num : 0_0
end

bs_10260.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10260_1", 1, self.OnAfterHurt, self.caster)
end

bs_10260.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if skill.isCommonAttack and sender == self.caster and not isMiss and hurt > 0 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 55, 10, target)
    if targetList.Count > 0 then
      local role = (targetList[0]).targetRole
      LuaSkillCtrl:CallEffect(role, (self.config).effectId1, self, nil, target)
      LuaSkillCtrl:CallEffect(role, (self.config).effectId2, self, nil, target)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
      skillResult:EndResult()
    end
  end
end

bs_10260.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10260

