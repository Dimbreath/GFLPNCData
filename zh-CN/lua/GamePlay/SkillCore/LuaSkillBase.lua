local csRoleState = CS.eBattleRoleState
local LuaSkillBase = class("LuaSkillBase")
;
(xlua.private_accessible)(CS.BattleRealRoleEntity)
;
(xlua.private_accessible)(CS.BattleCharacterEntity)
;
(xlua.private_accessible)(CS.BattleSkillInputController)
LuaSkillBase.ctor = function(self)
  -- function num : 0_0
end

LuaSkillBase.__InitSkillInternal = function(self, cskill, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self.cskill = cskill
  self.isCommonAttack = cskill.isCommonAttack
  self.caster = cskill.maker
  self.level = cskill.level
  self.arglist = {}
  self.timers = {}
  self.effects = {}
  self.luaTriggerDict = {}
  self.luaTriggerList = {}
  for i = 0, (cskill.skillFormulaArgs).Length - 1 do
    (table.insert)(self.arglist, (cskill.skillFormulaArgs)[i])
  end
  self._skillLogicType = cskill.skillType
  self:InitSkill(isMidwaySkill)
end

LuaSkillBase.IsConsumeSkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  do return self._skillLogicType == eBattleSkillLogicType.ChipConsume end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

LuaSkillBase.GetSelfBindingObj = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local binding = nil
  if self.caster == nil then
    return 
  end
  if ((self.caster).lsObject).gameObject ~= nil then
    binding = {}
    ;
    (UIUtil.LuaUIBindingTable)(((self.caster).lsObject).gameObject, binding)
  end
  return binding
end

LuaSkillBase.AddTimer = function(self, timer)
  -- function num : 0_4 , upvalues : _ENV
  if self.timers ~= nil and timer ~= nil then
    (table.insert)(self.timers, timer)
  end
end

LuaSkillBase.RemoveTimer = function(self, timer)
  -- function num : 0_5 , upvalues : _ENV
  if self.timers ~= nil and timer ~= nil then
    (table.removebyvalue)(self.timers, timer)
  end
end

LuaSkillBase.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_6 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.OnBreakSkill, "base_breakSkill", 1, self.OnBreakSkill)
end

LuaSkillBase.OnCasterBorn = function(self)
  -- function num : 0_7
end

LuaSkillBase.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_8
  return true
end

LuaSkillBase.TakeSkillPlay = function(self, data, isUltSkill, moveSelectTarget, selectTargetCoord, selectRoles)
  -- function num : 0_9 , upvalues : _ENV
  if isUltSkill then
    self.ultHmp = LuaSkillCtrl:GetUltHMp()
    self:RemoveSkillTrigger(eSkillTriggerType.AfterSelfUltSpecTimeLineEnd)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltSpecTimeLineEnd, "baseult_afterSpec", 1, self.AfterUltSpecView)
    self:RemoveSkillTrigger(eSkillTriggerType.AfterSelfUltEffectEnd)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltEffectEnd, "baseult_after", 1, BindCallback(self, self.PlaySkill, data, selectTargetCoord, selectRoles))
    if self:IsConsumeSkill() then
      self:PlayUltMovie()
    else
      self:RemoveSkillTrigger(eSkillTriggerType.StartSelfUltRoleAction)
      self:AddTrigger(eSkillTriggerType.StartSelfUltRoleAction, "baseult_startaction", 1, self.CkeckAndCallUltRoleAction)
      local isCancleTake = self:PlayUltEffect(data, selectTargetCoord, selectRoles)
      if isCancleTake then
        return false
      end
      MsgCenter:Broadcast(eMsgEventId.OnUltSkillRoleActionStart, self.caster)
    end
    do
      do return true end
      self.moveSelectTarget = moveSelectTarget
      local result = self:PlaySkill(data, selectTargetCoord, selectRoles)
      if self:IsConsumeSkill() then
        return true
      end
      do return result end
    end
  end
end

LuaSkillBase.CheckSortTarget = function(self, targetA, targetB, finalCoordA, finalCoordB)
  -- function num : 0_10
  return 0
end

LuaSkillBase.GetMoveSelectTarget = function(self)
  -- function num : 0_11
  return self.moveSelectTarget
end

LuaSkillBase.CkeckAndCallUltRoleAction = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if (LuaSkillCtrl.cUltSkillCtrl).currentSkill == nil then
    return 
  end
  self:OnUltRoleAction()
end

LuaSkillBase.OnUltRoleAction = function(self)
  -- function num : 0_13
end

LuaSkillBase.AfterUltSpecView = function(self, isFromBreak)
  -- function num : 0_14 , upvalues : _ENV
  if self:IsConsumeSkill() then
    LuaSkillCtrl:CallEndUltEffect(self.caster)
  else
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  end
  self:OnAfterUltEffect(isFromBreak)
end

LuaSkillBase.GetSelectTargetAndExecute = function(self, selectRoles, executeFunc)
  -- function num : 0_15
  if executeFunc == nil then
    return true
  end
  if selectRoles == nil or selectRoles.Count <= 0 then
    return false
  end
  local takeAvailable = false
  for i = selectRoles.Count - 1, 0, -1 do
    local curSkilltakeAvailable = self:CheckManualSkillTakeAvailable(selectRoles[i])
    if curSkilltakeAvailable then
      takeAvailable = curSkilltakeAvailable
      executeFunc(selectRoles[i])
    end
  end
  return takeAvailable
end

LuaSkillBase.CheckManualSkillTakeAvailable = function(self, role)
  -- function num : 0_16 , upvalues : _ENV
  if role == nil or role.hp <= 0 then
    return false
  end
  if role.unableSelect or role:IsUnselectAbleExceptSameBelong((self.caster).belongNum) then
    return false
  end
  if self.AbandonTakeFeature == nil or #self.AbandonTakeFeature == nil then
    return true
  end
  for i = 1, #self.AbandonTakeFeature do
    if LuaSkillCtrl:RoleContainsBuffFeature(role, (self.AbandonTakeFeature)[i]) then
      return false
    end
  end
  return true
end

LuaSkillBase.InjectActionTrigger = function(self, mainAction)
  -- function num : 0_17
  self.actionTrigger = mainAction
end

LuaSkillBase.TakeActionTrigger = function(self)
  -- function num : 0_18 , upvalues : _ENV
  self.isSkillUncompleted = false
  if self.actionTrigger ~= nil then
    if not self.isCommonAttack then
      LuaSkillCtrl:StopShowSkillDurationTime(self)
    end
    ;
    (self.actionTrigger)()
    self.actionTrigger = nil
  end
end

LuaSkillBase.OnBreakSkill = function(self, role)
  -- function num : 0_19 , upvalues : _ENV
  if role ~= self.caster then
    return 
  end
  if self.timers ~= nil then
    local leng = (table.length)(self.timers)
    if leng > 0 then
      for i = 1, leng do
        if (self.timers)[i] ~= nil then
          ((self.timers)[i]):Stop()
          -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self.timers)[i] = nil
        end
      end
    end
    do
      do
        self.timers = {}
        self:RemoveAllBreakKillEffects()
        if self.isSkillUncompleted then
          if not self.isCommonAttack and (self.caster).roleType ~= eBattleRoleType.skillCaster then
            LuaSkillCtrl:StopShowSkillDurationTime(self)
          end
          ;
          (self.caster):RemoveSkillWaitBuff()
          ;
          (self.cskill):ReturnCDTimeFromBreak()
          self.isSkillUncompleted = false
        end
      end
    end
  end
end

LuaSkillBase.TryResetMoveState = function(self, role)
  -- function num : 0_20 , upvalues : csRoleState
  if role == nil or role.hp <= 0 then
    return 
  end
  if role.eState == csRoleState.Moving then
    role:SetRoleState(csRoleState.Normal)
  end
end

LuaSkillBase.OnCasterDie = function(self)
  -- function num : 0_21 , upvalues : _ENV
  LuaSkillCtrl:RemoveHandleAllTrigger(self.cskill)
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
end

LuaSkillBase.RemoveAllTimers = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if self.timers == nil then
    return 
  end
  local leng = (table.length)(self.timers)
  if leng > 0 then
    for i = 1, leng do
      if (self.timers)[i] ~= nil then
        ((self.timers)[i]):Stop()
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.timers)[i] = nil
      end
    end
  end
  do
    self.timers = {}
  end
end

LuaSkillBase.RemoveAllBreakKillEffects = function(self)
  -- function num : 0_23 , upvalues : _ENV
  if self.effects == nil then
    return 
  end
  local leng = (table.length)(self.effects)
  if leng > 0 then
    for i = 1, leng do
      if (self.effects)[i] ~= nil and not ((self.effects)[i]):IsDie() then
        local skillMaker = ((self.effects)[i]).skillMaker
        if skillMaker == nil or skillMaker == self.caster then
          ((self.effects)[i]):Die()
        end
      end
    end
  end
  do
    self.effects = {}
  end
end

LuaSkillBase.BreakSkill = function(self)
  -- function num : 0_24 , upvalues : _ENV
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  LuaSkillCtrl:CallResetComAtkCDRatioForRole(self.caster, 100)
  LuaSkillCtrl:BreakCurrentAction(self.caster)
end

LuaSkillBase.OnSkillRemove = function(self)
  -- function num : 0_25 , upvalues : _ENV
  if self.ultCv ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.ultCv)
    self.ultCv = nil
  end
  LuaSkillCtrl:RemoveHandleAllTrigger(self.cskill)
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
end

LuaSkillBase.AddTrigger = function(self, triggerType, name, priority, eventFunc)
  -- function num : 0_26 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTrigger(triggerType, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false)
end

LuaSkillBase.AddSelfTrigger = function(self, triggerType, name, priority, eventFunc)
  -- function num : 0_27 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTrigger(triggerType, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, true, self.caster)
end

LuaSkillBase.RemoveSkillTrigger = function(self, triggerType)
  -- function num : 0_28 , upvalues : _ENV
  LuaSkillCtrl:RemoveTrigger(self.cskill, triggerType)
end

LuaSkillBase.AddSetHurtTrigger = function(self, name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
  -- function num : 0_29 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.SetHurt, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
end

LuaSkillBase.AddSetDeadHurtTrigger = function(self, name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
  -- function num : 0_30 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.SetDeadHurt, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
end

LuaSkillBase.AddAfterHurtTrigger = function(self, name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, extraArg)
  -- function num : 0_31 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterHurt, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag, extraArg)
end

LuaSkillBase.AddSetHealTrigger = function(self, name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
  -- function num : 0_32 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.SetHeal, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
end

LuaSkillBase.AddAfterHealTrigger = function(self, name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
  -- function num : 0_33 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterHeal, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId, skillTag)
end

LuaSkillBase.AddAfterAddBuffTrigger = function(self, name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, buffId, buffType, buffFeature)
  -- function num : 0_34 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterAddBuff, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

LuaSkillBase.AddAfterAddBuffHitMaxTierTrigger = function(self, name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, buffId, buffType, buffFeature)
  -- function num : 0_35 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterBuffAddHitMaxTier, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

LuaSkillBase.AddBeforeAddBuffTrigger = function(self, name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, buffId, buffType, buffFeature)
  -- function num : 0_36 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.BeforeAddBuff, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

LuaSkillBase.AddBeforeBuffDispelTrigger = function(self, name, priority, eventFunc, target, targetBelongNum, buffId, buffType, buffFeature)
  -- function num : 0_37 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.BeforeBuffDispel, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, nil, target, -1, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

LuaSkillBase.AddBuffDieTrigger = function(self, name, priority, eventFunc, target, targetBelongNum, buffId, buffType, buffFeature)
  -- function num : 0_38 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.BuffDie, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, nil, target, -1, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

LuaSkillBase.AddAfterBuffRemoveTrigger = function(self, name, priority, eventFunc, target, targetBelongNum, buffId, buffType, buffFeature)
  -- function num : 0_39 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.AfterBuffRemove, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, nil, target, -1, targetBelongNum, 0, 0, buffId, buffType, buffFeature)
end

LuaSkillBase.AddOnRoleDieTrigger = function(self, name, priority, eventFunc, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId)
  -- function num : 0_40 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.RoleDie, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, skillId)
end

LuaSkillBase.AddOnPlayerMpCostedTrigger = function(self, name, priority, eventFunc, costTargetValue)
  -- function num : 0_41 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTriggerWithBindArg(eSkillTriggerType.OnPlayerMpCostToTargetValue, self.cskill, eTriggerSkillType.RoleSkill, name, priority, bindFunc, false, nil, nil, nil, nil, 0, 0, costTargetValue)
end

LuaSkillBase.AddLuaTrigger = function(self, luaTriggerId, action)
  -- function num : 0_42 , upvalues : _ENV
  if action ~= nil then
    local cb = BindCallback(self, action)
    if (self.luaTriggerDict)[luaTriggerId] ~= nil then
      error((string.format)("%s已经包含了%s的特殊Lua触发器，请检查%s", (self.cskill).name, luaTriggerId, (self.cskill).dataId))
      return 
    end
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.luaTriggerDict)[luaTriggerId] = cb
    ;
    (table.insert)(self.luaTriggerList, luaTriggerId)
    LuaSkillCtrl:RegisterLuaTrigger(luaTriggerId, cb)
  end
end

LuaSkillBase.AddLuaTriggerWithoutBindCB = function(self, luaTriggerId, action)
  -- function num : 0_43 , upvalues : _ENV
  if luaTriggerId == nil or action == nil then
    return 
  end
  if (self.luaTriggerDict)[luaTriggerId] ~= nil then
    error((string.format)("%s已经包含了%s的特殊Lua触发器，请检查%s", (self.cskill).name, luaTriggerId, (self.cskill).dataId))
    return 
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.luaTriggerDict)[luaTriggerId] = action
  ;
  (table.insert)(self.luaTriggerList, luaTriggerId)
  LuaSkillCtrl:RegisterLuaTriggerWithoutBindCB(luaTriggerId, action)
end

LuaSkillBase.UnRegisterLuaTrigger = function(self, luaTriggerId)
  -- function num : 0_44 , upvalues : _ENV
  if luaTriggerId == nil then
    return 
  end
  local cb = nil
  if (self.luaTriggerDict)[luaTriggerId] ~= nil then
    cb = (self.luaTriggerDict)[luaTriggerId]
  end
  if cb == nil then
    return 
  end
  LuaSkillCtrl:UnRegisterLuaTrigger(luaTriggerId, cb)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.luaTriggerDict)[luaTriggerId] = nil
  ;
  (table.removebyvalue)(self.luaTriggerList, luaTriggerId)
end

LuaSkillBase.RemoveAllLuaTrigger = function(self)
  -- function num : 0_45 , upvalues : _ENV
  if self.luaTriggerDict == nil or self.luaTriggerList == nil then
    return 
  end
  for i = #self.luaTriggerList, 1, -1 do
    local triggerId = (self.luaTriggerList)[i]
    if (self.luaTriggerDict)[triggerId] ~= nil then
      local cb = (self.luaTriggerDict)[triggerId]
      LuaSkillCtrl:UnRegisterLuaTrigger(triggerId, cb)
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.luaTriggerDict)[triggerId] = nil
    end
  end
  self.luaTriggerList = {}
  self.luaTriggerDict = {}
end

LuaSkillBase.CallCaterAtion = function(self, id)
  -- function num : 0_46 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, id)
end

LuaSkillBase.CallCasterWait = function(self, duration, isWaiteToCallNextSkillUnFreeze)
  -- function num : 0_47
  ;
  (self.caster):AddSkillWaitBuff(duration, isWaiteToCallNextSkillUnFreeze or false)
end

LuaSkillBase.AbandonSkillCdAutoReset = function(self, isAbandon)
  -- function num : 0_48
  (self.cskill):SetSkillAbandonAutoResetCd(isAbandon)
end

LuaSkillBase.CancleCasterWait = function(self)
  -- function num : 0_49
  (self.caster):RemoveSkillWaitBuff()
end

LuaSkillBase.CallNextBossSkill = function(self)
  -- function num : 0_50
  self:OnSkillTake()
  ;
  (self.caster):CallUnFreezeNextSkill()
end

LuaSkillBase.CallCasterLookAt = function(self, targetList)
  -- function num : 0_51
  if targetList.Count > 0 then
    (self.caster):LookAtTarget(targetList[0])
  end
end

LuaSkillBase.IsReadyToTake = function(self)
  -- function num : 0_52
  return (self.cskill):IsReadyToTake()
end

LuaSkillBase.OnSkillTake = function(self)
  -- function num : 0_53
  (self.cskill):OnSkillTake()
end

LuaSkillBase.PlayChipEffect = function(self)
  -- function num : 0_54 , upvalues : _ENV
  if GR ~= nil then
    (self.cskill):PlayChipEffect()
    local tab = {}
    tab.belong = (GR.EnumToInt)((self.caster).belong)
    tab.skillId = (self.cskill).dataId
    MsgCenter:Broadcast(eMsgEventId.OnPlayChipEffect, tab)
  end
end

LuaSkillBase.PlayUltEffect = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_55 , upvalues : _ENV
  self.ultCv = LuaSkillCtrl:PlaySkillCv((self.caster).roleDataId)
  if (self.config).audioIdStart == nil then
    return 
  end
  self.startAudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioIdStart, function(auback)
    -- function num : 0_55_0 , upvalues : self
    if auback == self.startAudio then
      self.startAudio = nil
    end
  end
)
end

LuaSkillBase.PlayUltMovie = function(self)
  -- function num : 0_56 , upvalues : _ENV
  MsgCenter:Broadcast(eMsgEventId.OnUltSkillVideoStart)
  if (string.IsNullOrEmpty)((LuaSkillCtrl.cUltSkillCtrl).curUltMovieFileName) then
    self:OnMovieFadeOut()
    return 
  end
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "OnMovieFadeOut", 1, self.OnMovieFadeOut)
  LuaSkillCtrl:CallPlayUltMovie()
  if (self.config).audioIdMovie == nil then
    return 
  end
  self.actionAudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioIdMovie, function(auback)
    -- function num : 0_56_0 , upvalues : self
    if auback == self.actionAudio then
      self.actionAudio = nil
    end
  end
)
end

LuaSkillBase.OnMovieFadeOut = function(self)
  -- function num : 0_57 , upvalues : _ENV
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  if self:IsConsumeSkill() then
    LuaSkillCtrl:CallEndUltEffect(self.caster)
  else
    if (self.config).movieEndRoleActionId ~= nil then
      LuaSkillCtrl:CallRoleAction(self.caster, (self.config).movieEndRoleActionId)
    end
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  end
  self:OnAfterUltEffect()
end

LuaSkillBase.OnAfterUltEffect = function(self, isFromBreak)
  -- function num : 0_58 , upvalues : _ENV
  if isFromBreak and self.actionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.actionAudio)
    self.actionAudio = nil
  end
  if self.startAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.startAudio)
    self.startAudio = nil
  end
  if (self.config).audioIdEnd ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioIdEnd)
  end
  MsgCenter:Broadcast(eMsgEventId.OnUltSkillViewEnd)
end

LuaSkillBase.GetRoleMoveSpeed = function(self)
  -- function num : 0_59
  return (self.caster).moveSpeed
end

LuaSkillBase.GetRoleAttackSpeed = function(self)
  -- function num : 0_60
  return (self.caster).speed
end

LuaSkillBase.CalcAtkActionSpeed = function(self, atkInterval, atkId)
  -- function num : 0_61
  local atkTotalFrames = self:GetTotalAtkActionFrames(atkId)
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

LuaSkillBase.GetTotalAtkActionFrames = function(self, atkId)
  -- function num : 0_62 , upvalues : _ENV
  local srcId = (self.caster).resSrcId
  if srcId == 0 then
    return 0
  end
  if atkId == 1 then
    return ((ConfigData.resource_model)[srcId]).atk1_frames
  else
    if atkId == 2 then
      return ((ConfigData.resource_model)[srcId]).atk2_frames
    else
      return 0
    end
  end
end

LuaSkillBase.GetAtkTriggerFrame = function(self, atkId, atkInterval)
  -- function num : 0_63 , upvalues : _ENV
  local srcId = (self.caster).resSrcId
  if srcId == 0 then
    return 0
  end
  local atkTotalFrames = self:GetTotalAtkActionFrames(atkId)
  local triggerFrameCfg = 0
  if atkId == 1 then
    triggerFrameCfg = ((ConfigData.resource_model)[srcId]).atk1_trigger_frames
  else
    if atkId == 2 then
      triggerFrameCfg = ((ConfigData.resource_model)[srcId]).atk2_trigger_frames
    end
  end
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

LuaSkillBase.GetBehindTargetsPos = function(self, count, selectX, selectY, targetX, targetY)
  -- function num : 0_64 , upvalues : _ENV
  local coordSX, coordSY = self:__ChessBoardToCoord(selectX, selectY)
  local coordTX, coordTY = self:__ChessBoardToCoord(targetX, targetY)
  local disX = coordTX - coordSX
  local disY = coordTY - coordSY
  local targets = {}
  for i = 1, count do
    local curChkBoardX, curChkBoardY = self:__CoordToChessBoard(disX * i + coordSX, disY * i + coordSY)
    local role = (LuaSkillCtrl.battleCtrl):GetBattleRole(curChkBoardX, curChkBoardY)
    if role ~= nil and not role.isDead then
      targets[i] = role
    end
  end
  return targets
end

LuaSkillBase.__ChessBoardToCoord = function(self, x, y)
  -- function num : 0_65
  return x * 2 + y % 2, y
end

LuaSkillBase.__CoordToChessBoard = function(self, x, y)
  -- function num : 0_66
  return (x - y % 2) // 2, y
end

LuaSkillBase.CallHalo = function(self, haloBuffId, caster, target, radius, spdPerFrame, influenceType, onColiStay, effect, isDir, isArriveKill, onArrive, bindRole)
  -- function num : 0_67 , upvalues : _ENV
  self.__haloBuffId = haloBuffId
  local collisionEnter = BindCallback(self, self.__Halo_OnCollisionEnter)
  local collisionExit = BindCallback(self, self.__Halo_OnCollisionExit)
  return LuaSkillCtrl:CallCircledEmissionStraightly(self, caster, target, radius, spdPerFrame, influenceType, collisionEnter, onColiStay, collisionExit, effect, isDir, isArriveKill, onArrive, bindRole)
end

LuaSkillBase.__Halo_OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_68 , upvalues : _ENV
  if entity:GetBuffTier(self.__haloBuffId) < 1 then
    LuaSkillCtrl:CallBuff(self, entity, self.__haloBuffId, 1, nil, true)
    self:Halo_OnCollisionEnter(collider, index, entity)
  end
end

LuaSkillBase.__Halo_OnCollisionExit = function(self, collider, entity)
  -- function num : 0_69 , upvalues : _ENV
  if entity:GetBuffTier(self.__haloBuffId) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, self.__haloBuffId, 0, true)
    self:Halo_OnCollisionExit(collider, entity)
  end
end

LuaSkillBase.Halo_OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_70
end

LuaSkillBase.Halo_OnCollisionExit = function(self, collider, entity)
  -- function num : 0_71
end

LuaSkillBase.OnSkipUltView = function(self)
  -- function num : 0_72 , upvalues : _ENV
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
end

LuaSkillBase.LuaDispose = function(self)
  -- function num : 0_73 , upvalues : _ENV
  if self.ultCv ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.ultCv)
    self.ultCv = nil
  end
  self:RemoveAllBreakKillEffects()
  self:RemoveAllTimers()
  self.cskill = nil
  self.caster = nil
  self.moveSelectTarget = nil
  self.actionTrigger = nil
  self.actionAudio = nil
  self.startAudio = nil
end

return LuaSkillBase

