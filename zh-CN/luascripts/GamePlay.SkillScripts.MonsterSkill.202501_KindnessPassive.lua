-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202501 = class("bs_202501", LuaSkillBase)
local base = LuaSkillBase
bs_202501.config = {}
bs_202501.ctor = function(self)
  -- function num : 0_0
end

bs_202501.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_202501_3", 1, self.OnAfterHurt)
end

bs_202501.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2
end

bs_202501.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202501

