-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10216 = class("bs_10216", LuaSkillBase)
local base = LuaSkillBase
bs_10216.config = {effectId = 10127}
bs_10216.ctor = function(self)
  -- function num : 0_0
end

bs_10216.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10216_1", 1, self.OnAfterBattleStart)
end

bs_10216.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local targetRole = (targetlist[i]).targetRole
      if targetRole.belongNum == 2 then
        LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self)
        local hurt = (math.max)(1, targetRole.maxHp * (self.arglist)[1] // 1000)
        LuaSkillCtrl:RemoveLife(hurt, self, targetRole, true, true)
      end
    end
  end
end

bs_10216.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10216

