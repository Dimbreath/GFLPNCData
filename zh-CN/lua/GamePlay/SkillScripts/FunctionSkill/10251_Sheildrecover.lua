local bs_10251 = class("bs_10251", LuaSkillBase)
local base = LuaSkillBase
bs_10251.config = {
heal_config = {baseheal_formula = 10139}
}
bs_10251.ctor = function(self)
  -- function num : 0_0
end

bs_10251.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100501_1", 1, self.OnAfterBattleStart)
end

bs_10251.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.timer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], self.Callback, self, -1)
end

bs_10251.Callback = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:PlayChipEffect()
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  local Value = (math.max)(1, (self.arglist)[2] * (self.caster).skill_intensity // 1000)
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, Value)
end

bs_10251.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

return bs_10251

