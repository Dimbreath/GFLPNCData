local bs_400001 = class("bs_400001", LuaSkillBase)
local base = LuaSkillBase
bs_400001.config = {abandonMoveBuff = 1196, countDownDuration = 75, latestAtkEffect = 12006, BoomEffectTime = 12007, BoomEffect = 12005}
bs_400001.ctor = function(self)
  -- function num : 0_0
end

bs_400001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.countDownEffect = nil
  self.boomTimer = LuaSkillCtrl:StartTimer(self, 150, self.startBoom, self)
end

bs_400001.startBoom = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.boomTimer ~= nil then
    (self.boomTimer):Stop()
    self.boomTimer = nil
  end
  if self.caster == nil or (self.caster).hp <= 0 then
    return 
  end
  local TargetCampRole = (self.caster):GetRoleMoveFollowTarget()
  if TargetCampRole ~= nil and self.caster ~= nil then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).abandonMoveBuff, 1, (self.config).countDownDuration + 15, true)
    local collisionTrigger = BindCallback(self, self.KillAllMonsterAndDamageToCamp, TargetCampRole)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).BoomEffectTime, self)
    LuaSkillCtrl:StartTimer(nil, (self.config).countDownDuration, collisionTrigger)
    if self.countDownEffect == nil then
      self.time = 1
      LuaSkillCtrl:StartTimer(self, 15, function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    if self.time >= 5 then
      (self.countDownEffect):Die()
      self.countDownEffect = nil
      return 
    end
    self.countDownEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).BoomEffectTime, self)
    ;
    (self.countDownEffect):SetCountValue(self.time)
    self.time = self.time + 1
  end
, self, 4)
    end
  end
end

bs_400001.KillAllMonsterAndDamageToCamp = function(self, TargetCampRole)
  -- function num : 0_3 , upvalues : _ENV
  if self.caster ~= nil and (self.caster).hp > 0 then
    LuaSkillCtrl:CallEffectWithArgAndSpeedOverride(TargetCampRole, (self.config).latestAtkEffect, self, self.caster, 1, false, false, self.EffectEventTrigger)
  end
end

bs_400001.EffectEventTrigger = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local targetRole = target.targetRole
    if targetRole ~= nil and targetRole.hp > 0 then
      LuaSkillCtrl:RemoveLife(targetRole.maxHp // 8 + 1, self, target, true, nil, true, true)
    end
    if (self.caster).hp > 0 then
      LuaSkillCtrl:CallEffect(self.caster, (self.config).BoomEffect, self)
      LuaSkillCtrl:RemoveLife((self.caster).hp + 1, self, self.caster, true, nil, true, true)
    end
  end
end

bs_400001.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  if self.countDownEffect ~= nil then
    (self.countDownEffect):Die()
    self.countDownEffect = nil
  end
  if self.boomTimer ~= nil then
    (self.boomTimer):Stop()
    self.boomTimer = nil
  end
  ;
  (base.OnCasterDie)(self)
end

bs_400001.LuaDispose = function(self)
  -- function num : 0_6 , upvalues : base
  (base.LuaDispose)(self)
  self.countDownEffect = nil
end

return bs_400001

