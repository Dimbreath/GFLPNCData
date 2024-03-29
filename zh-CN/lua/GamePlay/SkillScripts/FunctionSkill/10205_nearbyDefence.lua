local bs_10205 = class("bs_10205", LuaSkillBase)
local base = LuaSkillBase
bs_10205.config = {defFormula = 10071, effectId = 10243, buffId = 1012}
bs_10205.ctor = function(self)
  -- function num : 0_0
end

bs_10205.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10205_1", 1, self.OnAfterBattleStart)
end

bs_10205.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 41, 0)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local targetRole = (targetList[i]).targetRole
      local defTier = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).defFormula, self.caster, targetRole, self)
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, defTier, nil, true)
      LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self)
    end
  end
end

bs_10205.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10205

