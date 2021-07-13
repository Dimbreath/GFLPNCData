-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202102 = class("bs_202102", LuaSkillBase)
local base = LuaSkillBase
bs_202102.config = {}
bs_202102.ctor = function(self)
  -- function num : 0_0
end

bs_202102.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202102.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202102

