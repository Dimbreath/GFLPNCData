-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102002 = class("bs_102002", LuaSkillBase)
local base = LuaSkillBase
bs_102002.config = {action_start = 1008, action_loop = 1007, action_end = 1009, stun_buff = 66, cant_action_buff = 69, hookSpeed = 12, effectId = 10549, stopCdBuff = 170, onSecondTakeAction = 1004, effectId_skill_ex = 10872}
bs_102002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_102002_1", 1, self.BeforeEndBattle)
  self:BindHookObj()
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102002_2", 99, self.OnBattleStart)
end

bs_102002.BindHookObj = function(self)
  -- function num : 0_1
  local bind = self:GetSelfBindingObj()
  if bind ~= nil then
    self.weaponChildren = bind.weaponChildren
    self.weaponRoot = bind.weaponRoot
    self.casterRoot = bind.casterRoot
  end
end

bs_102002.OnBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlaySkill()
  LuaSkillCtrl:CallAfterSkillPlayTrigger(self, self.caster)
end

bs_102002.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  if self:DisAbleToHook() then
    if (self.arglist)[2] <= 0 then
      LuaSkillCtrl:CallResetCDForSingleSkill(self.cskill, -120)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).stopCdBuff, 1, nil, true)
      return 
    end
    self:StunLogic()
    return 
  end
  if (self.arglist)[2] <= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).stopCdBuff, 1, nil, true)
  end
  local emptyGrid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  if emptyGrid ~= nil then
    self.canBackRole = false
    self.targetRole = LuaSkillCtrl:CallRightMaxDirEnemy(self.caster)
    if self.targetRole ~= nil then
      local roleToEmpty = (math.abs)((self.caster).x - emptyGrid.x)
      local roleToTarget = (math.abs)((self.caster).x - (self.targetRole).x)
      local emptyToTarget = (math.abs)(emptyGrid.x - (self.targetRole).x)
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R6 in 'UnsetPending'

      if emptyToTarget >= 1 and roleToEmpty < roleToTarget then
        ((self.caster).recordTable).completedFirstHook = true
        local distance = LuaSkillCtrl:GetGridsDistance((self.caster).x, (self.caster).y, (self.targetRole).x, (self.targetRole).y)
        local flyTime = distance * 15 // (self.config).hookSpeed
        flyTime = (math.max)(3, flyTime)
        local position = nil
        if not LuaSkillCtrl.IsInVerify then
          position = (((self.targetRole).lsObject).localPosition):ToVector3() - (Vector3.New)(0, 0, 1)
        end
        local startFlyHookTime = 12 + flyTime
        local hookArriveTime = startFlyHookTime + flyTime
        local backHookTime = hookArriveTime + flyTime
        LuaSkillCtrl:CallBuff(self, self.targetRole, (self.config).cant_action_buff, 1, backHookTime)
        LuaSkillCtrl:PreSetRolePos(emptyGrid, self.targetRole)
        self:CallCasterWait(backHookTime + 2)
        ;
        (self.caster):LookAtTarget(self.targetRole)
        LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).action_start)
  end
, self)
        if position ~= nil then
          LuaSkillCtrl:StartTimer(self, startFlyHookTime, BindCallback(self, self.OnFlyHook, position, flyTime / 15))
        end
        LuaSkillCtrl:StartTimer(self, hookArriveTime, BindCallback(self, self.OnHooKGetRole, self.targetRole, emptyGrid, flyTime))
        LuaSkillCtrl:StartTimer(nil, backHookTime, BindCallback(self, self.OnHookEnd, self.targetRole))
        return 
      end
    end
  end
  do
    if (self.arglist)[2] > 0 then
      self:StunLogic()
    end
  end
end

bs_102002.OnFlyHook = function(self, targetPos, time)
  -- function num : 0_4
  if self.weaponRoot ~= nil and self.weaponChildren ~= nil and self.casterRoot ~= nil then
    (self.weaponRoot):SetParent(self.casterRoot, false)
    ;
    (self.weaponChildren):SetParent(self.weaponRoot, false)
    ;
    ((self.caster).lsObject):SelectTransAndStartMove(self.weaponRoot, targetPos, time)
  end
end

bs_102002.OnHooKGetRole = function(self, role, backGrid, duration)
  -- function num : 0_5 , upvalues : _ENV
  self.canBackRole = true
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  if self.weaponRoot ~= nil then
    (self.weaponRoot).localRotation = (Quaternion.Euler)(0, 0, 0)
    ;
    (self.weaponRoot):SetParent((role.lsObject).transform)
  end
  LuaSkillCtrl:CanclePreSetPos(role)
  LuaSkillCtrl:CallPhaseMove(self, role, backGrid.x, backGrid.y, duration)
end

bs_102002.OnHookEnd = function(self, targetRole)
  -- function num : 0_6 , upvalues : _ENV
  if not self.canBackRole then
    return 
  end
  self:ResetActionState()
  LuaSkillCtrl:DispelBuff(targetRole, (self.config).cant_action_buff, 0, true)
  local buffDuration = (self.arglist)[1]
  if buffDuration > 0 then
    LuaSkillCtrl:CallBuff(self, targetRole, (self.config).stun_buff, 1, buffDuration)
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

  if (math.abs)(targetRole.x - (self.caster).x) <= 1 then
    ((self.caster).recordTable).lastAttackRole = targetRole
  end
end

bs_102002.ResetActionState = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.weaponRoot ~= nil and self.weaponChildren ~= nil and (self.weaponRoot).parent ~= self.weaponChildren then
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).action_end)
    ;
    (self.weaponChildren):SetParent(self.casterRoot, false)
    ;
    (self.weaponRoot):SetParent(self.weaponChildren, false)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.weaponRoot).localRotation = (Quaternion.Euler)(0, 0, 0)
  end
end

bs_102002.DisAbleToHook = function(self)
  -- function num : 0_8
  return ((self.caster).recordTable).completedFirstHook
end

bs_102002.StunLogic = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastAttackRole
  local moveTarget = nil
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    moveTarget = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget ~= nil then
      moveTarget = tempTarget.targetRole
    end
  end
  do
    do
      if moveTarget == nil then
        local _target = LuaSkillCtrl:CallTargetSelect(self, 10001, 0)
        if _target.Count > 0 and (_target[0]).targetRole ~= nil then
          moveTarget = (_target[0]).targetRole
        end
      end
      if moveTarget ~= nil then
        local curAtkRole = moveTarget.targetRole
        if not LuaSkillCtrl:IsAbleAttackTarget(self.caster, moveTarget, (self.cskill).SkillRange) then
          return 
        end
        self:CallCasterWait(38)
        ;
        (self.caster):LookAtTarget(moveTarget)
        LuaSkillCtrl:CallRoleAction(self.caster, (self.config).onSecondTakeAction)
        LuaSkillCtrl:CallEffect(moveTarget, (self.config).effectId_skill_ex, self, nil, nil, nil, true)
        LuaSkillCtrl:StartTimer(self, 12, function()
    -- function num : 0_9_0 , upvalues : _ENV, self, moveTarget
    LuaSkillCtrl:CallBuff(self, moveTarget, (self.config).stun_buff, 1, (self.arglist)[3])
  end
, self)
      end
    end
  end
end

bs_102002.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base
  self.weaponChildren = nil
  self.weaponRoot = nil
  self.casterRoot = nil
  self:ResetActionState()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.caster).recordTable).completedFirstHook = false
  ;
  (base.OnCasterDie)(self)
end

bs_102002.BeforeEndBattle = function(self)
  -- function num : 0_11
  self:ResetActionState()
end

bs_102002.OnSkillRemove = function(self)
  -- function num : 0_12 , upvalues : base
  self.weaponChildren = nil
  self.weaponRoot = nil
  self.casterRoot = nil
  self:ResetActionState()
  ;
  (base.OnSkillRemove)(self)
end

bs_102002.OnBreakSkill = function(self, role)
  -- function num : 0_13 , upvalues : _ENV, base
  self:ResetActionState()
  if self.targetRole ~= nil then
    LuaSkillCtrl:DispelBuff(self.targetRole, (self.config).cant_action_buff, 0, true)
    self.targetRole = nil
  end
  ;
  (base.OnBreakSkill)(self, role)
end

bs_102002.LuaDispose = function(self)
  -- function num : 0_14 , upvalues : base
  (base.LuaDispose)(self)
  self.targetRole = nil
  self.weaponChildren = nil
  self.weaponRoot = nil
  self.casterRoot = nil
end

return bs_102002

