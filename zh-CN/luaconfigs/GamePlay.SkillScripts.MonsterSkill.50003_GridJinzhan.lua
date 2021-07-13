-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50003 = class("bs_50003", LuaSkillBase)
local base = LuaSkillBase
bs_50003.config = {buffId = 1048, reBuffId = 1049, sheildBuffId = 174, effectId = 10373, shieldKey = "50003_HuDun", shieldformula = 523}
bs_50003.ctor = function(self)
  -- function num : 0_0
end

bs_50003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  local Value = (self.caster).hp * 500 // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.NoRange, Value, (self.config).shieldformula)
  LuaSkillCtrl:CallFloatText(self.caster, 11, Value)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_50003_22", 1, self.OnBreakShield)
end

bs_50003.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and shieldType == 2 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
  end
end

bs_50003.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50003

