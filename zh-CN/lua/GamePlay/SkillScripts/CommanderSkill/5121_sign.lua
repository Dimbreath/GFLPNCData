local bs_5121 = class("bs_5121", LuaSkillBase)
local base = LuaSkillBase
bs_5121.config = {effectIdAttack = 512101, buffId = 512101, audioId_start = 138, audioId_hit = 139}
bs_5121.ctor = function(self)
  -- function num : 0_0
end

bs_5121.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5121.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5121.CheckManualSkillTakeAvailable = function(self, role)
  -- function num : 0_3 , upvalues : base
  local available = (base.CheckManualSkillTakeAvailable)(self, role)
  if not available then
    return false
  end
  if role.belongNum == (self.caster).belongNum then
    return false
  end
  return true
end

bs_5121.CallSelectExecute = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectIdAttack, self, self.SkillEventFunc)
  LuaSkillCtrl:PlayAuSource(role, (self.config).audioId_start)
end

bs_5121.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId, 1, (self.arglist)[1])
  end
end

bs_5121.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5121

