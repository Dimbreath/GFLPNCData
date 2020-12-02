-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10166 = class("bs_10166", LuaSkillBase)
local base = LuaSkillBase
bs_10166.config = {buffId1 = 1019, buffId2 = 1012, atkFormula = 10034, skillIntensityFormula = 10076}
bs_10166.ctor = function(self)
  -- function num : 0_0
end

bs_10166.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10166_10", 1, self.OnRoleDie)
end

bs_10166.OnRoleDie = function(self, killer, role)
  -- function num : 0_2
end

bs_10166.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : _ENV, base
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 34, 10)
  if targetList.Count > 0 then
    local atkTier = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).atkFormula, self.caster, targetRole, self)
    local defTier = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).skillIntensityFormula, self.caster, targetRole, self)
    if atkTier < 1 or defTier < 1 then
      return 
    end
    local target = (targetList[0]).targetRole
    target:AddRoleProperty(eHeroAttr.pow, atkTier, eHeroAttrType.Extra)
    target:AddRoleProperty(eHeroAttr.skill_intensity, defTier, eHeroAttrType.Extra)
  end
  do
    ;
    (base.OnCasterDie)(self)
  end
end

return bs_10166

