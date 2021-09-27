local bs_10265 = class("bs_10265", LuaSkillBase)
local base = LuaSkillBase
bs_10265.config = {}
bs_10265.ctor = function(self)
  -- function num : 0_0
end

bs_10265.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10265_10", 1, self.OnRoleDie)
end

bs_10265.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.belongNum ~= (self.caster).belongNum and role.belongNum ~= 0 then
    local healNum = role.maxHp * (self.arglist)[1] // 1000
    LuaSkillCtrl:CallHeal(healNum, self, self.caster, true)
    self:PlayChipEffect()
  end
end

bs_10265.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10265

