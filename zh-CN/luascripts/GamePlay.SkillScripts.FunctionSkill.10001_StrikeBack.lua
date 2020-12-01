-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10001 = class("bs_10001", LuaSkillBase)
local base = LuaSkillBase
bs_10001.config = {buffId = 69, attBuffId = 70}
bs_10001.ctor = function(self)
  -- function num : 0_0
end

bs_10001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_10001.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10001_3", 1, self.OnAfterHurt)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).attBuffId, (self.arglist)[1])
end

bs_10001.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and (self.caster):GetBuffTier((self.config).buffId) > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).attBuffId, (self.arglist)[1])
  end
end

bs_10001.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10001

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10001 = class("bs_10001", LuaSkillBase)
local base = LuaSkillBase
bs_10001.config = {buffId = 69, attBuffId = 70}
bs_10001.ctor = function(self)
    -- function num : 0_0
end

bs_10001.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_10001.PlaySkill = function(self)
    -- function num : 0_2 , upvalues : _ENV
    self:PlayChipEffect()
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10001_3", 1,
                    self.OnAfterHurt)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).attBuffId,
                          (self.arglist)[1])
end

bs_10001.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_3 , upvalues : _ENV
    if target == self.caster and (self.caster):GetBuffTier((self.config).buffId) >
        0 then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).attBuffId,
                              (self.arglist)[1])
    end
end

bs_10001.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10001

