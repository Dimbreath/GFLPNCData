-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5014 = class("bs_5014", LuaSkillBase)
local base = LuaSkillBase
bs_5014.config = {buffId = 154}
bs_5014.ctor = function(self)
  -- function num : 0_0
end

bs_5014.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_5014_1", 10, self.OnAfterBattleStart)
end

bs_5014.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 20)
  if targetList.Count >= 1 then
    for i = 0, targetList.Count - 1 do
      local targetRole = (targetList[i]).targetRole
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, 1)
    end
  end
end

bs_5014.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5014

