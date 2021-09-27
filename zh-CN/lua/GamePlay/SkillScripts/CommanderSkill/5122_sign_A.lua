local bs_5122 = class("bs_5122", LuaSkillBase)
local base = LuaSkillBase
bs_5122.config = {effectIdAttack = 512201, buffId = 512201, 
HurtConfig = {basehurt_formula = 10136}
, audioId_start = 140, audioId_hit = 141}
bs_5122.ctor = function(self)
  -- function num : 0_0
end

bs_5122.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5122.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5122.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect then
    LuaSkillCtrl:CallEffect(role, (self.config).effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(role, (self.config).audioId_start)
  end
end

bs_5122.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId, (self.cskill).level, (self.arglist)[1])
  end
end

bs_5122.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5122

