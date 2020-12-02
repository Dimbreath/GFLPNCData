-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10173 = class("bs_10173", LuaSkillBase)
local base = LuaSkillBase
bs_10173.config = {buffId = 1037, heal_formula = 1047}
bs_10173.ctor = function(self)
  -- function num : 0_0
end

bs_10173.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10173_3", 1, self.OnSetHurt)
end

bs_10173.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).intensity == 0 and context.sender == self.caster and self:IsReadyToTake() and (context.target).hp <= context.hurt and (context.target).hp > 0 then
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).heal_formula, self.caster, self.caster, self)
    LuaSkillCtrl:CallHeal(healNum, self, self.caster)
  end
end

bs_10173.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10173

