local bs_10171 = class("bs_10171", LuaSkillBase)
local base = LuaSkillBase
bs_10171.config = {buffId = 88}
bs_10171.ctor = function(self)
  -- function num : 0_0
end

bs_10171.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10171_1", 1, self.OnAfterBattleStart)
end

bs_10171.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.damTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], BindCallback(self, self.RealPlaySkill), self, -1, 0)
end

bs_10171.RealPlaySkill = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.damTimer ~= nil and (self.damTimer):IsOver() then
    self.damTimer = nil
  end
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  for i = 0, targetlist.Count - 1 do
    local tier = (targetlist[i]):GetBuffTier((self.config).buffId)
    if tier == 0 then
      local targetRole = targetlist[i]
      if targetRole.intensity == 0 then
        LuaSkillCtrl:RemoveLife(100000, self, targetRole, true, nil, true, false, eHurtType.RealDmg)
        return 
      end
    end
  end
end

bs_10171.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10171

