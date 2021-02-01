-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10075 = class("bs_10075", LuaSkillBase)
local base = LuaSkillBase
bs_10075.config = {buffId = 1011}
bs_10075.ctor = function(self)
  -- function num : 0_0
end

bs_10075.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], nil, true)
end

bs_10075.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10075

