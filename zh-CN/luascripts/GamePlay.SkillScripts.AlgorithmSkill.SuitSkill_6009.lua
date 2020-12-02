-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_6009 = class("bs_6009", LuaSkillBase)
local base = LuaSkillBase
bs_6009.config = {effectId = 10054, 
hurt_config = {hit_formula = 0, def_formula = 9996, basehurt_formula = 10028, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 0, correct_formula = 9989}
}
bs_6009.ctor = function(self)
  -- function num : 0_0
end

bs_6009.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_6009_3", 1, self.OnAfterHurt)
  self.CritNum = 0
end

bs_6009.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and isCrit == true and target ~= self.caster then
    self.CritNum = self.CritNum + 1
    local num = self.CritNum
    if self.CritNum % (self.arglist)[1] == 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
      skillResult:EndResult()
    end
  end
end

bs_6009.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6009

