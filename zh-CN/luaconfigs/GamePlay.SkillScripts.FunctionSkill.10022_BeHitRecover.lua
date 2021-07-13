-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10022 = class("bs_10022", LuaSkillBase)
local base = LuaSkillBase
bs_10022.config = {effectId = 1008, 
heal_config = {baseheal_formula = 10087, correct_formula = 9990, heal_number = 0}
}
bs_10022.ctor = function(self)
  -- function num : 0_0
end

bs_10022.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_10022_3", 1, self.OnAfterHurt, nil, self.caster)
  self.heal_config = {}
end

bs_10022.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[2] and self:IsReadyToTake() then
    self:PlayChipEffect()
    self:OnSkillTake()
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillBack)
    self:PlayChipEffect()
  end
end

bs_10022.SkillBack = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10022.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10022

