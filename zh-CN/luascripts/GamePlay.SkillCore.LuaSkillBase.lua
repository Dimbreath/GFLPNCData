-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaSkillBase = class("LuaSkillBase")
LuaSkillBase.ctor = function(self)
  -- function num : 0_0
  self.allEvents = {}
end

LuaSkillBase.__InitSkillInternal = function(self, cskill, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self.cskill = cskill
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
  self:InitSkill(isMidwaySkill)
end

LuaSkillBase.GetSelfBindingObj = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local binding = {}
  if self.caster == nil then
    return 
  end
  ;
  (UIUtil.LuaUIBindingTable)(((self.caster).lsObject).gameObject, binding)
  return binding
end

LuaSkillBase.AddTimer = function(self, timer)
  -- function num : 0_3 , upvalues : _ENV
  if self.timers ~= nil and timer ~= nil then
    (table.insert)(self.timers, timer)
  end
end

LuaSkillBase.RemoveTimer = function(self, timer)
  -- function num : 0_4 , upvalues : _ENV
  if self.timers ~= nil and timer ~= nil then
    (table.removebyvalue)(self.timers, timer)
  end
end

LuaSkillBase.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_5 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.OnBreakSkill, "base_breakSkill", 1, self.OnBreakSkill)
end

LuaSkillBase.OnCasterBorn = function(self)
  -- function num : 0_6
end

LuaSkillBase.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_7
  return true
end

LuaSkillBase.TakeSkillPlay = function(self, data, isUltSkill, selectTargetCoord, selectRoles)
  -- function num : 0_8 , upvalues : _ENV
  if isUltSkill then
    self.ultHmp = LuaSkillCtrl:GetUltHMp()
    self:PlayUltEffect(data, selectTargetCoord, selectRoles)
    self:RemoveTrigger(eSkillTriggerType.StartSelfUltRoleAction)
    self:AddTrigger(eSkillTriggerType.StartSelfUltRoleAction, "baseult_startaction", 1, self.OnUltRoleAction)
    self:RemoveTrigger(eSkillTriggerType.AfterSelfUltEffectEnd)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltEffectEnd, "baseult_after", 1, BindCallback(self, self.PlaySkill, data, selectTargetCoord, selectRoles))
    return true
  else
    return self:PlaySkill(data, selectTargetCoord, selectRoles)
  end
end

LuaSkillBase.OnUltRoleAction = function(self)
  -- function num : 0_9
end

LuaSkillBase.GetSelectTargetAndExecute = function(self, selectRoles, executeFunc)
  -- function num : 0_10
  if executeFunc == nil then
    return true
  end
  if selectRoles ~= nil and selectRoles.Count > 0 then
    for i = 0, selectRoles.Count - 1 do
      executeFunc(selectRoles[i])
    end
    return true
  end
  return false
end

LuaSkillBase.OnBreakSkill = function(self, role)
  -- function num : 0_11 , upvalues : _ENV
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
        if self.effects ~= nil then
          local leng = (table.length)(self.effects)
          if leng > 0 then
            for i = 1, leng do
              if (self.effects)[i] ~= nil then
                ((self.effects)[i]):Die()
                -- DECOMPILER ERROR at PC52: Confused about usage of register: R7 in 'UnsetPending'

                ;
                (self.effects)[i] = nil
              end
            end
          end
          do
            do
              self.effects = {}
              ;
              (self.caster):RemoveSkillWaitBuff()
            end
          end
        end
      end
    end
  end
end

LuaSkillBase.OnCasterDie = function(self)
  -- function num : 0_12
  self:RemoveThisAllTrigger()
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
end

LuaSkillBase.RemoveAllTimers = function(self)
  -- function num : 0_13 , upvalues : _ENV
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
  -- function num : 0_14 , upvalues : _ENV
  if self.effects == nil then
    return 
  end
  local leng = (table.length)(self.effects)
  if leng > 0 then
    for i = 1, leng do
      if (self.effects)[i] ~= nil then
        ((self.effects)[i]):Die()
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.effects)[i] = nil
      end
    end
  end
  do
    self.effects = {}
  end
end

LuaSkillBase.BreakSkill = function(self)
  -- function num : 0_15 , upvalues : _ENV
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  LuaSkillCtrl:CallResetComAtkCDRatioForRole(self.caster, 100)
  LuaSkillCtrl:BreakCurrentAction(self.caster)
end

LuaSkillBase.OnSkillRemove = function(self)
  -- function num : 0_16
  self:RemoveThisAllTrigger()
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  self:RemoveAllLuaTrigger()
end

LuaSkillBase.AddTrigger = function(self, triggerType, name, priority, eventFunc)
  -- function num : 0_17 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTrigger(triggerType, self.cskill, name, priority, bindFunc)
end

LuaSkillBase.RemoveTrigger = function(self, triggerType)
  -- function num : 0_18 , upvalues : _ENV
  LuaSkillCtrl:RemoveTrigger(self, triggerType)
end

LuaSkillBase.RemoveThisAllTrigger = function(self)
  -- function num : 0_19 , upvalues : _ENV
  LuaSkillCtrl:RemoveSkillAllTrigger(self.cskill)
end

LuaSkillBase.AddLuaTrigger = function(self, luaTriggerId, action)
  -- function num : 0_20 , upvalues : _ENV
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
  -- function num : 0_21 , upvalues : _ENV
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
  -- function num : 0_22 , upvalues : _ENV
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
  -- function num : 0_23 , upvalues : _ENV
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
  -- function num : 0_24 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, id)
end

LuaSkillBase.CallCasterWait = function(self, duration)
  -- function num : 0_25
  (self.caster):AddSkillWaitBuff(duration)
end

LuaSkillBase.CancleCasterWait = function(self)
  -- function num : 0_26
  (self.caster):RemoveSkillWaitBuff()
end

LuaSkillBase.CallCasterLookAt = function(self, targetList)
  -- function num : 0_27
  if targetList.Count > 0 then
    (self.caster):LookAtTarget(targetList[0])
  end
end

LuaSkillBase.IsReadyToTake = function(self)
  -- function num : 0_28
  return (self.cskill):IsReadyToTake()
end

LuaSkillBase.OnSkillTake = function(self)
  -- function num : 0_29
  (self.cskill):OnSkillTake()
end

LuaSkillBase.PlayChipEffect = function(self)
  -- function num : 0_30 , upvalues : _ENV
  (self.cskill):PlayChipEffect()
  local tab = {}
  tab.belong = (GR.EnumToInt)((self.caster).belong)
  tab.skillId = (self.cskill).dataId
  MsgCenter:Broadcast(eMsgEventId.OnPlayChipEffect, tab)
end

LuaSkillBase.PlayUltEffect = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_31
  self:PlaySkill(data, selectTargetCoord, selectRoles)
end

LuaSkillBase.GetRoleMoveSpeed = function(self)
  -- function num : 0_32
  return (self.caster).moveSpeed
end

LuaSkillBase.GetRoleAttackSpeed = function(self)
  -- function num : 0_33
  return (self.caster).speed
end

LuaSkillBase.CalcAtkActionSpeed = function(self, atkInterval, atkId)
  -- function num : 0_34
  local atkTotalFrames = self:GetTotalAtkActionFrames(atkId)
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

LuaSkillBase.GetTotalAtkActionFrames = function(self, atkId)
  -- function num : 0_35 , upvalues : _ENV
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
  -- function num : 0_36 , upvalues : _ENV
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
  -- function num : 0_37 , upvalues : _ENV
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
  -- function num : 0_38
  return x * 2 + y % 2, y
end

LuaSkillBase.__CoordToChessBoard = function(self, x, y)
  -- function num : 0_39
  return (x - y % 2) // 2, y
end

return LuaSkillBase

