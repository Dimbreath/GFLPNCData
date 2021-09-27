local bs_10215 = class("bs_10215", LuaSkillBase)
local base = LuaSkillBase
bs_10215.config = {
heal_config = {baseheal_formula = 10011, heal_number = 0, correct_formula = 9990}
, effectId = 1048, buffId = 1125}
bs_10215.ctor = function(self)
  -- function num : 0_0
end

bs_10215.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10215_3", 1, self.OnAfterHurt, nil, nil, (self.caster).belongNum)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10215_1", 1, self.OnAfterBattleStart)
end

bs_10215.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
end

bs_10215.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender.belongNum == (self.caster).belongNum and isCrit and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc)
  end
end

bs_10215.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).heal_config)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10215.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10215

