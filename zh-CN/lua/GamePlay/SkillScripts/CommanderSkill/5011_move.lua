local bs_5011 = class("bs_5011", LuaSkillBase)
local base = LuaSkillBase
bs_5011.config = {effectId_up = 501101, effectId_down = 501102, buffId_1000 = 1000, buffId_3004 = 3004}
bs_5011.AbandonTakeFeature = {eBuffFeatureType.NotMove, eBuffFeatureType.Bewitch, eBuffFeatureType.Taunt, eBuffFeatureType.Stun, eBuffFeatureType.KnockOff, eBuffFeatureType.BeatBack, eBuffFeatureType.Exiled, eBuffFeatureType.AbandonMove}
bs_5011.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_5011.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_1 , upvalues : _ENV
  self.targetGrid = LuaSkillCtrl:GetGridWithPos(selectTargetCoord.x, selectTargetCoord.y)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5011.CallSelectExecute = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if role ~= nil and self.targetGrid ~= nil and role.belongNum == (self.caster).belongNum then
    LuaSkillCtrl:CallEffect(role, (self.config).effectId_up, self)
    LuaSkillCtrl:CallBreakAllSkill(role)
    self:TryResetMoveState(role)
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_1000, 1, 5, true)
    LuaSkillCtrl:SetRolePos(self.targetGrid, role)
    LuaSkillCtrl:CallEffect(role, (self.config).effectId_down, self)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_3004, 1, 5, true)
  end
end

bs_5011.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5011

