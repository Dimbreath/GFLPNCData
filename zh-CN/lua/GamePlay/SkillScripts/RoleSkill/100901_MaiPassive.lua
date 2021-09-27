local bs_100901 = class("bs_100901", LuaSkillBase)
local base = LuaSkillBase
bs_100901.config = {buffId_speed = 100901}
bs_100901.ctor = function(self)
  -- function num : 0_0
end

bs_100901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_100901_1", 1, self.OnAfterBattleStart)
end

bs_100901.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:FindRolesAroundRole(self.caster)
  if targetList ~= nil and targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role.y == (self.caster).y and role.belongNum == (self.caster).belongNum then
        LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_speed, 1)
      end
    end
  end
end

bs_100901.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100901

