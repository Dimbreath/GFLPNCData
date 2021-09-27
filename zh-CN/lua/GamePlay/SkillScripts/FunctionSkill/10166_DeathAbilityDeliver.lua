local bs_10166 = class("bs_10166", LuaSkillBase)
local base = LuaSkillBase
bs_10166.config = {buffId1 = 1019, buffId2 = 1012, atkFormula = 10134, skillIntensityFormula = 10135}
bs_10166.ctor = function(self)
  -- function num : 0_0
end

bs_10166.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10166_10", 1, self.OnRoleDie)
end

bs_10166.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum == (self.caster).belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    local atkTier = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).atkFormula, self.caster, role, self)
    local defTier = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).skillIntensityFormula, self.caster, role, self)
    if atkTier < 1 or defTier < 1 then
      return 
    end
    ;
    (self.caster):AddRoleProperty(eHeroAttr.pow, atkTier, eHeroAttrType.Extra)
    ;
    (self.caster):AddRoleProperty(eHeroAttr.skill_intensity, defTier, eHeroAttrType.Extra)
  end
end

bs_10166.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10166

