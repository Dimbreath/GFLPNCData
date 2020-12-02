-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10006 = class("bs_10006", LuaSkillBase)
local base = LuaSkillBase
bs_10006.config = {featureType = eBuffFeatureType.Stun, baseheal_formula = 10006, correct_formula = 9990, heal_number = 0, effectId = 1004}
bs_10006.ctor = function(self)
  -- function num : 0_0
end

bs_10006.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10006_1", 1, self.OnAfterHurt)
  self.heal_config = {}
end

bs_10006.OnAfterHurt = function(self, sender, target, skill, realValue, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and target:ContainFeature((self.config).featureType) then
    self:PlayChipEffect()
    if (self.caster).hp <= 0 then
      return 
    end
    LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillBack)
  end
end

bs_10006.SkillBack = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  if eventId == eBattleEffectEvent.Trigger then
    (self.heal_config).baseheal_formula = (self.config).baseheal_formula
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.heal_config).correct_formula = (self.config).correct_formula
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.heal_config).heal_number = (self.config).heal_number
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, self.caster)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
    skillResult:EndResult()
  end
end

bs_10006.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10006

