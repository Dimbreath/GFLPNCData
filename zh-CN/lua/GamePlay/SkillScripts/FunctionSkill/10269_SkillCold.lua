local bs_10269 = class("bs_10269", LuaSkillBase)
local base = LuaSkillBase
bs_10269.config = {neareastRoleSelectId = 1001, freezeBuff = 1178, freezeBuffDuration = 75, effectId = 10876}
bs_10269.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10269_1", 1, self.OnAfterPlaySkill)
end

bs_10269.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_1
  if skill.maker == self.caster and not skill.isCommonAttack and self:IsReadyToTake() then
    self:AddBuffForNearestRole()
    self:OnSkillTake()
  end
end

bs_10269.AddBuffForNearestRole = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targets = LuaSkillCtrl:CallTargetSelect(self, (self.config).neareastRoleSelectId, 0)
  if targets ~= nil and targets.Count > 0 then
    local role = (targets[0]).targetRole
    if role ~= nil and role.hp > 0 and role.belongNum ~= 0 then
      local curTier = role:GetBuffTier((self.config).freezeBuff)
      if (self.arglist)[1] <= curTier then
        return 
      end
      LuaSkillCtrl:CallEffect(role, (self.config).effectId, self, self.SkillEventFunc)
      self:PlayChipEffect()
    end
  end
end

bs_10269.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).freezeBuff, (self.arglist)[1], (self.config).freezeBuffDuration)
  end
end

bs_10269.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10269

