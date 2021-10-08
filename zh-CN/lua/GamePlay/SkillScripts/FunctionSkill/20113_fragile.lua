local bs_20113 = class("bs_20113", LuaSkillBase)
local base = LuaSkillBase
bs_20113.config = {effectId = 10867, buffId = 1217}
bs_20113.ctor = function(self)
  -- function num : 0_0
end

bs_20113.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_20113_11", 1, self.OnRoleDie)
end

bs_20113.OnRoleDie = function(self, killer, role, killSkill)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum == 2 and killer.belongNum == 1 then
    LuaSkillCtrl:CallBuff(self, killer, (self.config).buffId, 1, nil)
    self.effect0 = LuaSkillCtrl:CallEffect(killer, (self.config).effectId, self)
    LuaSkillCtrl:StartTimer(nil, 23, function()
    -- function num : 0_2_0 , upvalues : self
    if self.effect0 ~= nil then
      (self.effect0):Die()
      self.effect0 = nil
    end
  end
)
  end
end

bs_20113.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20113

