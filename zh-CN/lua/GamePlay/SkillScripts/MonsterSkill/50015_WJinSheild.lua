local bs_50015 = class("bs_50015", LuaSkillBase)
local base = LuaSkillBase
bs_50015.config = {buffId = 1144, reBuffId = 1049, sheildBuffId = 174, effectId = 10373, shieldformula = 523}
bs_50015.ctor = function(self)
  -- function num : 0_0
end

bs_50015.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  local Value = (self.caster).hp * 150 // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.NoRange, Value, (self.config).shieldformula)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_50015_22", 1, self.OnBreakShield)
end

bs_50015.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and shieldType == 2 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
  end
end

bs_50015.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50015

