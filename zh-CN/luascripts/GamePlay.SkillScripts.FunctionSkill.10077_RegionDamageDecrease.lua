-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10077 = class("bs_10077", LuaSkillBase)
local base = LuaSkillBase
bs_10077.config = {}
bs_10077.ctor = function(self)
  -- function num : 0_0
end

bs_10077.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_10077.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10077

