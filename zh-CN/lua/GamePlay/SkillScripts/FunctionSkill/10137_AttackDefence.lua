local bs_10137 = class("bs_10137", LuaSkillBase)
local base = LuaSkillBase
bs_10137.config = {effectId = 10245, buffBloodId = 1044, buffDefenceId = 1045}
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

bs_10137.OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_3 , upvalues : _ENV
  if entity.intensity == 0 then
    return 
  end
  LuaSkillCtrl:CallBuff(self, entity, (self.config).buffBloodId, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffDefenceId, 1, nil, true)
end

bs_10137.OnCollisionExit = function(self, collider, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity.intensity == 0 then
    return 
  end
  LuaSkillCtrl:DispelBuff(entity, (self.config).buffBloodId, 1, nil, true)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffDefenceId, 1, nil, true)
end

bs_10137.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10137

