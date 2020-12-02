-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10074 = class("bs_10074", LuaSkillBase)
local base = LuaSkillBase
bs_10074.config = {buffId = 1005}
bs_10074.ctor = function(self)
  -- function num : 0_0
end

bs_10074.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10074_1", 1, self.OnRoleDie)
end

bs_10074.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
end

bs_10074.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10074

