-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102301 = class("bs_102301", LuaSkillBase)
local base = LuaSkillBase
bs_102301.config = {}
bs_102301.ctor = function(self)
  -- function num : 0_0
end

bs_102301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102301_1", 1, self.OnAfterBattleStart)
  if (self.arglist)[4] > 0 then
    self:AddSetHealTrigger("bs_102301_4", 1, self.OnSetHeal, nil, self.caster)
  end
end

bs_102301.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local shieldValue = (self.caster).skill_intensity * (self.arglist)[1] // 1000
  if shieldValue > 0 then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
    LuaSkillCtrl:CallFloatText(self.caster, 11, shieldValue)
  end
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    local shieldValue_ex = (self.caster).skill_intensity * (self.arglist)[3] // 1000
    if shieldValue_ex > 0 then
      LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue_ex)
      LuaSkillCtrl:CallFloatText(self.caster, 11, shieldValue_ex)
    end
  end
, self, -1)
end

bs_102301.OnSetHeal = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.target == self.caster and context.isTriggerSet ~= true then
    local shieldValue_heal = context.heal * (self.arglist)[5] // 1000
    if shieldValue_heal > 0 then
      LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue_heal)
      LuaSkillCtrl:CallFloatText(self.caster, 11, shieldValue_heal)
    end
  end
end

bs_102301.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102301

