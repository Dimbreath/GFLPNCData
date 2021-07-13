-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100902 = class("bs_100902", LuaSkillBase)
local base = LuaSkillBase
bs_100902.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0}
, effectIdTornado2 = 10005, effetcIdTornadoRadius = 100, audioId1 = 46, audioId2 = 47, skill_time = 28, start_time = 12, actionId = 1002, action_speed = 1, buffId_245 = 245}
bs_100902.ctor = function(self)
  -- function num : 0_0
end

bs_100902.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_100902_1", 1, self.BeforeEndBattle)
  self.effect = {}
  self.feng = {}
  self.time = 1
end

bs_100902.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallEffect(self.caster, 10014, self)
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
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

      (self.feng)[time] = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self.effect)[time] = LuaSkillCtrl:CallEffect(gridTarget, (self.config).effectIdTornado2, self, nil, nil, nil, false)
      self._callHurt = BindCallback(self, self.CallHurt, (self.effect)[time])
      local _onCollision = BindCallback(self, self.OnCollisionStay)
      LuaSkillCtrl:CallAddCircleColliderForEffect((self.effect)[time], (self.config).effetcIdTornadoRadius, eColliderInfluenceType.Enemy, _onCollision)
      self.colliDetectTime = (LuaSkillCtrl.battleCtrl).frame
      LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], function()
    -- function num : 0_3_0 , upvalues : self, time, _ENV
    if self.effect ~= nil and (self.effect)[time] ~= nil then
      ((self.effect)[time]):Die()
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (self.effect)[time] = nil
      if self.feng ~= nil and (self.feng)[time] ~= nil then
        LuaSkillCtrl:StopAudioByBack((self.feng)[time])
      end
    end
  end
)
      self.time = self.time + 1
    end
  end
  do
    if (self.arglist)[5] > 0 then
      local buff_targetlist = LuaSkillCtrl:FindAllRolesWithinRange(gridTarget, 2, true)
      if buff_targetlist ~= nil and buff_targetlist.Count > 0 then
        for i = 0, buff_targetlist.Count - 1 do
          local now = buff_targetlist[i]
          if now.belongNum == (self.caster).belongNum then
            LuaSkillCtrl:CallBuff(self, now, (self.config).buffId_245, 1, (self.arglist)[3])
          end
        end
      end
    end
  end
end

bs_100902.OnCollisionStay = function(self, Collider, role)
  -- function num : 0_4 , upvalues : _ENV
  if (LuaSkillCtrl.battleCtrl).frame == self.colliDetectTime then
    (self._callHurt)(role)
    self.colliDetectTime = (LuaSkillCtrl.battleCtrl).frame
  else
    if (self.arglist)[2] - 1 <= (LuaSkillCtrl.battleCtrl).frame - self.colliDetectTime then
      self.colliDetectTime = (LuaSkillCtrl.battleCtrl).frame + 1
    end
  end
end

bs_100902.CallHurt = function(self, effect, target)
  -- function num : 0_5 , upvalues : _ENV
  if target ~= nil and effect ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_100902.BeforeEndBattle = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.feng == nil then
    return 
  end
  for k,v in pairs(self.feng) do
    if v ~= nil then
      LuaSkillCtrl:StopAudioByBack(v)
    end
  end
  self.feng = nil
end

bs_100902.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  if self.feng == nil then
    return 
  end
  for k,v in pairs(self.feng) do
    if v ~= nil then
      LuaSkillCtrl:StopAudioByBack(v)
    end
  end
  self.feng = nil
  ;
  (base.OnCasterDie)(self)
end

bs_100902.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.feng = nil
  self.effect = nil
end

return bs_100902

