-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202101 = class("bs_202101", LuaSkillBase)
local base = LuaSkillBase
bs_202101.config = {}
bs_202101.ctor = function(self)
  -- function num : 0_0
end

bs_202101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_202101_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_202101_12", 1, self.OnAfterPlaySkill)
end

bs_202101.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2
end

bs_202101.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3
end

bs_202101.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202101

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202101 = class("bs_202101", LuaSkillBase)
local base = LuaSkillBase
bs_202101.config = {}
bs_202101.ctor = function(self)
    -- function num : 0_0
end

bs_202101.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_202101_3", 1,
                    self.OnAfterHurt)
    self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_202101_12", 1,
                    self.OnAfterPlaySkill)
end

bs_202101.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                 isCrit, isRealDmg)
    -- function num : 0_2
end

bs_202101.OnAfterPlaySkill = function(self, skill, role)
    -- function num : 0_3
end

bs_202101.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_202101

