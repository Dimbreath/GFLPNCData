-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10137 = class("bs_10137", LuaSkillBase)
local base = LuaSkillBase
bs_10137.config = {effectId = 10245, buffBloodId = 1044, buffDefenceId = 1012}
bs_10137.ctor = function(self)
  -- function num : 0_0
end

bs_10137.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10137_1", 1, self.OnAfterBattleStart)
end

bs_10137.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local cusEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 200, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, collisionExit, cusEffect, false, false, nil, self.caster)
end

bs_10137.OnCollisionEnter = function(self, index, entity)
  -- function num : 0_3 , upvalues : _ENV
  local layer = (self.caster):GetBuffTier((self.config).buffDefenceId)
  local defenceBuffTier = entity.pow * (self.arglist)[1] * (self.arglist)[2] // 1000000
  if (self.arglist)[1] <= layer then
    LuaSkillCtrl:DispelBuff(entity, (self.config).buffBloodId, 0)
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffBloodId, (self.arglist)[1])
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffDefenceId, defenceBuffTier)
  else
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffBloodId, (self.arglist)[1])
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffDefenceId, defenceBuffTier)
  end
end

bs_10137.OnCollisionExit = function(self, entity)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(entity, (self.config).buffBloodId, 0)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffDefenceId, 0)
end

bs_10137.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10137

