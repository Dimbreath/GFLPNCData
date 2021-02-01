-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10078 = class("bs_10078", LuaSkillBase)
local base = LuaSkillBase
bs_10078.config = {buffId = 80, buffTier = 1}
bs_10078.ctor = function(self)
  -- function num : 0_0
end

bs_10078.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10078_10", 1, self.OnRoleDie)
end

bs_10078.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).belongNum == role.belongNum then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1] // 10, nil, true)
  end
end

bs_10078.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10078

