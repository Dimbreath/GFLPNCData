-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101302 = class("bs_101302", LuaSkillBase)
local base = LuaSkillBase
bs_101302.config = {}
bs_101302.ctor = function(self)
  -- function num : 0_0
end

bs_101302.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_101302_2", 1, self.OnSetHurt)
end

bs_101302.PlaySkill = function(self, data)
  -- function num : 0_2
end

bs_101302.OnSetHurt = function(self, context)
  -- function num : 0_3
end

bs_101302.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101302

