local bs_30029 = class("bs_30029", LuaSkillBase)
local base = LuaSkillBase
bs_30029.config = {
heal_config = {baseheal_formula = 501, heal_number = 0, correct_formula = 9990}
}
bs_30029.ctor = function(self)
  -- function num : 0_0
end

bs_30029.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30029_1", 1, self.OnAfterBattleStart)
  self.maxShieldVal = 0
end

bs_30029.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], self.CallBack, self, -1)
end

bs_30029.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count < 1 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    local shieldVal = LuaSkillCtrl:GetShield(targetRole, eShieldType.Normal)
    if self.maxShieldVal < shieldVal then
      self.maxShieldVal = shieldVal
    end
  end
  targetlist = LuaSkillCtrl:CallTargetSelect(self, 52, 10)
  if targetlist.Count < 1 then
    return 
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[0]).targetRole)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {self.maxShieldVal}, true, true)
  skillResult:EndResult()
  self.maxShieldVal = 0
end

bs_30029.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30029

