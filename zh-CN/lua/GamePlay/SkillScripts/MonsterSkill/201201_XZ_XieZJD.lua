local bs_40009 = class("bs_40009", LuaSkillBase)
local base = LuaSkillBase
bs_40009.config = {
hurt_config = {basehurt_formula = 10076, hit_formula = 0, crit_formula = 0, correct_formula = 9989, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0}
, 
hurt_config2 = {hit_formula = 0, basehurt_formula = 10114, crit_formula = 0, crithur_ratio = 0, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0}
, buffId_1007 = 1007, buffId_1130 = 1130, buffDispelEffectId = 10275, buffDamageFormula = 10078, audioId1 = 80, skillId = 201202}
bs_40009.ctor = function(self)
  -- function num : 0_0
end

bs_40009.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_40009_3", 1, self.OnAfterHurt, self.caster)
  self:AddAfterAddBuffTrigger("bs_40009_7", 1, self.OnAfterAddBuff, self.caster)
end

bs_40009.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and skill.isCommonAttack then
    LuaSkillCtrl:CallBuffRepeated(self, target, (self.config).buffId_1007, 1, (self.arglist)[4], false, self.OnBuffExecute)
    LuaSkillCtrl:PlayAuSource(target, (self.config).audioId1)
  end
end

bs_40009.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_3 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:PlayAuHit(self, targetRole)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config2, {buff.tier}, true)
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(targetRole, (self.config).buffDispelEffectId, self)
end

bs_40009.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_4 , upvalues : _ENV
  do
    if buff.dataId == (self.config).buffId_1007 and (self.arglist)[2] <= target:GetBuffTier((self.config).buffId_1007) then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:PlayAuHit(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
      LuaSkillCtrl:CallEffect(target, (self.config).buffDispelEffectId, self)
      LuaSkillCtrl:DispelBuff(target, (self.config).buffId_1007, 0)
      skillResult:EndResult()
    end
    if buff.dataId == (self.config).buffId_1130 then
      LuaSkillCtrl:CallBuffRepeated(self, target, (self.config).buffId_1007, 1, (self.arglist)[4], false, self.OnBuffExecute)
      LuaSkillCtrl:PlayAuSource(target, (self.config).audioId1)
    end
  end
end

bs_40009.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40009

