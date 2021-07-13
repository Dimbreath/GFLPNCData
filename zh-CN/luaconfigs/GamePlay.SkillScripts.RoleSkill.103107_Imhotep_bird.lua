-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103107 = class("bs_103107", LuaSkillBase)
local base = LuaSkillBase
bs_103107.config = {effectId_bird = 10836, buffId_26 = 26, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10152, crit_formula = 0, crithur_ratio = 0}
}
bs_103107.ctor = function(self)
  -- function num : 0_0
end

bs_103107.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_103107_3", 1, self.OnAfterHurt, self.caster)
end

bs_103107.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and self.caster ~= nil and skill.isCommonAttack == true then
    LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId_bird, self, false, true, self.SkillEventFunc, self.caster)
  end
end

bs_103107.SkillEventFunc = function(self, sender, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if sender == nil or eventId ~= eBattleEffectEvent.Trigger or sender.recordTable == nil then
    return 
  end
  local cskill = (sender.recordTable).caster_cskill
  local skill_int = (sender.recordTable).skill_int
  local arg = (sender.recordTable).Atk_arg
  if cskill == nil or skill_int == nil or arg == nil then
    return 
  end
  local hurt = LuaSkillCtrl:CallFormulaNumber(10160, target.targetRole, target.targetRole, skill_int, arg)
  LuaSkillCtrl:RemoveLifeWithCSkill(hurt, cskill, target.targetRole, false, true, nil, true, true)
  LuaSkillCtrl:PlayAuHit(self, target)
end

bs_103107.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103107

