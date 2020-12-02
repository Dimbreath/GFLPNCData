-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5007 = class("bs_5007", LuaSkillBase)
local base = LuaSkillBase
bs_5007.config = {effectIdAttack = 10302, buffId = 152}
bs_5007.ctor = function(self)
  -- function num : 0_0
end

bs_5007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5007.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5007.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum == (self.caster).belongNum then
    LuaSkillCtrl:CallEffect(role, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_5007.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId, 1, (self.arglist)[1])
  end
end

bs_5007.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5007

