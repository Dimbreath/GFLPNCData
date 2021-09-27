local bs_30045 = class("bs_30045", LuaSkillBase)
local base = LuaSkillBase
bs_30045.config = {buffId = 205, buffTier = 1}
bs_30045.ctor = function(self)
  -- function num : 0_0
end

bs_30045.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_30045_10", 1, self.OnRoleDie)
end

bs_30045.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum ~= (self.caster).belongNum and role.roleType == 1 then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if targetlist.Count < 1 then
      return 
    end
    for i = 0, targetlist.Count - 1 do
      LuaSkillCtrl:CallBuff(self, (targetlist[i]).targetRole, (self.config).buffId, (self.config).buffTier, (self.arglist)[1])
    end
  end
end

bs_30045.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30045

