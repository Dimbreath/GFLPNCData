local bs_10267 = class("bs_10267", LuaSkillBase)
local base = LuaSkillBase
bs_10267.config = {freezeBuff = 1178, freezeBuffDuration = 75, effectId = 10876, 
hurt_config = {hit_formula = 0, basehurt_formula = 10007, crit_formula = 0}
, formulaId = 10077}
bs_10267.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : _ENV
  self:AddAfterHurtTrigger("10267_after_hurt", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player)
end

bs_10267.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_1 , upvalues : _ENV
  if self:IsReadyToTake() and not isTriggerSet then
    if sender == nil or sender.hp <= 0 then
      return 
    end
    local hitChance = LuaSkillCtrl:CallRange(1, 1000)
    if hitChance <= (self.arglist)[1] then
      self:PlayChipEffect()
      LuaSkillCtrl:CallEffect(sender, (self.config).effectId, self, self.SkillEventFunc)
      self:OnSkillTake()
    end
  end
end

bs_10267.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_2 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).freezeBuff, 1, (self.config).freezeBuffDuration)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_10267.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10267

