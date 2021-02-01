-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10234 = class("bs_10234", LuaSkillBase)
local base = LuaSkillBase
bs_10234.config = {buffId = 1088, buffTier = 1, 
heal_config = {baseheal_formula = 10076, heal_number = 0, correct_formula = 9990}
, effectId = 10634, debuffId = 1119}
bs_10234.ctor = function(self)
  -- function num : 0_0
end

bs_10234.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHeal, "bs_10234_5", 1, self.OnAfterHeal)
end

bs_10234.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isTriggerSet then
    local buffTier = target:GetBuffTier((self.config).buffId)
    if buffTier > 0 then
      return 
    end
    local debuffTier = target:GetBuffTier((self.config).debuffId)
    if debuffTier > 0 then
      return 
    end
    LuaSkillCtrl:CallBuffRepeated(self, target, (self.config).buffId, (self.config).buffTier, (self.arglist)[2], false, self.OnBuffExecute)
  end
end

bs_10234.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, true, true)
  skillResult:EndResult()
end

bs_10234.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10234

