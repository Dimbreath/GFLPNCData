local bs_10266 = class("bs_10266", LuaSkillBase)
local base = LuaSkillBase
bs_10266.config = {freezeBuff = 1178, freezeBuffDuration = 75, effectId = 10876}
bs_10266.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : _ENV
  self:AddAfterHurtTrigger("10266_after_hurt", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.attackNum = 0
end

bs_10266.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_1
  if self:IsReadyToTake() and not isTriggerSet then
    self.attackNum = self.attackNum + 1
    self:CheckAndAddBuffToTarget(sender, target)
  end
end

bs_10266.CheckAndAddBuffToTarget = function(self, sender, target)
  -- function num : 0_2 , upvalues : _ENV
  if target ~= nil and target.hp > 0 and sender ~= nil and sender.hp > 0 and (self.arglist)[1] <= self.attackNum then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
    self:PlayChipEffect()
    self:OnSkillTake()
    self.attackNum = 0
  end
end

bs_10266.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).freezeBuff, 1, (self.config).freezeBuffDuration)
  end
end

bs_10266.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10266

