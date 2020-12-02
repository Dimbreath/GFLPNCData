-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10190 = class("bs_10190", LuaSkillBase)
local base = LuaSkillBase
bs_10190.config = {
hurt_config = {def_formula = 9996, basehurt_formula = 10076, correct_formula = 9989}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
}
bs_10190.ctor = function(self)
  -- function num : 0_0
end

bs_10190.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDoodad, self.OnDoodad)
end

bs_10190.OnDoodad = function(self, sender, targetRole)
  -- function num : 0_2 , upvalues : _ENV
  if targetRole == self.caster then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).aoe_config)
    skillResult:HurtResult((self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_10190.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10190

