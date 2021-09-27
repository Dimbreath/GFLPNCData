local bs_20007 = class("bs_20007", LuaSkillBase)
local base = LuaSkillBase
bs_20007.config = {formula = 1047}
bs_20007.ctor = function(self)
  -- function num : 0_0
end

bs_20007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20007_1", 1, self.OnAfterBattleStart)
end

bs_20007.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 30, 0)
  if targetList ~= nil and targetList.Count > 0 then
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).formula, (targetList[0]).targetRole, nil, self)
    if healNum > 0 then
      LuaSkillCtrl:CallHeal(healNum, self, (targetList[0]).targetRole, true)
    end
  end
end

bs_20007.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20007

