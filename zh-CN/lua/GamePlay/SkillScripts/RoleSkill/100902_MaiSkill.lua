local bs_100902 = class("bs_100902", LuaSkillBase)
local base = LuaSkillBase
bs_100902.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0, crithur_ratio = 0}
, effectIdTornado2 = 100906, effetcIdTornadoRadius = 100, skill_time = 28, start_time = 12, actionId = 1002, action_speed = 1, effectId_start = 100905, buffId_blind = 3012, effectId_hit = 100907}
bs_100902.ctor = function(self)
  -- function num : 0_0
end

bs_100902.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.effect = {}
  self.time = 1
end

bs_100902.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
end

bs_100902.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local gridTemp = LuaSkillCtrl:CallFindGridMostRolesArounded(2)
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(gridTemp.x, gridTemp.y)
  if gridTarget ~= nil then
    local time = self.time
    do
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

      (self.effect)[time] = LuaSkillCtrl:CallEffect(gridTarget, (self.config).effectIdTornado2, self, nil, nil, nil, false)
      self._callHurt = BindCallback(self, self.CallHurt, (self.effect)[time])
      local _onCollision = BindCallback(self, self.OnCollisionStay)
      local _onEnter = BindCallback(self, self.OnEnter)
      local _onExite = BindCallback(self, self.OnExite)
      LuaSkillCtrl:CallAddCircleColliderForEffect((self.effect)[time], (self.config).effetcIdTornadoRadius, eColliderInfluenceType.Enemy, _onCollision, _onEnter, _onExite)
      self.colliDetectTime = (LuaSkillCtrl.battleCtrl).frame
      LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
    -- function num : 0_3_0 , upvalues : self, time
    if self.effect ~= nil and (self.effect)[time] ~= nil then
      ((self.effect)[time]):Die()
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (self.effect)[time] = nil
    end
  end
)
      self.time = self.time + 1
    end
  end
end

bs_100902.OnEnter = function(self, collider, index, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity.intensity ~= 0 then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId_blind, 1, (self.arglist)[2])
  end
end

bs_100902.OnExite = function(self, collider, entity)
  -- function num : 0_5
end

bs_100902.OnCollisionStay = function(self, Collider, role)
  -- function num : 0_6 , upvalues : _ENV
  if (LuaSkillCtrl.battleCtrl).frame == self.colliDetectTime then
    (self._callHurt)(role)
    self.colliDetectTime = (LuaSkillCtrl.battleCtrl).frame
  else
    if (LuaSkillCtrl.battleCtrl).frame - self.colliDetectTime >= 14 then
      self.colliDetectTime = (LuaSkillCtrl.battleCtrl).frame + 1
    end
  end
end

bs_100902.CallHurt = function(self, effect, target)
  -- function num : 0_7 , upvalues : _ENV
  if target ~= nil and effect ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_hit, self)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]})
    skillResult:EndResult()
  end
end

bs_100902.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_100902.LuaDispose = function(self)
  -- function num : 0_9 , upvalues : base
  (base.LuaDispose)(self)
  self.effect = nil
end

return bs_100902

