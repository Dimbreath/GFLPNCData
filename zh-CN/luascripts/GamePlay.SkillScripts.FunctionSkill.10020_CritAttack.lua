-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10020 = class("bs_10020", LuaSkillBase)
local base = LuaSkillBase
bs_10020.config = {buffId = 64, buffTier = 1}
bs_10020.ctor = function(self)
  -- function num : 0_0
end

bs_10020.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_10020.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, (self.arglist)[1])
end

bs_10020.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10020

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10020 = class("bs_10020", LuaSkillBase)
local base = LuaSkillBase
bs_10020.config = {buffId = 64, buffTier = 1}
bs_10020.ctor = function(self)
    -- function num : 0_0
end

bs_10020.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_10020.PlaySkill = function(self)
    -- function num : 0_2 , upvalues : _ENV
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                          (self.config).buffTier, (self.arglist)[1])
end

bs_10020.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10020

