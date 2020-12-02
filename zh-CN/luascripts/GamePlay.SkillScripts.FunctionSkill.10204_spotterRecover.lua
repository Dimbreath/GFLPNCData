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
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHeal, "bs_10204_5", 1, self.OnSetHeal)
end

bs_10204.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and (context.skill).dataId ~= (self.cskill).dataId then
    local healNum = context.heal * (self.arglist)[1] // 1000
    if healNum <= 0 then
      return 
    end
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
    if targetList.Count < 1 then
      return 
    end
    for i = 0, targetList.Count - 1 do
      local target = (targetList[i]).targetRole
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {context.heal})
      skillResult:EndResult()
    end
  end
end

bs_10204.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10204

