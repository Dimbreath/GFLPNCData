local bs_10294 = class("bs_10294", LuaSkillBase)
local base = LuaSkillBase
bs_10294.config = {
heal_config = {baseheal_formula = 501, heal_number = 0, correct_formula = 9990}
}
bs_10294.ctor = function(self)
  -- function num : 0_0
end

bs_10294.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10294_10", 1, self.OnRoleDie)
end

bs_10294.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum == (self.caster).belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    if (self.caster).hp > 0 then
      local healNum = role.maxHp * (self.arglist)[1] // 1000
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {healNum}, true, true)
      skillResult:EndResult()
    end
  end
end

bs_10294.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10294

