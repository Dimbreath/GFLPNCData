-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10200 = class("bs_10200", LuaSkillBase)
local base = LuaSkillBase
bs_10200.config = {buffId = 1053, buffTier = 1}
bs_10200.ctor = function(self)
  -- function num : 0_0
end

bs_10200.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10200_1", 1, self.OnAfterBattleStart)
end

bs_10200.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if targetlist.Count <= 0 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 1002 then
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.config).buffTier)
    end
  end
end

bs_10200.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10200

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10200 = class("bs_10200", LuaSkillBase)
local base = LuaSkillBase
bs_10200.config = {buffId = 1053, buffTier = 1}
bs_10200.ctor = function(self)
    -- function num : 0_0
end

bs_10200.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10200_1", 1,
                    self.OnAfterBattleStart)
end

bs_10200.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local targetlist =
        LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
    if targetlist.Count <= 0 then return end
    for i = 0, targetlist.Count - 1 do
        local targetRole = targetlist[i]
        if targetRole.roleDataId == 1002 then
            LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId,
                                  (self.config).buffTier)
        end
    end
end

bs_10200.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10200

