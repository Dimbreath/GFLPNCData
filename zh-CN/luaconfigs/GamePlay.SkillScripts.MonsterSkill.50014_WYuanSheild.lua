-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50014 = class("bs_50014", LuaSkillBase)
local base = LuaSkillBase
bs_50014.config = {buffId = 1143, reBuffId = 1049, sheildBuffId = 174, effectId = 10371, shieldformula = 524}
bs_50014.ctor = function(self)
  -- function num : 0_0
end

bs_50014.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  local Value = (self.caster).hp * 150 // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.LongRange, Value, (self.config).shieldformula)
  LuaSkillCtrl:CallFloatText(self.caster, 11, Value)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_50014_22", 1, self.OnBreakShield)
end

bs_50014.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and shieldType == 1 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
  end
end

bs_50014.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50014

