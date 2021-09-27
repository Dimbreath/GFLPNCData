local bs_10255 = class("bs_10255", LuaSkillBase)
local base = LuaSkillBase
bs_10255.config = {}
bs_10255.ctor = function(self)
  -- function num : 0_0
end

bs_10255.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_10255.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10255

