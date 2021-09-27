local bs_20017 = class("bs_20017", LuaSkillBase)
local base = LuaSkillBase
bs_20017.config = {}
bs_20017.ctor = function(self)
  -- function num : 0_0
end

bs_20017.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_20017.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20017

