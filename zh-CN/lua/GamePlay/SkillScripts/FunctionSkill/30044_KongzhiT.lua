local bs_30044 = class("bs_30044", LuaSkillBase)
local base = LuaSkillBase
bs_30044.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0}
}
bs_30044.ctor = function(self)
  -- function num : 0_0
end

bs_30044.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_30044_2", 1, self.OnBeforeAddBuff, self.caster)
end

bs_30044.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2 , upvalues : _ENV
  if ((context.buff).buffCfg).IsControl then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
    skillResult:EndResult()
  end
end

bs_30044.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30044

