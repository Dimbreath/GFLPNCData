local bs_5013 = class("bs_5013", LuaSkillBase)
local base = LuaSkillBase
bs_5013.config = {effectId_up = 501101, effectId_down = 501102, effectId_heal = 501301, buffId_1000 = 1000, buffId_3004 = 3004}
bs_5013.AbandonTakeFeature = {eBuffFeatureType.NotMove, eBuffFeatureType.Bewitch, eBuffFeatureType.Taunt, eBuffFeatureType.Stun, eBuffFeatureType.KnockOff, eBuffFeatureType.BeatBack, eBuffFeatureType.Exiled, eBuffFeatureType.AbandonMove}
bs_5013.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_5013.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_1 , upvalues : _ENV
  self.targetGrid = LuaSkillCtrl:GetGridWithPos(selectTargetCoord.x, selectTargetCoord.y)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5013.CallSelectExecute = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if role ~= nil and self.targetGrid ~= nil and role.belongNum == (self.caster).belongNum then
    LuaSkillCtrl:CallEffect(role, (self.config).effectId_up, self)
    LuaSkillCtrl:CallBreakAllSkill(role)
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_1000, 1, 5, true)
    self:TryResetMoveState(role)
    LuaSkillCtrl:SetRolePos(self.targetGrid, role)
    LuaSkillCtrl:CallEffect(role, (self.config).effectId_down, self)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_3004, 1, 5, true)
    local healnum = role.maxHp * (self.arglist)[1] // 1000
    local heal_config = {heal_number = healnum}
    if healnum > 0 then
      LuaSkillCtrl:CallEffect(role, (self.config).effectId_heal, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HealResult(skillResult, heal_config, nil, false, true)
      skillResult:EndResult()
    end
  end
end

bs_5013.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5013

