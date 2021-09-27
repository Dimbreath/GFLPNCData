local bs_10047 = class("bs_10047", LuaSkillBase)
local base = LuaSkillBase
bs_10047.config = {
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, damageFormula = 10007}
bs_10047.ctor = function(self)
  -- function num : 0_0
end

bs_10047.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_10047_1", 1, self.OnAfterHurt, self.caster)
end

bs_10047.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and skill.isCommonAttack and not isTriggerSet then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    for i = 0, targetlist.Count - 1 do
      if (targetlist[i]).targetRole ~= target then
        local damage = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, (targetlist[i]).targetRole, self)
        LuaSkillCtrl:RemoveLife(damage, self, (targetlist[i]).targetRole)
        break
      end
    end
  end
end

bs_10047.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10047

