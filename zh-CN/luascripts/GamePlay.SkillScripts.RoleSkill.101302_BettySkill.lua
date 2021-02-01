-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101302 = class("bs_101302", LuaSkillBase)
local base = LuaSkillBase
bs_101302.config = {buffId = 202}
bs_101302.ctor = function(self)
  -- function num : 0_0
end

bs_101302.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101302.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, (self.arglist)[1], true)
end

bs_101302.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101302

