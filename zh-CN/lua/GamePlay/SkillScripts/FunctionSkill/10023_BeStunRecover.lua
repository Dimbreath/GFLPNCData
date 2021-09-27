local bs_10023 = class("bs_10023", LuaSkillBase)
local base = LuaSkillBase
bs_10023.config = {effectId = 1008, baseheal_formula = 10006, correct_formula = 9990, heal_number = 0}
bs_10023.ctor = function(self)
  -- function num : 0_0
end

bs_10023.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterAddBuffTrigger("bs_10023_7", 1, self.OnAfterAddBuff, nil, self.caster)
  self.heal_config = {}
end

bs_10023.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and buff:ContainFeature(eBuffFeatureType.Stun) then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillBack)
  end
end

bs_10023.SkillBack = function(self, effect, eventId, target)
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
    LuaSkillCtrl:HealResult(skillResult, self.heal_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10023.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10023

