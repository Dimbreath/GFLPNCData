-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103108 = class("bs_103108", LuaSkillBase)
local base = LuaSkillBase
bs_103108.config = {effectId_snake = 10838, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10152, crit_formula = 0, crithur_ratio = 0}
}
bs_103108.ctor = function(self)
  -- function num : 0_0
end

bs_103108.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_103108_4", 1, self.OnAfterHurt, self.caster)
end

bs_103108.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack == true then
    local cskill = ((self.caster).recordTable)["2_caster_cskill"]
    local heal_num = ((self.caster).recordTable)["2_skill_int"] * ((self.caster).recordTable)["2_Atk_arg_ex"] // 1000
    if heal_num ~= nil then
      LuaSkillCtrl:CallHealWithCSkill(heal_num, cskill, self.caster, true)
    end
  end
end

bs_103108.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103108

