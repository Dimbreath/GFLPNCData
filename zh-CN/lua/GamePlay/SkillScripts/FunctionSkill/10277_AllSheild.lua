local bs_10277 = class("bs_10277", LuaSkillBase)
local base = LuaSkillBase
bs_10277.config = {shieldFormula = 10087}
bs_10277.ctor = function(self)
  -- function num : 0_0
end

bs_10277.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10277_2", 10, self.OnAfterBattleStart)
end

bs_10277.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count < 1 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local shieldValue = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).shieldFormula, self.caster, nil, self)
    local targetRole = (targetlist[i]).targetRole
    LuaSkillCtrl:AddRoleShield(targetRole, eShieldType.Normal, shieldValue)
  end
end

bs_10277.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10277

