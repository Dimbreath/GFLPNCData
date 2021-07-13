-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_7002 = class("bs_7002", LuaSkillBase)
local base = LuaSkillBase
bs_7002.config = {effectId = 10818, 
hurt_config = {basehurt_formula = 10034}
}
bs_7002.ctor = function(self)
  -- function num : 0_0
end

bs_7002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_7002_3", 1, self.OnAfterHurt, self.caster)
end

bs_7002.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if skill.isCommonAttack and sender == self.caster and not isMiss and hurt > 0 then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 55, 10, target)
    if targetList.Count > 0 then
      local role = (targetList[0]).targetRole
      LuaSkillCtrl:CallEffect(role, (self.config).effectId, self, nil, target)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
      skillResult:EndResult()
    end
  end
end

bs_7002.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_7002

