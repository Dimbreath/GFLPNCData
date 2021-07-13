-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10256 = class("bs_10256", LuaSkillBase)
local base = LuaSkillBase
bs_10256.config = {}
bs_10256.ctor = function(self)
  -- function num : 0_0
end

bs_10256.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_10256.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10256

