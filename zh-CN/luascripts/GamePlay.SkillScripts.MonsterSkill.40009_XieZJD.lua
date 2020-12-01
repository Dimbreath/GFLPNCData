-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40009 = class("bs_40009", LuaSkillBase)
local base = LuaSkillBase
bs_40009.config = {
hurt_config = {basehurt_formula = 10007}
, buffId = 1007, buffDispelEffectId = 10275, buffDamageFormula = 10019, audioId1 = 80, audioId2 = 81}
bs_40009.ctor = function(self)
  -- function num : 0_0
end

bs_40009.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_40009_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_40009_7", 1, self.OnAfterAddBuff)
end

bs_40009.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and skill.isCommonAttack then
    LuaSkillCtrl:CallBuffRepeated(self, target, (self.config).buffId, 1, (self.arglist)[4], self.OnBuffExecute)
    ;
    (target.auSource):PlayAudioById((self.config).audioId1)
  end
end

bs_40009.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_3 , upvalues : _ENV
  (targetRole.auSource):PlayAudioById((self.config).audioId2)
  local damage = (math.max)(LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).buffDamageFormula, self.caster, targetRole, self), 1)
  damage = damage * buff.tier
  LuaSkillCtrl:RemoveLife(damage, self, targetRole, false, false, buff)
  LuaSkillCtrl:CallEffect(targetRole, (self.config).buffDispelEffectId, self)
end

bs_40009.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_4 , upvalues : _ENV
  if buff.dataId == (self.config).buffId and (self.arglist)[2] <= target:GetBuffTier((self.config).buffId) then
    (target.auSource):PlayAudioById((self.config).audioId2)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    LuaSkillCtrl:CallEffect(target, (self.config).buffDispelEffectId, self)
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0)
    skillResult:EndResult()
  end
end

bs_40009.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40009

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40009 = class("bs_40009", LuaSkillBase)
local base = LuaSkillBase
bs_40009.config = {
    hurt_config = {basehurt_formula = 10007},
    buffId = 1007,
    buffDispelEffectId = 10275,
    buffDamageFormula = 10019,
    audioId1 = 80,
    audioId2 = 81
}
bs_40009.ctor = function(self)
    -- function num : 0_0
end

bs_40009.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_40009_3", 1,
                    self.OnAfterHurt)
    self:AddTrigger(eSkillTriggerType.AfterAddBuff, "bs_40009_7", 1,
                    self.OnAfterAddBuff)
end

bs_40009.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and not isMiss and skill.isCommonAttack then
        LuaSkillCtrl:CallBuffRepeated(self, target, (self.config).buffId, 1,
                                      (self.arglist)[4], self.OnBuffExecute);
        (target.auSource):PlayAudioById((self.config).audioId1)
    end
end

bs_40009.OnBuffExecute = function(self, buff, targetRole)
    -- function num : 0_3 , upvalues : _ENV
    (targetRole.auSource):PlayAudioById((self.config).audioId2)
    local damage = (math.max)(LuaSkillCtrl:CallFormulaNumberWithSkill(
                                  (self.config).buffDamageFormula, self.caster,
                                  targetRole, self), 1)
    damage = damage * buff.tier
    LuaSkillCtrl:RemoveLife(damage, self, targetRole, false, false, buff)
    LuaSkillCtrl:CallEffect(targetRole, (self.config).buffDispelEffectId, self)
end

bs_40009.OnAfterAddBuff = function(self, buff, target)
    -- function num : 0_4 , upvalues : _ENV
    if buff.dataId == (self.config).buffId and (self.arglist)[2] <=
        target:GetBuffTier((self.config).buffId) then
        (target.auSource):PlayAudioById((self.config).audioId2)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
        LuaSkillCtrl:CallEffect(target, (self.config).buffDispelEffectId, self)
        LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0)
        skillResult:EndResult()
    end
end

bs_40009.OnCasterDie = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40009

