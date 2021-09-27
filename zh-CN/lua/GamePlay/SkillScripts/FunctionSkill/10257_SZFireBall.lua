local bs_10257 = class("bs_10257", LuaSkillBase)
local base = LuaSkillBase
bs_10257.config = {}
bs_10257.ctor = function(self)
  -- function num : 0_0
end

bs_10257.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_10257.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10257

