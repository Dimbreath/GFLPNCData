-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10014 = class("bs_10014", LuaSkillBase)
local base = LuaSkillBase
bs_10014.config = {
heal_config = {baseheal_formula = 10037, heal_number = 0, correct_formula = 9990}
, effectId = 10092}
bs_10014.ctor = function(self)
  -- function num : 0_0
end

bs_10014.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10014_3", 1, self.OnAfterHurt)
  self.heal_config = {}
end

bs_10014.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and isCrit then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    skillResult:HealResult((self.config).heal_config, {hurt})
    skillResult:EndResult()
  end
end

bs_10014.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10014

