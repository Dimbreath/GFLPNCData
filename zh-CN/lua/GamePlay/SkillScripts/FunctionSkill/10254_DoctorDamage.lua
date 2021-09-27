local bs_10254 = class("bs_10254", LuaSkillBase)
local base = LuaSkillBase
bs_10254.config = {
realDamageConfig = {basehurt_formula = 10046, lifesteal_formula = 0, spell_lifesteal_formula = 0}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, 
aoe_config1 = {effect_shape = 3, aoe_select_code = 5, aoe_range = 2}
, effectId = 10257, effectId2 = 10256, effectId3 = 10902}
bs_10254.ctor = function(self)
  -- function num : 0_0
end

bs_10254.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10254_12", 1, self.OnAfterPlaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_10254_1", 1, self.OnHurtResultStart)
  self.flag = false
end

bs_10254.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
  if role == self.caster and not skill.isCommonAttack and not self.flag then
    self.flag = true
  end
end

bs_10254.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.sender == self.caster and skill.isCommonAttack and self.flag then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target, (self.config).aoe_config)
    if ((self.caster).recordTable)["30041_Flag"] then
      skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target, (self.config).aoe_config1)
    end
    if (skillResult.roleList).Count > 0 then
      if ((self.caster).recordTable)["30041_Flag"] then
        LuaSkillCtrl:CallEffect(context.target, (self.config).effectId3, self, self.SkillEventFunc)
      else
        LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self, self.SkillEventFunc)
      end
      self:OnSkillTake()
      self:PlayChipEffect()
      self.flag = false
    end
  end
end

bs_10254.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if (target.targetRole).hp <= 0 then
      return 
    end
    local targetPow = (self.caster).skill_intensity
    local targetSunder = (self.caster).magic_pen
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    if ((self.caster).recordTable)["30041_Flag"] then
      targetPow = targetPow + targetPow * ((self.caster).recordTable)["30041_arg"] // 1000
      skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config1)
    end
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

bs_10254.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10254

