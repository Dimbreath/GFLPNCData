-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5019 = class("bs_5019", LuaSkillBase)
local base = LuaSkillBase
bs_5019.config = {buffId = 158}
bs_5019.ctor = function(self)
  -- function num : 0_0
end

bs_5019.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_5019_1", 10, self.OnAfterBattleStart)
end

bs_5019.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 20)
  if targetList.Count >= 1 then
    for i = 0, targetList.Count - 1 do
      local targetRole = (targetList[i]).targetRole
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, 1)
    end
  end
end

bs_5019.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5019

