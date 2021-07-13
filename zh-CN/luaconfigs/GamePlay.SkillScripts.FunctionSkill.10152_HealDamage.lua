-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10152 = class("bs_10152", LuaSkillBase)
local base = LuaSkillBase
bs_10152.config = {
realDamageConfig = {basehurt_formula = 10046, lifesteal_formula = 0, spell_lifesteal_formula = 0}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, effectId = 10257, effectId2 = 10256}
bs_10152.ctor = function(self)
  -- function num : 0_0
end

bs_10152.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_10152_5", 1, self.OnAfterHeal, self.caster)
end

bs_10152.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R8 in 'UnsetPending'

  if self:IsReadyToTake() and not isTriggerSet and sender == self.caster then
    ((self.caster).recordTable)["10152_targetPow"] = target.skill_intensity
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10152_targetSunder"] = target.sunder
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
    if (skillResult.roleList).Count > 0 then
      LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
      self:OnSkillTake()
    end
  end
end

bs_10152.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if (target.targetRole).hp <= 0 then
      return 
    end
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

    if ((self.caster).recordTable)["10152_targetPow"] == nil then
      ((self.caster).recordTable)["10152_targetPow"] = (target.targetRole).skill_intensity
    end
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

    if ((self.caster).recordTable)["10152_targetSunder"] == nil then
      ((self.caster).recordTable)["10152_targetSunder"] = (target.targetRole).sunder
    end
    local targetPow = ((self.caster).recordTable)["10152_targetPow"]
    local targetSunder = ((self.caster).recordTable)["10152_targetSunder"]
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).realDamageConfig, {targetPow, targetSunder}, true)
    if (skillResult.roleList).Count > 0 then
      for i = 0, (skillResult.roleList).Count - 1 do
        local role = (skillResult.roleList)[i]
        LuaSkillCtrl:CallEffect(role, (self.config).effectId2, self)
      end
    end
    do
      skillResult:EndResult()
    end
  end
end

bs_10152.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10152

