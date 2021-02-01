-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10183 = class("bs_10183", LuaSkillBase)
local base = LuaSkillBase
bs_10183.config = {sheildBuffId = 174, damageFormula = 10011}
bs_10183.ctor = function(self)
  -- function num : 0_0
end

bs_10183.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10183_1", 1, self.OnAfterBattleStart)
end

bs_10183.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], self.CallBack, self, -1, 0)
end

bs_10183.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local targetRole = (targetlist[i]).targetRole
      local restTier = targetRole:GetBuffTier((self.config).sheildBuffId)
      if restTier > 0 then
        local damage = (math.max)(1, LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, targetRole, self))
        LuaSkillCtrl:RemoveLife(damage, self, targetRole, true, true)
      end
    end
  end
end

bs_10183.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10183

