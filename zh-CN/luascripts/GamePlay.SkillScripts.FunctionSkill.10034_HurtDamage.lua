-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10034 = class("bs_10034", LuaSkillBase)
local base = LuaSkillBase
bs_10034.config = {
hurt_config = {basehurt_formula = 10007}
, effectId = 1002}
bs_10034.ctor = function(self)
  -- function num : 0_0
end

bs_10034.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10034_3", 1, self.OnAfterHurt)
end

bs_10034.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and not isMiss then
    if sender == nil then
      return 
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender, self.config)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    LuaSkillCtrl:CallEffect(sender, (self.config).effectId, self)
    self:PlayChipEffect()
    skillResult:EndResult()
  end
end

bs_10034.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10034

