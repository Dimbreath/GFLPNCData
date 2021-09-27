local bs_10278 = class("bs_10278", LuaSkillBase)
local base = LuaSkillBase
bs_10278.config = {shieldFormula = 10087}
bs_10278.ctor = function(self)
  -- function num : 0_0
end

bs_10278.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10278_2", 2, self.OnAfterPlaySkill)
end

bs_10278.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 30, 10)
    if targetlist.Count < 1 then
      return 
    end
    local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).shieldFormula, self.caster, nil, self)
    local targetRole = (targetlist[0]).targetRole
    if targetRole ~= nil and targetRole.hp > 0 then
      LuaSkillCtrl:AddRoleShield(targetRole, eShieldType.Normal, shieldValue)
    end
  end
end

bs_10278.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10278

