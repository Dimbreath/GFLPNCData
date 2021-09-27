local bs_202101 = class("bs_202101", LuaSkillBase)
local base = LuaSkillBase
bs_202101.config = {}
bs_202101.ctor = function(self)
  -- function num : 0_0
end

bs_202101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202101.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202101

