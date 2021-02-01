-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50010 = class("bs_50010", LuaSkillBase)
local base = LuaSkillBase
bs_50010.config = {}
bs_50010.ctor = function(self)
  -- function num : 0_0
end

bs_50010.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_50010.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50010

