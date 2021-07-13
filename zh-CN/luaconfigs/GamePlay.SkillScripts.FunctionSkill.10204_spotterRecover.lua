-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10204 = class("bs_10204", LuaSkillBase)
local base = LuaSkillBase
bs_10204.config = {
heal_config = {baseheal_formula = 10037}
}
bs_10204.ctor = function(self)
  -- function num : 0_0
end

bs_10204.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10204_5", 1, self.OnSetHeal, nil, self.caster)
end

bs_10204.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and (context.skill).dataId ~= (self.cskill).dataId then
    local sheildNum = context.heal * (self.arglist)[1] // 1000
    if sheildNum <= 0 then
      return 
    end
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
    if targetList.Count < 1 then
      return 
    end
    for i = 0, targetList.Count - 1 do
      local targetRole = (targetList[i]).targetRole
      LuaSkillCtrl:AddRoleShield(targetRole, eShieldType.Normal, sheildNum)
      LuaSkillCtrl:CallFloatText(self.caster, 11, sheildNum)
    end
    self:PlayChipEffect()
  end
end

bs_10204.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10204

