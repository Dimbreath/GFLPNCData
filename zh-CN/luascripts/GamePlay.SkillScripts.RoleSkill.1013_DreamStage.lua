-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1013 = class("bs_1013", LuaSkillBase)
local base = LuaSkillBase
bs_1013.config = {effectId = 1024, 
aoe_config = {effect_shape = 1, aoe_select_code = 3, aoe_range = 10}
, buffId = 89}
bs_1013.ctor = function(self)
  -- function num : 0_0
end

bs_1013.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1013.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc)
end

bs_1013.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    skillResult:BuffResult((self.config).buffId, (self.arglist)[1], (self.arglist)[2])
    skillResult:EndResult()
  end
end

bs_1013.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1013

