local bs_10259 = class("bs_10259", LuaSkillBase)
local base = LuaSkillBase
bs_10259.config = {}
bs_10259.ctor = function(self)
  -- function num : 0_0
end

bs_10259.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_10259.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10259

