-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5020 = class("bs_5020", LuaSkillBase)
local base = LuaSkillBase
bs_5020.config = {
buffALL = {141, 152, 66}
, buffId = 237}
bs_5020.ctor = function(self)
  -- function num : 0_0
end

bs_5020.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_5020_1", 10, self.OnAfterBattleStart)
end

bs_5020.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 20)
  if targetList.Count >= 1 then
    for i = 0, targetList.Count - 1 do
      local targetRole = (targetList[i]).targetRole
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, 1)
    end
  end
end

bs_5020.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5020

