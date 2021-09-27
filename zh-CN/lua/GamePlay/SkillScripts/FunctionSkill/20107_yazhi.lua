local bs_20107 = class("bs_20107", LuaSkillBase)
local base = LuaSkillBase
bs_20107.config = {buffId = 1210}
bs_20107.ctor = function(self)
  -- function num : 0_0
end

bs_20107.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20107_1", 1, self.OnAfterBattleStart)
end

bs_20107.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count <= 0 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    if targetRole.belongNum ~= 0 then
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, 1, 15, true)
    end
  end
end

bs_20107.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20107

