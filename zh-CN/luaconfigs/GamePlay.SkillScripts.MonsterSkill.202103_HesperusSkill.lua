-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202103 = class("bs_202103", LuaSkillBase)
local base = LuaSkillBase
bs_202103.config = {}
bs_202103.ctor = function(self)
  -- function num : 0_0
end

bs_202103.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202103.PlaySkill = function(self, data)
  -- function num : 0_2
end

bs_202103.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202103

