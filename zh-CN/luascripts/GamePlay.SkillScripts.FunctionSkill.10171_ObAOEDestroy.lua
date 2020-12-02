-- params : ...
-- function num : 0 , upvalues : _ENV
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
  self.DestroyCount = (self.arglist)[1]
  self.recordTargets = {}
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  for i = targetlist.Count - 1, 0, -1 do
    local tier = (targetlist[i]):GetBuffTier((self.config).buffId)
    if tier == 0 then
      (table.insert)(self.recordTargets, targetlist[i])
    end
  end
  if #self.recordTargets <= 0 then
    return 
  end
  self.ObCount = #self.recordTargets
  local damage = 100000
  for i = #self.recordTargets, 1, -1 do
    local targetRole = (self.recordTargets)[i]
    -- DECOMPILER ERROR at PC57: Unhandled construct in 'MakeBoolean' P1

    if targetRole.intensity == 0 and self.DestroyCount > 0 and self.ObCount > (self.arglist)[2] then
      do
        self.ObCount = self.ObCount - 1
        self.DestroyCount = self.DestroyCount - 1
        LuaSkillCtrl:RemoveLife(damage, self, targetRole)
        -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

bs_10171.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10171

