-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40003 = class("bs_40003", LuaSkillBase)
local base = LuaSkillBase
bs_40003.config = {effectId = 10274, damageFormula = 10016}
bs_40003.ctor = function(self)
  -- function num : 0_0
end

bs_40003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40003_1", 1, self.OnAfterBattleStart)
end

bs_40003.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.damTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], self.CallBack, self, -1, 0)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
end

bs_40003.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count <= 0 then
    return 
  end
  local damage = (math.max)(1, LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, targetRole, self))
  for i = 0, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    LuaSkillCtrl:RemoveLife(damage, self, targetRole)
  end
end

bs_40003.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
end

return bs_40003

