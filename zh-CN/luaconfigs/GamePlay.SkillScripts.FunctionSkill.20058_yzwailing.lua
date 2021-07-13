-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20058 = class("bs_20058", LuaSkillBase)
local base = LuaSkillBase
bs_20058.config = {}
bs_20058.ctor = function(self)
  -- function num : 0_0
end

bs_20058.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20058_1", 1, self.OnAfterBattleStart)
end

bs_20058.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local targetRole = (targetlist[i]).targetRole
      if targetRole.belongNum ~= 0 then
        local hurt = (math.max)(1, targetRole.maxHp * 3 // 10)
        LuaSkillCtrl:RemoveLife(hurt, self, targetRole, true, true)
      end
    end
  end
end

bs_20058.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20058

