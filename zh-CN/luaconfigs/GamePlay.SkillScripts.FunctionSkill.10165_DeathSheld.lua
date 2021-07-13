-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10065 = class("bs_10065", LuaSkillBase)
local base = LuaSkillBase
bs_10065.config = {buffId = 103, buffTier = 1, damageFormula = 10006, shieldKey = "10165_HuDun"}
bs_10065.ctor = function(self)
  -- function num : 0_0
end

bs_10065.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSetHurtTrigger("bs_10065_2", 1, self.OnSetHurt, nil, self.caster, nil, nil, nil, 1)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10065_10", 1, self.OnRoleDie)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).sheildValue_10044 = 0
end

bs_10065.OnSetHurt = function(self, context)
  -- function num : 0_2
end

bs_10065.OnRoleDie = function(self, killer, role)
  -- function num : 0_3 , upvalues : _ENV
  if (self.caster).belongNum == role.belongNum and role.roleType == 1 and role.attackRange == 1 then
    self:PlayChipEffect()
    local sheildValue = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, role, role, self)
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, sheildValue)
    LuaSkillCtrl:CallFloatText(self.caster, 11, sheildValue)
  end
end

bs_10065.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10065

