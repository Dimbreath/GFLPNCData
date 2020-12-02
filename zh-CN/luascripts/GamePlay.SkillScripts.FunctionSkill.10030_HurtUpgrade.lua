-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10030 = class("bs_10030", LuaSkillBase)
local base = LuaSkillBase
bs_10030.config = {hurtNumFormula = 10007}
bs_10030.ctor = function(self)
  -- function num : 0_0
end

bs_10030.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10030_1", 1, self.OnSetHurt)
end

bs_10030.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isMiss and not context.isTriggerSet then
    local damage = (math.max)(LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).hurtNumFormula, self.caster, context.target, self), 1)
    LuaSkillCtrl:RemoveLife(damage, self, context.target, true, true)
  end
end

bs_10030.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10030

