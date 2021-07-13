-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_6007 = class("bs_6007", LuaSkillBase)
local base = LuaSkillBase
bs_6007.config = {buffId = 103}
bs_6007.ctor = function(self)
  -- function num : 0_0
end

bs_6007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_6007_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_6007_22", 1, self.OnBreakShield)
end

bs_6007.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local Value = (self.arglist)[1] * (self.caster).def // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, Value)
  LuaSkillCtrl:CallFloatText(self.caster, 11, Value)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
end

bs_6007.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and shieldType == 0 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
  end
end

bs_6007.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6007

