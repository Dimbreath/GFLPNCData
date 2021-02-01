-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10140 = class("bs_10140", LuaSkillBase)
local base = LuaSkillBase
bs_10140.config = {buffTierFormula = 10039}
bs_10140.ctor = function(self)
  -- function num : 0_0
end

bs_10140.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHeal, "bs_10140_1", 1, self.OnSetHeal)
end

bs_10140.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.skill).maker == self.caster then
    local target = context.target
    local healUpgrade = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).buffTierFormula, self.caster, target, self)
    context.heal = context.heal + context.heal * healUpgrade // 1000
  end
end

bs_10140.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10140

