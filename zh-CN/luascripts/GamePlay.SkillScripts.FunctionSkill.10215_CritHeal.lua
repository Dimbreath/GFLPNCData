-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10215 = class("bs_10215", LuaSkillBase)
local base = LuaSkillBase
bs_10215.config = {
heal_config = {baseheal_formula = 10011, heal_number = 0, correct_formula = 9990}
, effectId = 1048}
bs_10215.ctor = function(self)
  -- function num : 0_0
end

bs_10215.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10215_3", 1, self.OnAfterHurt)
end

bs_10215.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender.belongNum == (self.caster).belongNum and isCrit then
    LuaSkillCtrl:CallEffect(sender, (self.config).effectId, self, self.SkillEventFunc)
  end
end

bs_10215.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).heal_config)
    skillResult:HealResult((self.config).heal_config)
    skillResult:EndResult()
  end
end

bs_10215.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10215

