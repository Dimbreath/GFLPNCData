local LuaSkillCtrl = class("LuaSkillCtrl")
local SkillLogicTimerCtrl = require("GamePlay.LogicTime.SkillLogicTimerCtrl")
local DynEffectGrid = require("Game.Exploration.Data.DynEffectGrid")
local SortedMessenger = require("Framework.Common.SortedMessenger")
local cs_RangFunc = (CS.RandomUtility).Range
LuaSkillCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : SkillLogicTimerCtrl
  self.logicTimerCtrl = (SkillLogicTimerCtrl.New)()
  self.IsInVerify = false
end

LuaSkillCtrl.InitSkillCtrl = function(self, battleCtrl)
  -- function num : 0_1 , upvalues : SortedMessenger
  self.battleCtrl = battleCtrl
  self.cluaSkillCtrl = battleCtrl.LuaSkillController
  self.cUltSkillCtrl = (battleCtrl.PlayerController).UltSkillHandle
  self.luaTrigger = (SortedMessenger.New)()
  self.IsInTDBattle = battleCtrl.IsInTDBattle
end

LuaSkillCtrl.AddSkillTrigger = function(self, triggerType, triggerHandle, skillType, name, priority, eventFunc, isSelf, relativeRole)
  -- function num : 0_2
  if triggerHandle == nil then
    return 
  end
  ;
  (self.cluaSkillCtrl):AddTrigger(triggerType, triggerHandle, skillType, name, priority, eventFunc, isSelf, relativeRole)
end

LuaSkillCtrl.AddSkillTriggerWithBindArg = function(self, triggerType, triggerHandle, skillType, name, priority, eventFunc, isSelf, sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, verifyId, extraArg1, extraArg2)
  -- function num : 0_3
  if triggerHandle == nil then
    return 
  end
  ;
  (self.cluaSkillCtrl):AddTrigger(triggerType, triggerHandle, skillType, name, priority, eventFunc, isSelf, sender, target, senderBelongNum or -1, targetBelongNum or -1, senderRoleType or 0, targetRoleType or 0, verifyId or 0, extraArg1 or -1, extraArg2 or -1)
end

LuaSkillCtrl.RemoveTrigger = function(self, triggerHandle, eventType)
  -- function num : 0_4
  if triggerHandle == nil then
    return 
  end
  ;
  (self.cluaSkillCtrl):RemoveTrigger(triggerHandle, eventType)
end

LuaSkillCtrl.RemoveHandleAllTrigger = function(self, triggerHandle)
  -- function num : 0_5
  if triggerHandle == nil then
    return 
  end
  ;
  (self.cluaSkillCtrl):RemoveHandleAllTrigger(triggerHandle)
end

LuaSkillCtrl.GetSkillTrigger = function(self, luaSkill, eventType)
  -- function num : 0_6
  if luaSkill.cskill == nil then
    return 
  end
  ;
  (luaSkill.cskill):GetTrigger(eventType)
end

LuaSkillCtrl.GetGridTrigger = function(self, gridSkill, eventType)
  -- function num : 0_7
  (gridSkill.cEffectGrid):GetTrigger(eventType)
end

LuaSkillCtrl.CallAfterSkillPlayTrigger = function(self, luaSkill, role)
  -- function num : 0_8
  (self.cluaSkillCtrl):OnAfterPlaySkill(luaSkill.cskill, role)
end

LuaSkillCtrl.OnUpdateLogic = function(self)
  -- function num : 0_9
  (self.logicTimerCtrl):OnUpdateLogic()
end

LuaSkillCtrl.StartTimer = function(self, luaSkill, delay, func, obj, is_loop, start_time)
  -- function num : 0_10
  local timer = (self.logicTimerCtrl):GetTimer(delay, func, obj, is_loop, start_time, luaSkill)
  if luaSkill ~= nil then
    timer:InjectLuaSkill(luaSkill)
  end
  timer:Start()
  return timer
end

LuaSkillCtrl.GetTimer = function(self, delay, func, obj, is_loop, start_time)
  -- function num : 0_11
  return ((self.logicTimerCtrl):GetTimer(delay, func, obj, is_loop, start_time)):Start()
end

LuaSkillCtrl.CallRange = function(self, min, max)
  -- function num : 0_12 , upvalues : cs_RangFunc
  return cs_RangFunc(min, max)
end

LuaSkillCtrl.CallRoleAction = function(self, role, id, speed)
  -- function num : 0_13
  if speed ~= nil then
    (self.cluaSkillCtrl):CallRoleAction(role, id, speed)
  else
    ;
    (self.cluaSkillCtrl):CallRoleAction(role, id, 1)
  end
end

LuaSkillCtrl.BreakCurrentAction = function(self, role)
  -- function num : 0_14
  (self.cluaSkillCtrl):BreakCurrentAction(role)
end

LuaSkillCtrl.CallRoleActionWithTrigger = function(self, luaSkill, role, id, speed, triggerTime, onTrigger)
  -- function num : 0_15
  if speed == nil then
    speed = 1
  end
  local timer = nil
  if luaSkill.isDoubleAttack then
    triggerTime = triggerTime // 2
    speed = speed * 2
  end
  if triggerTime > 0 then
    if not luaSkill.isCommonAttack then
      self:StartShowSkillDurationTime(luaSkill, 0)
    end
    self:RecordSkillUncompleted(luaSkill)
    luaSkill:InjectActionTrigger(onTrigger)
    timer = self:StartTimer(luaSkill, triggerTime, luaSkill.TakeActionTrigger, luaSkill)
  else
    onTrigger()
  end
  ;
  (self.cluaSkillCtrl):CallRoleAction(role, id, speed)
  return timer
end

LuaSkillCtrl.GetSkillBindBuffId = function(self, luaSkill)
  -- function num : 0_16
  return (luaSkill.cskill).parentBuffId
end

LuaSkillCtrl.CallBuff = function(self, luaSkill, role, buffId, buffTier, duration, isIgnoreTrigger, overridSender)
  -- function num : 0_17 , upvalues : _ENV
  if role == nil or role.hp <= 0 and role.roleType ~= eBattleRoleType.skillCaster then
    return 
  end
  if luaSkill == nil or luaSkill.cskill == nil then
    error("error to add buff id:" .. tostring(buffId))
    return 
  end
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  if duration == nil then
    return (self.cluaSkillCtrl):CallBuff(luaSkill.cskill, role, buffId, buffTier, isIgnoreTrigger, overridSender)
  else
    return (self.cluaSkillCtrl):CallTimeBuff(luaSkill.cskill, role, buffId, buffTier, duration, isIgnoreTrigger, overridSender)
  end
end

LuaSkillCtrl.CallBuffWithOriginSkill = function(self, cSkill, role, buffId, buffTier, duration)
  -- function num : 0_18
  if duration == nil then
    return (self.cluaSkillCtrl):CallBuff(cSkill, role, buffId, buffTier)
  else
    return (self.cluaSkillCtrl):CallTimeBuff(cSkill, role, buffId, buffTier, duration)
  end
end

LuaSkillCtrl.CallBuffRepeated = function(self, luaSkill, role, buffId, buffTier, duration, isIgnoreTrigger, onRepeated, ...)
  -- function num : 0_19 , upvalues : _ENV
  if role == nil or role.hp <= 0 and role.roleType ~= eBattleRoleType.skillCaster then
    return 
  end
  local repeatedFun = nil
  if onRepeated ~= nil then
    repeatedFun = BindCallback(luaSkill, onRepeated, ...)
  end
  if not isIgnoreTrigger then
    do return (self.cluaSkillCtrl):CallBuffRepeated(luaSkill.cskill, role, buffId, buffTier, repeatedFun, duration ~= nil or false) end
    do return (self.cluaSkillCtrl):CallTimeBuffRepeated(luaSkill.cskill, role, buffId, buffTier, duration, repeatedFun, isIgnoreTrigger or false) end
  end
end

LuaSkillCtrl.CallBuffLifeEvent = function(self, luaSkill, role, buffId, buffTier, duration, lifeEvent, isIgnoreTrigger)
  -- function num : 0_20 , upvalues : _ENV
  if role == nil or role.hp <= 0 and role.roleType ~= eBattleRoleType.skillCaster then
    return 
  end
  local battleBuff = nil
  if duration == nil then
    battleBuff = (self.cluaSkillCtrl):GenBuff(luaSkill.cskill, role, buffId, buffTier)
  else
    battleBuff = (self.cluaSkillCtrl):GenTimeBuff(luaSkill.cskill, role, buffId, buffTier, duration)
  end
  if battleBuff == nil then
    return nil
  end
  battleBuff:BindBuffLifeEvent(lifeEvent)
  ;
  (self.cluaSkillCtrl):AddBattleBuff(role, battleBuff, isIgnoreTrigger or false)
  return battleBuff
end

LuaSkillCtrl.DispelBuff = function(self, role, buffId, buffTier, isIgnoreTrigger, isIgnoreAudio)
  -- function num : 0_21
  ;
  (self.cluaSkillCtrl):DispelBuff(role, buffId, buffTier, isIgnoreTrigger or false, isIgnoreAudio or false)
end

LuaSkillCtrl.DispelBuffByMaker = function(self, buffMaker, role, buffId, buffTier, isIgnoreTrigger, isIgnoreAudio)
  -- function num : 0_22
  ;
  (self.cluaSkillCtrl):DispelBuffByMaker(buffMaker, role, buffId, buffTier, isIgnoreTrigger or false, isIgnoreAudio or false)
end

LuaSkillCtrl.GetRoleBuffs = function(self, role)
  -- function num : 0_23
  return (self.cluaSkillCtrl):GetRoleBuffs(role)
end

LuaSkillCtrl.GetRoleBuffById = function(self, role, buffId)
  -- function num : 0_24
  return role:GetRoleBuffById(buffId)
end

LuaSkillCtrl.GetRoleAllBuffsByFeature = function(self, role, buffFeature)
  -- function num : 0_25
  return role:GetAllBuffsByFeature(buffFeature)
end

LuaSkillCtrl.RoleContainsBuffFeature = function(self, role, buffFeature)
  -- function num : 0_26
  return (self.cluaSkillCtrl):RoleContainsBuffFeature(role, buffFeature)
end

LuaSkillCtrl.RoleContainsCtrlBuff = function(self, role)
  -- function num : 0_27 , upvalues : _ENV
  local buffMgr = role:GetBuffComponent()
  if buffMgr == nil then
    return false
  end
  local buffs = buffMgr._buffs
  if buffs == nil or buffs.Count <= 0 then
    return false
  end
  for k,v in pairs(buffs) do
    if (v.buffCfg).IsControl then
      return true
    end
  end
  return false
end

LuaSkillCtrl.CallTargetSelect = function(self, luaSkill, targetSelectId, rangeOffset, overrideSelf, CareerConditionLag)
  -- function num : 0_28 , upvalues : _ENV
  if overrideSelf == nill then
    overrideSelf = luaSkill.caster
  end
  return (self.cluaSkillCtrl):CallTargetSelect(luaSkill.cskill, overrideSelf, targetSelectId, rangeOffset or 0, CareerConditionLag or false)
end

LuaSkillCtrl.CallTargetSelectWithRange = function(self, luaSkill, targetSelectId, range, overrideSelf, CareerConditionLag)
  -- function num : 0_29 , upvalues : _ENV
  if overrideSelf == nill then
    overrideSelf = luaSkill.caster
  end
  return (self.cluaSkillCtrl):CallTargetSelectWithRange(luaSkill.cskill, overrideSelf, targetSelectId, range or 0, CareerConditionLag or false)
end

LuaSkillCtrl.CallTargetSelectWithCskill = function(self, cskill, targetSelectId, rangeOffset, caster)
  -- function num : 0_30
  return (self.cluaSkillCtrl):CallTargetSelect(cskill, caster, targetSelectId, rangeOffset or 0)
end

LuaSkillCtrl.CallRightMaxDirEnemy = function(self, role, ignoreNeutral, ignoreCrtlImmunity)
  -- function num : 0_31
  if ignoreNeutral == nil then
    ignoreNeutral = true
  end
  if ignoreCrtlImmunity == nil then
    ignoreCrtlImmunity = true
  end
  return (self.cluaSkillCtrl):CallRightMaxDirEnemy(role, ignoreNeutral, ignoreCrtlImmunity)
end

LuaSkillCtrl.GetSelectTeamRoles = function(self, belongNum)
  -- function num : 0_32 , upvalues : _ENV
  if belongNum == eBattleRoleBelong.player then
    return ((self.battleCtrl).PlayerTeamController).battleRoleList
  else
    if belongNum == eBattleRoleBelong.enemy then
      return ((self.battleCtrl).EnemyTeamController).battleRoleList
    else
      if belongNum == eBattleRoleBelong.neutral then
        return ((self.battleCtrl).NeutralTeamController).battleRoleList
      end
    end
  end
  return nil
end

LuaSkillCtrl.CallEffect = function(self, target, effectId, luaSkill, func, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  -- function num : 0_33 , upvalues : _ENV
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  if func ~= nil then
    return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func), overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  else
    return self:CallEffectInCs(target, luaSkill, effectId, nil, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  end
end

LuaSkillCtrl.CallEffectWithEmission = function(self, emission, effectId, luaSkill, func, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  -- function num : 0_34 , upvalues : _ENV
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  if func ~= nil then
    return self:CallEffectWithEmissionInCs(emission, luaSkill, effectId, BindCallback(luaSkill, func), overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  else
    return self:CallEffectWithEmissionInCs(emission, luaSkill, effectId, nil, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  end
end

LuaSkillCtrl.CallEffectWithArg = function(self, target, effectId, luaSkill, isBreakKill, isIgnoreHideInUlt, func, ...)
  -- function num : 0_35 , upvalues : _ENV
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  return self:CallEffectInCs(target, luaSkill, effectId, (BindCallback(luaSkill, func, ...)), nil, 1, isBreakKill, isIgnoreHideInUlt)
end

LuaSkillCtrl.CallEffectWithArgAndSpeed = function(self, target, effectId, luaSkill, speed, isBreakKill, isIgnoreHideInUlt, func, ...)
  -- function num : 0_36 , upvalues : _ENV
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  return self:CallEffectInCs(target, luaSkill, effectId, (BindCallback(luaSkill, func, ...)), nil, speed, isBreakKill, isIgnoreHideInUlt)
end

LuaSkillCtrl.CallEffectWithArgOverride = function(self, target, effectId, luaSkill, overrideSelf, isBreakKill, isIgnoreHideInUlt, func, ...)
  -- function num : 0_37 , upvalues : _ENV
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func, ...), overrideSelf, nil, isBreakKill, isIgnoreHideInUlt)
end

LuaSkillCtrl.CallEffectWithArgAndSpeedOverride = function(self, target, effectId, luaSkill, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt, func, ...)
  -- function num : 0_38 , upvalues : _ENV
  if isBreakKill == nil then
    isBreakKill = false
  end
  if isIgnoreHideInUlt == nil then
    isIgnoreHideInUlt = false
  end
  return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func, ...), overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
end

LuaSkillCtrl.GetTargetWithGrid = function(self, gridX, gridY)
  -- function num : 0_39
  return (self.cluaSkillCtrl):GetTargetWithGrid(gridX, gridY)
end

LuaSkillCtrl.GetGridWithRole = function(self, role)
  -- function num : 0_40 , upvalues : _ENV
  if role == nil then
    error("GetGridWithRole::传入的角色为空，请检查")
    return 
  end
  return (self.cluaSkillCtrl):GetGridWithRole(role)
end

LuaSkillCtrl.GetGridWithPos = function(self, x, y)
  -- function num : 0_41
  return (self.cluaSkillCtrl):GetGridWithPos(x, y)
end

LuaSkillCtrl.GetRoleWithPos = function(self, x, y)
  -- function num : 0_42
  return (self.cluaSkillCtrl):GetRoleWithPos(x, y)
end

LuaSkillCtrl.CallEffectInCs = function(self, target, luaSkill, effectId, bindCallBack, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  -- function num : 0_43 , upvalues : _ENV
  if target == nil then
    return nil
  end
  if speed == nil then
    speed = 1
  end
  local effect = (self.cluaSkillCtrl):CallEffect(target, luaSkill.cskill, effectId, bindCallBack, overrideSelf, speed, isIgnoreHideInUlt)
  if luaSkill.effects ~= nil and effect ~= nil and isBreakKill then
    (table.insert)(luaSkill.effects, effect)
  end
  return effect
end

LuaSkillCtrl.CallEffectWithEmissionInCs = function(self, emission, luaSkill, effectId, bindCallBack, overrideSelf, speed, isBreakKill, isIgnoreHideInUlt)
  -- function num : 0_44 , upvalues : _ENV
  if emission == nil then
    return nil
  end
  if speed == nil then
    speed = 1
  end
  local effect = (self.cluaSkillCtrl):CallEffectWithEmission(emission, luaSkill.cskill, effectId, bindCallBack, overrideSelf, speed, isIgnoreHideInUlt)
  if isBreakKill then
    (table.insert)(luaSkill.effects, effect)
  end
  return effect
end

LuaSkillCtrl.CallAddCircleColliderForEffect = function(self, effect, radius, influenceType, onCollisionStay, onCollisionEnter, onCollisionExit)
  -- function num : 0_45
  return (self.cluaSkillCtrl):CallAddCircleColliderForEffect(effect, radius, influenceType, onCollisionStay, onCollisionEnter, onCollisionExit)
end

LuaSkillCtrl.SetCircleColliderAndEffectRadius = function(self, circleCollider, radius, effect)
  -- function num : 0_46
  (self.cluaSkillCtrl):SetCircleColliderAndEffectRadius(circleCollider, radius, effect)
end

LuaSkillCtrl.ClearColliderOrEmission = function(self, collider)
  -- function num : 0_47
  (self.cluaSkillCtrl):ClearColliderOrEmission(collider)
end

LuaSkillCtrl.CallSelectTargetEffect = function(self, luaSkill, targetRole)
  -- function num : 0_48
  return (self.cluaSkillCtrl):CallSelectTargetEffect((luaSkill.cskill).maker, targetRole)
end

LuaSkillCtrl.CallRealDamage = function(self, luaSkill, target, effect, config, configArg, isTriggerSet, isIgnoreTrigger)
  -- function num : 0_49 , upvalues : _ENV
  local skillResult = nil
  if effect ~= nil then
    skillResult = self:CallSkillResult(effect, target)
  else
    skillResult = self:CallSkillResultNoEffect(luaSkill, target)
  end
  if skillResult == nil then
    return 
  end
  if config == nil then
    config = realDamageConfig
  end
  if config ~= realDamageConfig then
    setmetatable(config, metaRealDamageConfig)
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  skillResult:HurtResult(config, configArg, isIgnoreTrigger or false)
  skillResult:EndResult()
end

LuaSkillCtrl.RemoveLife = function(self, hurt, luaSkill, target, isTriggerSet, buff, isShowText, isIgnoreTrigger, hurtType, ignoreShield)
  -- function num : 0_50
  if isShowText == nil then
    isShowText = true
  end
  if hurtType == nil then
    hurtType = ((luaSkill.cskill).skillCfg).HurtType
  end
  return (self.battleCtrl):SetRoleHurt(hurt, luaSkill.cskill, hurtType, luaSkill.caster, target, false, false, isTriggerSet or false, buff, isShowText, isIgnoreTrigger or false, -1, ignoreShield or false)
end

LuaSkillCtrl.RemoveLifeWithCSkill = function(self, hurt, cskill, target, isTriggerSet, buff, isShowText, isIgnoreTrigger, hurtType, ignoreShield)
  -- function num : 0_51
  if isShowText == nil then
    isShowText = true
  end
  if hurtType == nil then
    hurtType = (cskill.skillCfg).HurtType
  end
  return (self.battleCtrl):SetRoleHurt(hurt, cskill, hurtType, cskill.maker, target, false, false, isTriggerSet or false, buff, isShowText, isIgnoreTrigger or false, nil, nil, ignoreShield or false)
end

LuaSkillCtrl.CallHeal = function(self, heal, luaSkill, target, isIgnoreTrigger)
  -- function num : 0_52
  return (self.battleCtrl):SetRoleHeal(heal, luaSkill.cskill, luaSkill.caster, target, false, nil, false, isIgnoreTrigger or false)
end

LuaSkillCtrl.CallHealWithCSkill = function(self, heal, cskill, target, isIgnoreTrigger)
  -- function num : 0_53
  return (self.battleCtrl):SetRoleHeal(heal, cskill, cskill.maker, target, false, nil, false, isIgnoreTrigger or false)
end

LuaSkillCtrl.CallFloatText = function(self, role, floatTextId, damage, skillHurtType)
  -- function num : 0_54 , upvalues : _ENV
  if not skillHurtType then
    skillHurtType = eHurtType.None
  end
  if damage == nil then
    (self.cluaSkillCtrl):CallFloatText(role, floatTextId, skillHurtType)
  else
    ;
    (self.cluaSkillCtrl):CallFloatText(role, floatTextId, skillHurtType, damage)
  end
end

LuaSkillCtrl.AddRoleShield = function(self, role, shieldType, shieldValue, formulaId)
  -- function num : 0_55
  role:AddShield(shieldValue, shieldType, formulaId)
end

LuaSkillCtrl.GetShield = function(self, role, shieldType)
  -- function num : 0_56
  return role:GetShield(shieldType)
end

LuaSkillCtrl.ClearShield = function(self, role, shieldType)
  -- function num : 0_57
  role:ClearShield(shieldType)
end

LuaSkillCtrl.ClearAllShield = function(self, role)
  -- function num : 0_58
  role:ClearAllShield()
end

LuaSkillCtrl.CallSkillResult = function(self, effect, target, config)
  -- function num : 0_59 , upvalues : _ENV
  if config ~= nil and config.effect_shape ~= nil and config.effect_shape == eSkillResultShapeType.CellDist then
    config.effect_shape = eSkillResultShapeType.Block
  end
  return (self.cluaSkillCtrl):GetSkillResult(effect, target, config)
end

LuaSkillCtrl.CallSkillResultNoEffect = function(self, luaSkill, target, config)
  -- function num : 0_60 , upvalues : _ENV
  if config ~= nil and config.effect_shape ~= nil and config.effect_shape == eSkillResultShapeType.CellDist then
    config.effect_shape = eSkillResultShapeType.Block
  end
  return (self.cluaSkillCtrl):GetSkillResultNoEffect(luaSkill.cskill, target, config)
end

LuaSkillCtrl.CallSkillResultNoEffectWithCSkill = function(self, cskill, target, config)
  -- function num : 0_61 , upvalues : _ENV
  if config ~= nil and config.effect_shape ~= nil and config.effect_shape == eSkillResultShapeType.CellDist then
    config.effect_shape = eSkillResultShapeType.Block
  end
  return (self.cluaSkillCtrl):GetSkillResultNoEffect(cskill, target, config)
end

LuaSkillCtrl.HurtResult = function(self, luaSkill, skillResult, config, configArg, isTriggerSet, isIgnoreTrigger)
  -- function num : 0_62 , upvalues : _ENV
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  if (luaSkill.caster).isRealDmgForAtack and (luaSkill.cskill).isCommonAttack then
    if config == nil then
      config = realDamageConfig
    end
    if config ~= realDamageConfig then
      config = self:ModifyRealDmgConfig(config)
    end
  else
    if config == nil then
      config = generalHurtConfig
    end
    if config ~= generalHurtConfig then
      setmetatable(config, metaGeneralHurtConfig)
    end
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  skillResult:HurtResult(config, configArg, isIgnoreTrigger)
  config.isTriggerSet = false
  setmetatable(config, nil)
end

LuaSkillCtrl.ModifyRealDmgConfig = function(self, config)
  -- function num : 0_63 , upvalues : _ENV
  if ((((config.basehurt_formula or not config.minhurt_formula) and config.correct_formula) or not config.lifesteal_formula) and config.spell_lifesteal_formula) or not config.returndamage_formula then
    local realDmgConfig = {hit_formula = 0, def_formula = 0, basehurt_formula = realDamageConfig.basehurt_formula, minhurt_formula = realDamageConfig.minhurt_formula, crit_formula = 0, crithur_ratio = 0, correct_formula = realDamageConfig.correct_formula, lifesteal_formula = realDamageConfig.lifesteal_formula, spell_lifesteal_formula = realDamageConfig.spell_lifesteal_formula, returndamage_formula = realDamageConfig.returndamage_formula, hurt_type = eHurtType.RealDmg}
    return realDmgConfig
  end
end

LuaSkillCtrl.HealResult = function(self, skillResult, config, configArg, isTriggerSet, isIgnoreTrigger)
  -- function num : 0_64 , upvalues : _ENV
  if config == nil then
    config = generalHealConfig
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  if config ~= generalHealConfig then
    setmetatable(config, {__index = generalHealConfig})
  end
  skillResult:HealResult(config, configArg, isIgnoreTrigger or false)
end

LuaSkillCtrl.CallNewSkill = function(self, skillId, skillLevel, skillType, itemId)
  -- function num : 0_65
  return (self.cluaSkillCtrl):CallNewSkill(skillId, skillLevel or 1, skillType or 0, itemId or 0)
end

LuaSkillCtrl.CallFormulaNumber = function(self, formual, role, targetRole, ...)
  -- function num : 0_66 , upvalues : _ENV
  return (self.cluaSkillCtrl):CallFormulaNumber(formual, role, targetRole, (table.unpack)({...}))
end

LuaSkillCtrl.CallFormulaBool = function(self, formual, role, target, ...)
  -- function num : 0_67 , upvalues : _ENV
  return (self.cluaSkillCtrl):CallFormulaBool(formual, role, target, (table.unpack)({...}))
end

LuaSkillCtrl.CallFormulaNumberWithSkill = function(self, formual, role, target, luaSkill, ...)
  -- function num : 0_68 , upvalues : _ENV
  return (self.cluaSkillCtrl):CallFormulaNumberWithSkill(formual, role, target, luaSkill.cskill, (table.unpack)({...}))
end

LuaSkillCtrl.CallFormulaBoolWithSkill = function(self, formual, role, target, luaSkill, ...)
  -- function num : 0_69 , upvalues : _ENV
  return (self.cluaSkillCtrl):CallFormulaBoolWithSkill(formual, role, target, luaSkill.cskill, (table.unpack)({...}))
end

LuaSkillCtrl.CallReFillSkillCd = function(self, cskill)
  -- function num : 0_70
  (self.cluaSkillCtrl):CallReFillSkillCd(cskill)
end

LuaSkillCtrl.CallReFillMainSkillCdForRole = function(self, role)
  -- function num : 0_71
  (self.cluaSkillCtrl):CallReFillMainSkillCdForRole(role)
end

LuaSkillCtrl.CallResetCDForSingleSkill = function(self, battleSkill, offset)
  -- function num : 0_72
  battleSkill:ResetCDTimeOffsetNum(offset)
end

LuaSkillCtrl.CallResetCDRatioForRole = function(self, role, ofsPercent)
  -- function num : 0_73
  (self.cluaSkillCtrl):CallResetCDRatioForRole(role, ofsPercent)
end

LuaSkillCtrl.CallResetCDNumForRole = function(self, role, offset)
  -- function num : 0_74
  (self.cluaSkillCtrl):CallResetCDNumForRole(role, offset)
end

LuaSkillCtrl.CallResetComAtkCDRatioForRole = function(self, role, ratio)
  -- function num : 0_75
  (self.cluaSkillCtrl):CallResetComAtkCDRatioForRole(role, ratio)
end

LuaSkillCtrl.CallResetCDForTeam = function(self, belongNum, ofsPercent)
  -- function num : 0_76
  (self.cluaSkillCtrl):CallResetCDForTeam(belongNum, ofsPercent)
end

LuaSkillCtrl.CallResetCDForTeamSingleSkill = function(self, belongNum, luaSkill, ofsPercent)
  -- function num : 0_77
  (self.cluaSkillCtrl):CallResetCDForTeamSingleSkill(belongNum, (luaSkill.cskill).dataId, ofsPercent)
end

LuaSkillCtrl.CallResetMainSkillCDRatioForTeam = function(self, belongNum, ofsPercent)
  -- function num : 0_78
  (self.cluaSkillCtrl):CallResetMainSkillCDForTeam(belongNum, ofsPercent)
end

LuaSkillCtrl.CallResetMainSkillCDNumForTeam = function(self, belongNum, offset)
  -- function num : 0_79
  (self.cluaSkillCtrl):CallResetMainSkillCDNumForTeam(belongNum, offset)
end

LuaSkillCtrl.SetResetCdByReturnConfigOnce = function(self, luaSkill)
  -- function num : 0_80
  (luaSkill.cskill):SetResetCdByReturnConfigOnce()
end

LuaSkillCtrl.CallBreakAllSkill = function(self, role)
  -- function num : 0_81
  (self.cluaSkillCtrl):CallBreakAllLuaSkill(role)
end

LuaSkillCtrl.RecordSkillCompleted = function(self, luaSkill)
  -- function num : 0_82
  luaSkill.isSkillUncompleted = false
end

LuaSkillCtrl.RecordSkillUncompleted = function(self, luaSkill)
  -- function num : 0_83
  luaSkill.isSkillUncompleted = true
end

LuaSkillCtrl.GetRoleCommonAttack = function(self, role)
  -- function num : 0_84
  return role:GetCommonAttack()
end

LuaSkillCtrl.GetRoleComAtkSkillMoveSelectTarget = function(self, role)
  -- function num : 0_85
  local csAtkSkill = role:GetCommonAttack()
  if csAtkSkill == nil then
    return nil
  end
  return csAtkSkill.moveSelectTarget
end

LuaSkillCtrl.IsAbleAttackTarget = function(self, role, target, attack_range)
  -- function num : 0_86
  return (self.cluaSkillCtrl):IsAbleAttackTarget(role, target, attack_range)
end

LuaSkillCtrl.IsAbleAttackTargetWithDir = function(self, role, targetRole, atk_range, dir_range)
  -- function num : 0_87
  return (self.cluaSkillCtrl):IsAbleAttackTargetWithDir(role, targetRole, atk_range, dir_range)
end

LuaSkillCtrl.IsAbleAttackCheckExcludedDir = function(self, role, targetRole, dir_range)
  -- function num : 0_88
  return (self.cluaSkillCtrl):IsAbleAttackCheckExcludedDir(role, targetRole, dir_range)
end

LuaSkillCtrl.IsWorthAttacking = function(self, luaSkill, role)
  -- function num : 0_89 , upvalues : _ENV
  local onFireRole = (luaSkill.caster):TryToGetFocusFiringRole()
  if onFireRole == role then
    return true
  end
  if role:ContainBuffFeature(eBuffFeatureType.Bewitch) then
    if (self.battleCtrl):IsAllMemberBewitched(role.belong) then
      return true
    else
      return false
    end
  end
  return true
end

LuaSkillCtrl.CreateSummoner = function(self, luaSkill, monsterId, coordx, coordy, belongNum)
  -- function num : 0_90
  return (self.cluaSkillCtrl):CreateSummoner(luaSkill.cskill, monsterId, coordx, coordy, belongNum or -1)
end

LuaSkillCtrl.AddSummonerRole = function(self, summoner)
  -- function num : 0_91
  return (self.cluaSkillCtrl):AddSummonerRole(summoner)
end

LuaSkillCtrl.CallFocusTimeLine = function(self, role)
  -- function num : 0_92
  (self.cUltSkillCtrl):PlayFocusTimeLine(role)
end

LuaSkillCtrl.CallBackViewTimeLine = function(self, role, isEndUltEffect)
  -- function num : 0_93
  (self.cUltSkillCtrl):PlayBackViewTimeLine(role, isEndUltEffect)
end

LuaSkillCtrl.CallSpecViewTimeLine = function(self, role)
  -- function num : 0_94
  (self.cUltSkillCtrl):PlaySpecViewTimeLine(role)
end

LuaSkillCtrl.CallEndUltEffect = function(self, role)
  -- function num : 0_95
  (self.cUltSkillCtrl):EndUltEffect(role)
end

LuaSkillCtrl.EndUltEffectAndUnFreeze = function(self)
  -- function num : 0_96
  (self.battleCtrl):SetUltSkillUnFreeze()
end

LuaSkillCtrl.CallPlayUltMovie = function(self)
  -- function num : 0_97
  if self.cUltSkillCtrl ~= nil then
    (self.cUltSkillCtrl):PlayUltMovie()
  end
end

LuaSkillCtrl.CallUltSkillScreenEffect = function(self, role)
  -- function num : 0_98
  if self.cUltSkillCtrl ~= nil then
    (self.cUltSkillCtrl):ScreenEffect(role)
  end
end

LuaSkillCtrl.CallBattleCamShake = function(self, level)
  -- function num : 0_99 , upvalues : _ENV
  if level == eCamShakeLevel.Light then
    (self.cluaSkillCtrl):CallBattleVcamShakeLight()
  else
    if level == eCamShakeLevel.Strong then
      (self.cluaSkillCtrl):CallBattleVcamShakeStrong()
    else
      if level == nil then
        (self.cluaSkillCtrl):CallBattleVcamShakeStrong()
      end
    end
  end
end

LuaSkillCtrl.StartTimerInUlt = function(self, luaSkill, delay, func, obj)
  -- function num : 0_100 , upvalues : _ENV
  local onDelayAction = BindCallback(luaSkill, func, obj)
  if self.IsInVerify then
    return 
  end
  ;
  (self.cUltSkillCtrl):StartTimer(delay, onDelayAction)
end

LuaSkillCtrl.GetUltHMp = function(self)
  -- function num : 0_101
  if self.cUltSkillCtrl ~= nil then
    return (self.cUltSkillCtrl):GetCurUltMp()
  end
end

LuaSkillCtrl.GetPlayerSkillCostMp = function(self, luaSkill)
  -- function num : 0_102
  return ((luaSkill.cskill).skillCfg).PlayerMpCost
end

LuaSkillCtrl.CallAddPlayerMp = function(self, value)
  -- function num : 0_103
  return (self.cluaSkillCtrl):CallAddPlayerMp(value)
end

LuaSkillCtrl.CallAddPlayerMpWithSkillCost = function(self, luaSkill)
  -- function num : 0_104
  local value = ((luaSkill.cskill).skillCfg).PlayerMpCost
  return self:CallAddPlayerMp(value)
end

LuaSkillCtrl.RegisterRoleHpCostEvent = function(self, luaSkill, realRoleEntity, config, action, isOnce)
  -- function num : 0_105 , upvalues : _ENV
  if action == nil then
    return 
  end
  local cb = BindCallback(luaSkill, action)
  ;
  (self.cluaSkillCtrl):RegisterRoleHpCostEvent(realRoleEntity, config, cb, isOnce)
end

LuaSkillCtrl.CallCircledEmissionStraightly = function(self, luaSkill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, isDir, isArriveKill, onArrive, bindRole)
  -- function num : 0_106
  return (self.cluaSkillCtrl):CallCircledEmissionStraightly(luaSkill.cskill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, isDir, isArriveKill, onArrive)
end

LuaSkillCtrl.CallCircledEmissionStraightlyWithThreeExtraChild = function(self, luaSkill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, subAngle, isDir, isArriveKill, onArrive, bindRole)
  -- function num : 0_107
  (self.cluaSkillCtrl):CallCircledEmissionStraightlyWithThreeExtraChild(luaSkill.cskill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, subAngle, isDir, isArriveKill, onArrive)
end

LuaSkillCtrl.CallSectorEmissionStraightly = function(self, luaSkill, caster, target, radius, arcAngle, arcAngleRange, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, isDir, isArriveKill, onArrive, bindRole)
  -- function num : 0_108
  return (self.cluaSkillCtrl):CallSectorEmissionStraightly(luaSkill.cskill, caster, target, radius, arcAngle, arcAngleRange, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, isDir, isArriveKill, onArrive)
end

LuaSkillCtrl.CallRestartEmit = function(self, luaSkill, skillEmission, speed, target, isToBorder, isArriveKill, onArrive)
  -- function num : 0_109
  if isToBorder then
    return skillEmission:ReStartEmitToBorder(self.battleCtrl, speed, skillEmission.skill, target, isArriveKill, onArrive)
  else
    return skillEmission:ReStartEmit(speed, luaSkill.skill, target, isArriveKill, onArrive)
  end
end

LuaSkillCtrl.CallGetCircleSkillCollider = function(self, luaSkill, radius, influenceType, onEnter, onStay, onExit)
  -- function num : 0_110
  return (self.cluaSkillCtrl):CallGetCircleSkillCollider(luaSkill.caster, radius, influenceType, onEnter, onStay, onExit)
end

LuaSkillCtrl.CallGetSectorSkillCollider = function(self, luaSkill, radius, arcAngle, arcAngleRange, influenceType, onEnter, onStay, onExit)
  -- function num : 0_111
  return (self.cluaSkillCtrl):CallGetSectorSkillCollider(luaSkill.caster, radius, arcAngle, arcAngleRange, influenceType, onEnter, onStay, onExit)
end

LuaSkillCtrl.CallGetRectSkillCollider = function(self, luaSkill, startTarget, halfWidth, halfHeight, dstTarget, influenceType, onEnter, onStay, onExit)
  -- function num : 0_112
  return (self.cluaSkillCtrl):CallGetRectSkillCollider(luaSkill.caster, startTarget, halfWidth, halfHeight, dstTarget, influenceType, onEnter, onStay, onExit)
end

LuaSkillCtrl.GetOnCollisionRole = function(self, collider)
  -- function num : 0_113
  return (self.cluaSkillCtrl):GetOnCollisionRole(collider)
end

LuaSkillCtrl.CallGetRoleCurDir = function(self, role)
  -- function num : 0_114
  return role:GetRoleForwardAngle()
end

LuaSkillCtrl.CallStartLocalScale = function(self, role, scale, duration)
  -- function num : 0_115
  if (role.lsObject).gameObject ~= nil then
    (role.lsObject):StartLocalScale(scale, duration)
  end
end

LuaSkillCtrl.CallAddRoleProperty = function(self, role, attrName, value, attrType)
  -- function num : 0_116
  role:AddRoleProperty(attrName, value, attrType)
end

LuaSkillCtrl.FindEmptyGrid = function(self, ruleFunc)
  -- function num : 0_117
  return (self.cluaSkillCtrl):CallFindEmptyGrid(ruleFunc)
end

LuaSkillCtrl.FindEmptyGridWithinRange = function(self, role, range)
  -- function num : 0_118
  return (self.cluaSkillCtrl):CallFindEmptyGridWithinRange(role, range)
end

LuaSkillCtrl.FindEmptyGridsWithinRange = function(self, x, y, range, isFurthest)
  -- function num : 0_119
  return (self.cluaSkillCtrl):CallFindEmptyGridsWithinRange(x, y, range, isFurthest)
end

LuaSkillCtrl.FindAllRolesWithinRange = function(self, target, range, isIncludeSelf)
  -- function num : 0_120
  return (self.cluaSkillCtrl):FindAllRolesWithinRange(target, range, isIncludeSelf)
end

LuaSkillCtrl.FindAllGridsWithinRange = function(self, target, range, isIncludeSelf)
  -- function num : 0_121
  return (self.cluaSkillCtrl):FindAllGridsWithinRange(target, range, isIncludeSelf)
end

LuaSkillCtrl.FindEmptyGridAroundRole = function(self, role)
  -- function num : 0_122
  return (self.cluaSkillCtrl):CallFindEmptyGridAroundRole(role)
end

LuaSkillCtrl.FindEmptyGridWithoutEfcGridAroundRole = function(self, role)
  -- function num : 0_123
  return (self.cluaSkillCtrl):CallFindEmptyGridWithoutEfcGridAroundRole(role)
end

LuaSkillCtrl.FindEmptyGridWithoutEfcGridOfTypeAroundRole = function(self, role, abandonGridType)
  -- function num : 0_124
  return (self.cluaSkillCtrl):CallFindEmptyGridWithoutEfcGridAroundRole(role, abandonGridType)
end

LuaSkillCtrl.FindEmptyGridWithoutEfcGridAroundGrid = function(self, x, y)
  -- function num : 0_125
  return (self.cluaSkillCtrl):CallFindEmptyGridWithoutEfcGridAroundGrid(x, y)
end

LuaSkillCtrl.FindGridsWithoutEfcGridAroundGrid = function(self, x, y)
  -- function num : 0_126
  return (self.cluaSkillCtrl):CallFindGridsWithoutEfcGridAroundGrid(x, y)
end

LuaSkillCtrl.FindRoleRightEmptyGrid = function(self, role, range)
  -- function num : 0_127
  return (self.cluaSkillCtrl):CallFindRoleRightEmptyGrid(role, range or 1)
end

LuaSkillCtrl.FindRolesAroundRole = function(self, role)
  -- function num : 0_128
  return (self.cluaSkillCtrl):FindRolesAroundRole(role)
end

LuaSkillCtrl.FindRolesAroundGrid = function(self, grid, belongNum)
  -- function num : 0_129
  return (self.cluaSkillCtrl):FindRolesAroundGrid(grid, belongNum)
end

LuaSkillCtrl.CallFindEmptyGridNearest = function(self, role)
  -- function num : 0_130
  return (self.cluaSkillCtrl):CallFindEmptyGridNearest(role)
end

LuaSkillCtrl.CallFindGridMostRolesArounded = function(self, belongNum)
  -- function num : 0_131
  return (self.cluaSkillCtrl):CallFindGridMostRolesArounded(belongNum, false)
end

LuaSkillCtrl.SetRolePos = function(self, grid, role)
  -- function num : 0_132
  if self.IsInTDBattle then
    return 
  end
  ;
  (self.cluaSkillCtrl):SetPosForce(grid, role)
end

LuaSkillCtrl.PreSetRolePos = function(self, grid, role)
  -- function num : 0_133
  (self.cluaSkillCtrl):PreSetPosForce(grid, role)
end

LuaSkillCtrl.PreSetRolePosWithCoord = function(self, x, y, role)
  -- function num : 0_134
  return (self.cluaSkillCtrl):PreSetPosForceWithCoord(x, y, role)
end

LuaSkillCtrl.CanclePreSetPos = function(self, role)
  -- function num : 0_135
  (self.cluaSkillCtrl):CanclePreSetPos(role)
end

LuaSkillCtrl.MoveRoleToTarget = function(self, luaSkill, grid, role, isOneStep, onfinish)
  -- function num : 0_136 , upvalues : _ENV
  local onFinish = nil
  if onfinish ~= nil then
    onFinish = BindCallback(luaSkill, onfinish, grid, role)
  end
  if self.IsInTDBattle then
    onFinish(role.x, role.y)
    return 
  end
  ;
  (self.cluaSkillCtrl):MoveToTarget(grid, role, isOneStep, onFinish)
end

LuaSkillCtrl.CallPhaseMove = function(self, luaSkill, role, gridX, gridY, moveDuration, notBeSelectBuffId, buffTier)
  -- function num : 0_137
  if not notBeSelectBuffId then
    notBeSelectBuffId = 0
  end
  if not buffTier then
    buffTier = 1
  end
  -- DECOMPILER ERROR at PC18: Unhandled construct in 'MakeBoolean' P1

  if self.IsInTDBattle and notBeSelectBuffId > 0 then
    self:CallBuff(luaSkill, role, notBeSelectBuffId, buffTier, moveDuration, true)
  end
  do return  end
  ;
  (self.cluaSkillCtrl):CallPhaseMove(luaSkill.cskill, gridX, gridY, role, moveDuration, notBeSelectBuffId, buffTier)
end

LuaSkillCtrl.CallPhaseMoveWithoutTurn = function(self, luaSkill, role, gridX, gridY, moveDuration, notBeSelectBuffId, buffTier)
  -- function num : 0_138
  if not notBeSelectBuffId then
    notBeSelectBuffId = 0
  end
  if not buffTier then
    buffTier = 1
  end
  -- DECOMPILER ERROR at PC18: Unhandled construct in 'MakeBoolean' P1

  if self.IsInTDBattle and notBeSelectBuffId > 0 then
    self:CallBuff(luaSkill, role, notBeSelectBuffId, buffTier, moveDuration, true)
  end
  do return  end
  ;
  (self.cluaSkillCtrl):CallPhaseMoveWithoutTurn(luaSkill.cskill, gridX, gridY, role, moveDuration, notBeSelectBuffId, buffTier)
end

LuaSkillCtrl.CallPhaseMoveWithoutTurnAndAllowCcd = function(self, luaSkill, role, gridX, gridY, moveDuration, notBeSelectBuffId, buffTier)
  -- function num : 0_139
  if not notBeSelectBuffId then
    notBeSelectBuffId = 0
  end
  if not buffTier then
    buffTier = 1
  end
  -- DECOMPILER ERROR at PC18: Unhandled construct in 'MakeBoolean' P1

  if self.IsInTDBattle and notBeSelectBuffId > 0 then
    self:CallBuff(luaSkill, role, notBeSelectBuffId, buffTier, moveDuration, true)
  end
  do return  end
  ;
  (self.cluaSkillCtrl):CallPhaseMoveWithoutTurnAndAllowCcd(luaSkill.cskill, gridX, gridY, role, moveDuration, notBeSelectBuffId, buffTier)
end

LuaSkillCtrl.IsRoleAdjacent = function(self, roleA, roleB)
  -- function num : 0_140
  return (self.cluaSkillCtrl):IsRoleAdjacent(roleA, roleB)
end

LuaSkillCtrl.GetGridsDistance = function(self, x1, y1, x2, y2)
  -- function num : 0_141
  return (self.cluaSkillCtrl):GetGridsDistance(x1, y1, x2, y2)
end

LuaSkillCtrl.GetRoleGridsDistance = function(self, role1, role2)
  -- function num : 0_142
  return (self.cluaSkillCtrl):GetGridsDistance(role1, role2)
end

LuaSkillCtrl.CallFindEmptyGridWithinRangeAndMostClosed = function(self, x, y, range, role)
  -- function num : 0_143
  return (self.cluaSkillCtrl):CallFindEmptyGridClosedToTarget(x, y, role)
end

LuaSkillCtrl.CallFindEmptyGridClosedToTargetInRange = function(self, x, y, role)
  -- function num : 0_144
  return (self.cluaSkillCtrl):CallFindEmptyGridClosedToTargetInRange(x, y, role)
end

LuaSkillCtrl.GetMapBorder = function(self)
  -- function num : 0_145
  return (self.cluaSkillCtrl):GetMapBorder()
end

LuaSkillCtrl.GetFurthestRightEmptyGrid = function(self, x, y)
  -- function num : 0_146
  return (self.cluaSkillCtrl):GetFurthestRightEmptyGrid(x, y)
end

LuaSkillCtrl.CallFindEmptyGridMostRolesArounded = function(self, belongNum)
  -- function num : 0_147
  return (self.cluaSkillCtrl):CallFindGridMostRolesArounded(belongNum, true)
end

LuaSkillCtrl.CallFindXLineGrid = function(self, grid, range)
  -- function num : 0_148
  return (self.cluaSkillCtrl):CallFindXLineGrid(grid, range)
end

LuaSkillCtrl.PlaySkillCv = function(self, roleId)
  -- function num : 0_149 , upvalues : _ENV
  if ControllerManager == nil then
    return nil
  end
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  return cvCtr:PlayCv(roleId, eSkillCv.UltSkill)
end

LuaSkillCtrl.PlayAuSource = function(self, role, audioId, completeAction)
  -- function num : 0_150
  if role.auSource ~= nil then
    return (role.auSource):PlayAudioById(audioId, completeAction)
  end
end

LuaSkillCtrl.PlayAuHit = function(self, luaSkill, target)
  -- function num : 0_151 , upvalues : _ENV
  if self.IsInVerify or target.auSource == nil then
    return nil
  end
  local skillId = (luaSkill.cskill).dataId
  local skillCfg = (ConfigData.battle_skill)[skillId]
  if skillCfg == nil then
    error("cant get the skill cfg,id" .. tostring(skillId))
    return nil
  end
  if skillCfg.hit_skill_type <= 0 then
    return nil
  end
  local hitType = nil
  if target.recordTable ~= nil then
    hitType = (target.recordTable)[eHitAuRecordHint]
  end
  if hitType == nil then
    local resId = target.resSrcId
    local resCfg = (ConfigData.resource_model)[resId]
    if resCfg == nil then
      error("cant get the resource_model cfg,id" .. tostring(resId))
      return nil
    end
    hitType = resCfg.hit_target_type
  end
  do
    if hitType == nil or hitType <= 0 then
      return nil
    end
    return AudioManager:PlayHitSelectorAudio(target.auSource, skillCfg.hit_skill_type, hitType)
  end
end

LuaSkillCtrl.SetRoleHitAudioHint = function(self, role, eHitAuRoleType)
  -- function num : 0_152 , upvalues : _ENV
  if role == nil or role.recordTable == nil then
    return 
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (role.recordTable)[eHitAuRecordHint] = eHitAuRoleType
end

LuaSkillCtrl.StopAudioByBack = function(self, audio)
  -- function num : 0_153 , upvalues : _ENV
  if AudioManager == nil or audio == nil then
    return 
  end
  AudioManager:StopAudioByBack(audio)
end

LuaSkillCtrl.GetEfcGridWithPos = function(self, x, y)
  -- function num : 0_154
  return ((self.battleCtrl).EfcGridController):GetEffectGrid(x, y)
end

LuaSkillCtrl.GetRoleEfcGrid = function(self, role)
  -- function num : 0_155
  return (self.cluaSkillCtrl):GetRoleEfcGrid(role)
end

LuaSkillCtrl.GetNearestEfcGrid = function(self, role, gridId)
  -- function num : 0_156
  return (self.cluaSkillCtrl):GetNearestEfcGrid(role, gridId)
end

LuaSkillCtrl.GetNearestEmptyEfcGrid = function(self, role, gridId)
  -- function num : 0_157
  return (self.cluaSkillCtrl):GetNearestEfcEmptyGrid(role, gridId)
end

LuaSkillCtrl.FindEmptyEfcGrid = function(self)
  -- function num : 0_158
  return (self.cluaSkillCtrl):FindEmptyEfcGrid()
end

LuaSkillCtrl.CallCreateEfcGrid = function(self, x, y, gridId)
  -- function num : 0_159 , upvalues : _ENV, DynEffectGrid
  local coord = ((BattleUtil.XYCoord2Pos)(x, y))
  local effectGrid = nil
  if not self.IsInVerify then
    effectGrid = (DynEffectGrid.New)(coord, gridId)
  else
    effectGrid = (self.cluaSkillCtrl):CreateDynEfcGridDataInVerify(coord, x, y, gridId)
  end
  return ((self.battleCtrl).EfcGridController):AddEffectGridInBattle(effectGrid)
end

LuaSkillCtrl.CallGetTotalEfcGridCount = function(self)
  -- function num : 0_160
  return ((self.battleCtrl).EfcGridController):GetAllActiveGridCount()
end

LuaSkillCtrl.CallGetTotalEfcGrid = function(self)
  -- function num : 0_161
  return ((self.battleCtrl).EfcGridController):GetGridList()
end

LuaSkillCtrl.CallLoseAllGridEffect = function(self)
  -- function num : 0_162
  local grids = ((self.battleCtrl).EfcGridController):GetGridList()
  if grids ~= nil and grids.Count > 0 then
    for i = grids.Count - 1, 0, -1 do
      (grids[i]):GridLoseEffect()
    end
  end
end

LuaSkillCtrl.GetRoleInBattle = function(self, isHero, index)
  -- function num : 0_163
  local role = nil
  if isHero then
    role = (((self.battleCtrl).PlayerTeamController).battleOriginRoleList)[index]
  else
    role = (((self.battleCtrl).EnemyTeamController).battleOriginRoleList)[index]
  end
  if role.isDead then
    role = nil
  end
  return role
end

LuaSkillCtrl.CallDoodad = function(self, sender, targetRole)
  -- function num : 0_164 , upvalues : _ENV
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnDoodad, sender, targetRole)
end

LuaSkillCtrl.CallChipSuitInvoke = function(self, sender, targetRole)
  -- function num : 0_165 , upvalues : _ENV
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnChipSuitInvoke, sender, targetRole)
end

LuaSkillCtrl.RegisterLuaTrigger = function(self, luaTriggerId, action)
  -- function num : 0_166
  if self.luaTrigger == nil or action == nil or luaTriggerId == nil then
    return 
  end
  ;
  (self.luaTrigger):AddListener(luaTriggerId, action)
end

LuaSkillCtrl.UnRegisterLuaTrigger = function(self, luaTriggerId, action)
  -- function num : 0_167
  if self.luaTrigger == nil or action == nil or luaTriggerId == nil then
    return 
  end
  ;
  (self.luaTrigger):RemoveListener(luaTriggerId, action)
end

LuaSkillCtrl.UnRegisterLuaTriggerById = function(self, luaTriggerId)
  -- function num : 0_168
  if self.luaTrigger == nil then
    return 
  end
  if luaTriggerId ~= nil then
    (self.luaTrigger):RemoveListenerByType(luaTriggerId)
  end
end

LuaSkillCtrl.RemoveAllLuaTrigger = function(self)
  -- function num : 0_169
  if self.luaTrigger ~= nil then
    (self.luaTrigger):Clear()
    self.luaTrigger = nil
  end
end

LuaSkillCtrl.BroadcastLuaTrigger = function(self, luaTriggerId, ...)
  -- function num : 0_170
  if self.luaTrigger == nil or luaTriggerId == nil then
    return 
  end
  ;
  (self.luaTrigger):Broadcast(luaTriggerId, ...)
end

LuaSkillCtrl.StartShowSkillDurationTime = function(self, luaSkill, time)
  -- function num : 0_171
  if self.IsInVerify then
    return 
  end
  ;
  (self.cluaSkillCtrl):StartShowSkillDurationTime(luaSkill.caster, time)
end

LuaSkillCtrl.StopShowSkillDurationTime = function(self, luaSkill)
  -- function num : 0_172
  if self.IsInVerify then
    return 
  end
  ;
  (self.cluaSkillCtrl):StopShowSkillDurationTime(luaSkill.caster)
end

LuaSkillCtrl.SetGameScoreAcitve = function(self, typeId, active)
  -- function num : 0_173 , upvalues : _ENV
  MsgCenter:Broadcast(eMsgEventId.ChangeBattleScoreActive, typeId, active)
end

LuaSkillCtrl.SetGameScoreValue = function(self, typeId, value)
  -- function num : 0_174 , upvalues : _ENV
  MsgCenter:Broadcast(eMsgEventId.ChangeBattleScoreValue, typeId, value)
end

LuaSkillCtrl.SetFinalScoreValue = function(self, id, value)
  -- function num : 0_175
  (self.cluaSkillCtrl):SetFinalGamePlayScore(id, value)
end

LuaSkillCtrl.ForceEndBattle = function(self, isWin)
  -- function num : 0_176
  (self.cluaSkillCtrl):ForceEndBattle(isWin)
end

LuaSkillCtrl.BattlegroundDrop = function(self, Vector2Point, num, fxName)
  -- function num : 0_177
  if self.IsInVerify then
    return 
  end
  ;
  ((self.battleCtrl).PropDropController):RandomDrop(Vector2Point, num, fxName)
end

LuaSkillCtrl.RecordLimitTime = function(self, limitTime)
  -- function num : 0_178
  limitTime = limitTime + (self.battleCtrl).frame
  ;
  (self.cluaSkillCtrl):RecordLimitTime(limitTime)
end

LuaSkillCtrl.CallRedisplayInSkillInputCtrl = function(self, role)
  -- function num : 0_179 , upvalues : _ENV
  if role.hp <= 0 or role.unableSelect or role:IsUnselectAbleExceptSameBelong(eBattleRoleBelong.player) then
    return 
  end
  local playerCtrl = (self.battleCtrl).PlayerController
  if playerCtrl == nil then
    return 
  end
  local skillInputCtrl = playerCtrl.battleSkillInputController
  if skillInputCtrl == nil or not skillInputCtrl:IsActive() or skillInputCtrl.selectfirstType ~= ((CS.BattleSkillSelectHandle).SkillSelectType).eSingleAndSelectRole then
    return 
  end
  skillInputCtrl:CancleWaitSelectRoleTiles()
  skillInputCtrl:CheckAndSetSelectRolesTiles()
end

LuaSkillCtrl.ShowCounting = function(self, role, count, maxCount)
  -- function num : 0_180
  role:ShowCounting(count, maxCount)
end

LuaSkillCtrl.UpdateCounting = function(self, role, count)
  -- function num : 0_181
  role:UpdateCounting(count)
end

LuaSkillCtrl.HideCounting = function(self, role)
  -- function num : 0_182
  role:HideCounting()
end

LuaSkillCtrl.SetCountingColor = function(self, role, r, g, b, a)
  -- function num : 0_183
  role:SetCountingColor(r, g, b, a)
end

LuaSkillCtrl.CreateTDMonster = function(self, luaDynMonster, luaSkill, followTarget)
  -- function num : 0_184
  return (self.cluaSkillCtrl):CreateTDMonster(luaDynMonster, luaSkill.cskill, followTarget)
end

LuaSkillCtrl.CallSetPlayerTowerMpIncreasedSpeed = function(self, value)
  -- function num : 0_185
  (self.cluaSkillCtrl):CallSetPlayerTowerMpIncreasedSpeed(value)
end

LuaSkillCtrl.GetPlayerTowerMpIncreasedSpeed = function(self)
  -- function num : 0_186
  return (self.cluaSkillCtrl):GetPlayerTowerMpIncreasedSpeed()
end

LuaSkillCtrl.AddPlayerTowerMp = function(self, value)
  -- function num : 0_187
  return (self.cluaSkillCtrl):AddPlayerTowerMp(value)
end

LuaSkillCtrl.GetPlayerTowerMp = function(self)
  -- function num : 0_188
  return (self.cluaSkillCtrl):GetPlayerTowerMp()
end

LuaSkillCtrl.GetAllWaitToCasteMonsters = function(self)
  -- function num : 0_189
  return ((self.battleCtrl).CurBattleMapCfg).waitToCasterMonsterList
end

LuaSkillCtrl.GetAllPlayerDungeonRoles = function(self)
  -- function num : 0_190
  return (self.cluaSkillCtrl):CallGetAllPlayerDungeonRoles()
end

LuaSkillCtrl.GetRoleTag = function(self, role)
  -- function num : 0_191
  return role:GetRoleTag()
end

LuaSkillCtrl.GetTDMosterDieReward = function(self, role)
  -- function num : 0_192
  return role:GetTDRoleDieReward()
end

LuaSkillCtrl.OnDelete = function(self)
  -- function num : 0_193 , upvalues : _ENV
  if file ~= nil then
    file:write("战斗结束，持续帧数： " .. tostring((self.battleCtrl).frame) .. "\n\n\n\n\n\n")
    file:close()
  end
  self.IsInTDBattle = false
  self.cUltSkillCtrl = nil
  self.battleCtrl = nil
  self.cluaSkillCtrl = nil
  ;
  (self.logicTimerCtrl):StopAllTimer()
  self:RemoveAllLuaTrigger()
end

return LuaSkillCtrl

