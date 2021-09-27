local bs_5123 = class("bs_5123", LuaSkillBase)
local base = LuaSkillBase
bs_5123.config = {effectIdAttack = 512301, buffId = 512301, audioId_start = 142, audioId_hit = 143}
bs_5123.ctor = function(self)
  -- function num : 0_0
end

bs_5123.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5123.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5123.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum == (self.caster).belongNum then
    LuaSkillCtrl:CallEffect(role, (self.config).effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(role, (self.config).audioId_start)
  end
end

bs_5123.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId, 1, (self.arglist)[1])
  end
end

bs_5123.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5123

