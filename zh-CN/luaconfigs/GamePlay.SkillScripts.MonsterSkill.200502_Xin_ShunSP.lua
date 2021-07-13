-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200502 = class("bs_200502", LuaSkillBase)
local base = LuaSkillBase
bs_200502.config = {effectId = 10274, damageFormula = 10113, effectId1 = 10853, effectId2 = 10854, select_id = 9, select_range = 10}
bs_200502.ctor = function(self)
  -- function num : 0_0
end

bs_200502.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200502_1", 1, self.OnAfterBattleStart)
end

bs_200502.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.damTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], self.CallBack, self, -1, 0)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
end

bs_200502.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.damTimer ~= nil and (self.damTimer):IsOver() then
    self.damTimer = nil
  end
  if (self.caster).roleDataId == 30000 then
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, true)
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
  if targetlist.Count <= 0 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    local damage = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, self.caster, self)
    if damage < 1 then
      damage = 1
    end
    LuaSkillCtrl:RemoveLife(damage, self, targetRole)
    LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId2, self, nil, nil, nil, true)
  end
end

bs_200502.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
end

return bs_200502

