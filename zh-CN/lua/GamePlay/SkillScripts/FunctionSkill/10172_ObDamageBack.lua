local bs_10172 = class("bs_10172", LuaSkillBase)
local base = LuaSkillBase
bs_10172.config = {damageFormula = 10011}
bs_10172.ctor = function(self)
  -- function num : 0_0
end

bs_10172.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10172_3", 1, self.OnRoleDie)
end

bs_10172.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.intensity == 0 and killer.belongNum == 2 and self:IsReadyToTake() then
    local damage = (math.max)(1, LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, killer, self))
    LuaSkillCtrl:RemoveLife(damage, self, killer, true)
    self:OnSkillTake()
  end
end

bs_10172.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10172

