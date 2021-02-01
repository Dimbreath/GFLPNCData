-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20001 = class("bs_20001", LuaSkillBase)
local base = LuaSkillBase
bs_20001.config = {buffId = 175}
bs_20001.ctor = function(self)
  -- function num : 0_0
end

bs_20001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20001_1", 1, self.OnAfterBattleStart)
end

bs_20001.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if targetlist.Count <= 0 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 1003 then
      local restTier = targetRole:GetBuffTier((self.config).buffId)
      if restTier > 0 then
        LuaSkillCtrl:DispelBuff(targetRole, (self.config).buffId, 0)
      end
    end
  end
end

bs_20001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20001

