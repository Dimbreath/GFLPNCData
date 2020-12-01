-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10013 = class("bs_10013", LuaSkillBase)
local base = LuaSkillBase
bs_10013.config = {effectId = 1009, 
aoe_config = {effect_shape = 1, aoe_select_code = 4, aoe_range = 10}
, buffId = 67, defBuffId = 92, buffTier = 1}
bs_10013.ctor = function(self)
  -- function num : 0_0
end

bs_10013.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_10013.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).defBuffId, (self.arglist)[2], (self.arglist)[1])
end

bs_10013.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    skillResult:BuffResult((self.config).buffId, (self.config).buffTier, (self.arglist)[1])
    skillResult:EndResult()
  end
end

bs_10013.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10013

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10013 = class("bs_10013", LuaSkillBase)
local base = LuaSkillBase
bs_10013.config = {
    effectId = 1009,
    aoe_config = {effect_shape = 1, aoe_select_code = 4, aoe_range = 10},
    buffId = 67,
    defBuffId = 92,
    buffTier = 1
}
bs_10013.ctor = function(self)
    -- function num : 0_0
end

bs_10013.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_10013.PlaySkill = function(self)
    -- function num : 0_2 , upvalues : _ENV
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self,
                            self.SkillEventFunc)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).defBuffId,
                          (self.arglist)[2], (self.arglist)[1])
end

bs_10013.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target,
                                                         (self.config).aoe_config)
        skillResult:BuffResult((self.config).buffId, (self.config).buffTier,
                               (self.arglist)[1])
        skillResult:EndResult()
    end
end

bs_10013.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10013

