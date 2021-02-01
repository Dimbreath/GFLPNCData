-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103402 = class("bs_103402", LuaSkillBase)
local base = LuaSkillBase
bs_103402.config = {effectId = 10455, buffId = 180, 
aoe_config = {effect_shape = 1, aoe_select_code = 3, aoe_range = 10}
, speed = 1}
bs_103402.ctor = function(self)
  -- function num : 0_0
end

bs_103402.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103402.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(15)
  LuaSkillCtrl:CallRoleAction(self.caster, 1002, (self.config).speed)
  LuaSkillCtrl:CallEffectWithArgAndSpeed(self.caster, (self.config).effectId, self, (self.config).speed, true, self.SkillEventFunc)
end

bs_103402.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
    skillResult:BuffResult((self.config).buffId, 1, (self.arglist)[5])
    skillResult:EndResult()
  end
end

bs_103402.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103402

