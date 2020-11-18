-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1006 = class("bs_1006", LuaSkillBase)
local base = LuaSkillBase
bs_1006.config = {
heal_config = {baseheal_formula = 1052, heal_number = 0, correct_formula = 9990}
, 
aoe_config = {effect_shape = 2, aoe_select_code = 2, aoe_range = 1}
, effectId = 104, buffId = 104}
bs_1006.ctor = function(self)
  -- function num : 0_0
end

bs_1006.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1006.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc)
end

bs_1006.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
    if (self.arglist)[5] == 1 then
      skillResult:BuffResult((self.config).buffId, 1, 15)
    end
    skillResult:EndResult()
  end
end

bs_1006.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1006

