-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40038 = class("bs_40038", LuaSkillBase)
local base = LuaSkillBase
bs_40038.config = {}
bs_40038.ctor = function(self)
  -- function num : 0_0
end

bs_40038.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_40038.PlaySkill = function(self, data)
  -- function num : 0_2
end

bs_40038.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40038

