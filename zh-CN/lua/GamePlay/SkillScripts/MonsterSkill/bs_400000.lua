local bs_400000 = class("bs_400000", LuaSkillBase)
local base = LuaSkillBase
bs_400000.config = {}
bs_400000.ctor = function(self)
  -- function num : 0_0
end

bs_400000.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_400000_13", 1, self.OnAfterPlaySkill)
end

bs_400000.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
end

bs_400000.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_400000

