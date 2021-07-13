-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200301 = class("bs_200301", LuaSkillBase)
local base = LuaSkillBase
bs_200301.config = {buffId_1008 = 1008, buffId_212 = 212}
bs_200301.ctor = function(self)
  -- function num : 0_0
end

bs_200301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_200301_1", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_200301_2", 2, self.OnAfterBattleStart)
  self.time = (self.arglist)[4]
end

bs_200301.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).belongNum == role.belongNum and self.time > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1008, (self.arglist)[2])
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_212, 1)
    self.time = self.time - 1
  end
end

bs_200301.OnAfterBattleStart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1008, (self.arglist)[1])
end

bs_200301.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_200301

