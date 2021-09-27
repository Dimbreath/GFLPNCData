local bs_20060 = class("bs_20060", LuaSkillBase)
local base = LuaSkillBase
bs_20060.config = {buffId1 = 1165, buffId2 = 26}
bs_20060.ctor = function(self)
  -- function num : 0_0
end

bs_20060.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20060_1", 1, self.OnAfterBattleStart)
end

bs_20060.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count <= 0 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId1, 1, nil, true)
    LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId2, 1, 150, true)
  end
end

bs_20060.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20060

