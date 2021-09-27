local bs_10253 = class("bs_10253", LuaSkillBase)
local base = LuaSkillBase
bs_10253.config = {
heal_config = {baseheal_formula = 10140}
, effectId_start = 10802, effectId_line = 10804, effectId_end = 10803}
bs_10253.ctor = function(self)
  -- function num : 0_0
end

bs_10253.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10253_3", 1, self.OnAfterHurt, self.caster)
end

bs_10253.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and hurt > 0 then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1, 20, target)
    self.hurt = hurt
    if targetList.Count > 0 and (targetList[0]).targetRole ~= nil then
      LuaSkillCtrl:CallEffect(target, (self.config).effectId_start, self)
      LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectId_line, self, self.SkillEventFunc, target)
    end
  end
end

bs_10253.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {self.hurt}, false, true)
    skillResult:EndResult()
  end
end

bs_10253.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10253

