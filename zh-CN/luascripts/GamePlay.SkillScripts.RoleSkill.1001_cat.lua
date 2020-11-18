-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1001 = class("bs_1001", LuaSkillBase)
local base = LuaSkillBase
bs_1001.config = {buffId1 = 50, buffId2 = 100}
bs_1001.ctor = function(self)
  -- function num : 0_0
end

bs_1001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1001.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1, (self.arglist)[5])
  if (self.arglist)[4] == 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, (self.arglist)[5])
  end
end

bs_1001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1001

