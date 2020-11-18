-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40007 = class("bs_40007", LuaSkillBase)
local base = LuaSkillBase
bs_40007.config = {}
bs_40007.ctor = function(self)
  -- function num : 0_0
end

bs_40007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_40007.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_2
end

bs_40007.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_3
end

bs_40007.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40007

