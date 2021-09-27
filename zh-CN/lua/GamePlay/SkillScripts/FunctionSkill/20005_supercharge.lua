local bs_20005 = class("bs_20005", LuaSkillBase)
local base = LuaSkillBase
bs_20005.config = {formula = 10106}
bs_20005.ctor = function(self)
  -- function num : 0_0
end

bs_20005.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_20005_2", 1, self.OnSetHurt, self.caster)
end

bs_20005.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.skill).isCommonAttack and context.sender == self.caster and (context.target).intensity < 3 and not context.isMiss then
    local baseHurt = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).formula, self.caster, context.target, self)
    if context.hurt <= baseHurt then
      context.hurt = baseHurt
    end
  end
end

bs_20005.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20005

