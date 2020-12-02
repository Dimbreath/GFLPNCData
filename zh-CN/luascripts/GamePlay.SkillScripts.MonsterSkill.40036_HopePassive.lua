-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40036 = class("bs_40036", LuaSkillBase)
local base = LuaSkillBase
bs_40036.config = {}
bs_40036.ctor = function(self)
  -- function num : 0_0
end

bs_40036.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_40036_3", 1, self.OnAfterHurt)
end

bs_40036.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2
end

bs_40036.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40036

