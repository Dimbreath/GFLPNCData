-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaSkillCtrl = class("LuaSkillCtrl")
local SkillLogicTimerCtrl = require("GamePlay.LogicTime.SkillLogicTimerCtrl")
local DynEffectGrid = require("Game.Exploration.Data.DynEffectGrid")
local Messenger = require("Framework.Common.Messenger")
local cs_RangFunc = (CS.RandomUtility).Range
LuaSkillCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : SkillLogicTimerCtrl
  self.logicTimerCtrl = (SkillLogicTimerCtrl.New)()
end

LuaSkillCtrl.InitSkillCtrl = function(self, battleCtrl)
  -- function num : 0_1 , upvalues : _ENV, Messenger
  self.battleCtrl = battleCtrl
  self.cluaSkillCtrl = battleCtrl.LuaSkillController
  self.cUltSkillCtrl = (battleCtrl.PlayerController).UltSkillHandle
  sg = {}
  self.luaTrigger = (Messenger.New)()
end

LuaSkillCtrl.AddSkillTrigger = function(self, triggerType, battleSKill, name, priority, eventFunc, isSelf)
  -- function num : 0_2
  (self.cluaSkillCtrl):AddTrigger(triggerType, battleSKill, name, priority, eventFunc, isSelf)
end

LuaSkillCtrl.RemoveTrigger = function(self, luaSkill, eventType)
  -- function num : 0_3
  (self.cluaSkillCtrl):RemoveTrigger(luaSkill.cskill, eventType)
end

LuaSkillCtrl.RemoveSkillAllTrigger = function(self, battleSkill)
  -- function num : 0_4
  (self.cluaSkillCtrl):RemoveSkillAllTrigger(battleSkill)
end

LuaSkillCtrl.GetTrigger = function(self, luaSkill, eventType)
  -- function num : 0_5
  (luaSkill.cskill):GetTrigger(eventType)
end

LuaSkillCtrl.OnUpdateLogic = function(self)
  -- function num : 0_6
  (self.logicTimerCtrl):OnUpdateLogic()
end

LuaSkillCtrl.StartTimer = function(self, luaSkill, delay, func, obj, is_loop, start_time)
  -- function num : 0_7
  local timer = (self.logicTimerCtrl):GetTimer(delay, func, obj, is_loop, start_time, luaSkill)
  if luaSkill ~= nil then
    timer:InjectLuaSkill(luaSkill)
  end
  timer:Start()
  return timer
end

LuaSkillCtrl.GetTimer = function(self, delay, func, obj, is_loop, start_time)
  -- function num : 0_8
  return ((self.logicTimerCtrl):GetTimer(delay, func, obj, is_loop, start_time)):Start()
end

LuaSkillCtrl.CallRange = function(self, min, max)
  -- function num : 0_9 , upvalues : cs_RangFunc
  return cs_RangFunc(min, max)
end

LuaSkillCtrl.CallRoleAction = function(self, role, id, speed)
  -- function num : 0_10
  if speed ~= nil then
    (self.cluaSkillCtrl):CallRoleAction(role, id, speed)
  else
    ;
    (self.cluaSkillCtrl):CallRoleAction(role, id, 1)
  end
end

LuaSkillCtrl.BreakCurrentAction = function(self, role)
  -- function num : 0_11
  (self.cluaSkillCtrl):BreakCurrentAction(role)
end

LuaSkillCtrl.CallRoleActionWithTrigger = function(self, luaSkill, role, id, speed, triggerTime, onTrigger)
  -- function num : 0_12
  if speed == nil then
    speed = 1
  end
  local timer = nil
  if triggerTime > 0 then
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

LuaSkillCtrl.CallBuff = function(self, luaSkill, role, buffId, buffTier, duration, isIgnoreTrigger)
  -- function num : 0_13
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  if duration == nil then
    return (self.cluaSkillCtrl):CallBuff(luaSkill.cskill, role, buffId, buffTier, isIgnoreTrigger)
  else
    return (self.cluaSkillCtrl):CallTimeBuff(luaSkill.cskill, role, buffId, buffTier, duration, isIgnoreTrigger)
  end
end

LuaSkillCtrl.CallBuffWithOriginSkill = function(self, cSkill, role, buffId, buffTier, duration)
  -- function num : 0_14
  if duration == nil then
    return (self.cluaSkillCtrl):CallBuff(cSkill, role, buffId, buffTier)
  else
    return (self.cluaSkillCtrl):CallTimeBuff(cSkill, role, buffId, buffTier, duration)
  end
end

LuaSkillCtrl.CallBuffRepeated = function(self, luaSkill, role, buffId, buffTier, duration, isIgnoreTrigger, onRepeated, ...)
  -- function num : 0_15 , upvalues : _ENV
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
  -- function num : 0_16
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

LuaSkillCtrl.DispelBuff = function(self, role, buffId, buffTier, isIgnoreTrigger)
  -- function num : 0_17
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  ;
  (self.cluaSkillCtrl):DispelBuff(role, buffId, buffTier, isIgnoreTrigger)
end

LuaSkillCtrl.GetRoleBuffs = function(self, role)
  -- function num : 0_18
  return (self.cluaSkillCtrl):GetRoleBuffs(role)
end

LuaSkillCtrl.RoleContainsBuffFeature = function(self, role, buffFeature)
  -- function num : 0_19
  return (self.cluaSkillCtrl):RoleContainsBuffFeature(role, buffFeature)
end

LuaSkillCtrl.RoleContainsCtrlBuff = function(self, role)
  -- function num : 0_20
  return (self.cluaSkillCtrl):RoleContainsCtrlBuff(role)
end

LuaSkillCtrl.CallTargetSelect = function(self, luaSkill, targetSelectId, rangeOffset, overrideSelf)
  -- function num : 0_21 , upvalues : _ENV
  if overrideSelf == nill then
    overrideSelf = luaSkill.caster
  end
  return (self.cluaSkillCtrl):CallTargetSelect(luaSkill.cskill, overrideSelf, targetSelectId, rangeOffset or 0)
end

LuaSkillCtrl.CallTargetSelectWithCskill = function(self, cskill, targetSelectId, rangeOffset, caster)
  -- function num : 0_22
  return (self.cluaSkillCtrl):CallTargetSelect(cskill, caster, targetSelectId, rangeOffset or 0)
end

LuaSkillCtrl.CallRightMaxDirEnemy = function(self, role)
  -- function num : 0_23
  return (self.cluaSkillCtrl):CallRightMaxDirEnemy(role)
end

LuaSkillCtrl.GetSelectTeamRoles = function(self, belongNum)
  -- function num : 0_24 , upvalues : _ENV
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

LuaSkillCtrl.CallEffect = function(self, target, effectId, luaSkill, func, overrideSelf, speed, isBreakKill)
  -- function num : 0_25 , upvalues : _ENV
  if isBreakKill == nil then
    isBreakKill = false
  end
  if func ~= nil then
    return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func), overrideSelf, speed, isBreakKill)
  else
    return self:CallEffectInCs(target, luaSkill, effectId, nil, overrideSelf, speed, isBreakKill)
  end
end

LuaSkillCtrl.CallEffectWithEmission = function(self, emission, effectId, luaSkill, func, overrideSelf, speed, isBreakKill)
  -- function num : 0_26 , upvalues : _ENV
  if isBreakKill == nil then
    isBreakKill = false
  end
  if func ~= nil then
    return self:CallEffectWithEmissionInCs(emission, luaSkill, effectId, BindCallback(luaSkill, func), overrideSelf, speed, isBreakKill)
  else
    return self:CallEffectWithEmissionInCs(emission, luaSkill, effectId, nil, overrideSelf, speed, isBreakKill)
  end
end

LuaSkillCtrl.CallEffectWithArg = function(self, target, effectId, luaSkill, isBreakKill, func, ...)
  -- function num : 0_27 , upvalues : _ENV
  return self:CallEffectInCs(target, luaSkill, effectId, (BindCallback(luaSkill, func, ...)), nil)
end

LuaSkillCtrl.CallEffectWithArgAndSpeed = function(self, target, effectId, luaSkill, speed, isBreakKill, func, ...)
  -- function num : 0_28 , upvalues : _ENV
  return self:CallEffectInCs(target, luaSkill, effectId, (BindCallback(luaSkill, func, ...)), nil, speed)
end

LuaSkillCtrl.CallEffectWithArgOverride = function(self, target, effectId, luaSkill, overrideSelf, isBreakKill, func, ...)
  -- function num : 0_29 , upvalues : _ENV
  return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func, ...), overrideSelf, nil, isBreakKill)
end

LuaSkillCtrl.CallEffectWithArgAndSpeedOverride = function(self, target, effectId, luaSkill, overrideSelf, speed, isBreakKill, func, ...)
  -- function num : 0_30 , upvalues : _ENV
  return self:CallEffectInCs(target, luaSkill, effectId, BindCallback(luaSkill, func, ...), overrideSelf, speed, isBreakKill)
end

LuaSkillCtrl.GetTargetWithGrid = function(self, gridX, gridY)
  -- function num : 0_31
  return (self.cluaSkillCtrl):GetTargetWithGrid(gridX, gridY)
end

LuaSkillCtrl.GetGridWithRole = function(self, role)
  -- function num : 0_32
  return (self.cluaSkillCtrl):GetGridWithRole(role)
end

LuaSkillCtrl.GetGridWithPos = function(self, x, y)
  -- function num : 0_33
  return (self.cluaSkillCtrl):GetGridWithPos(x, y)
end

LuaSkillCtrl.CallEffectInCs = function(self, target, luaSkill, effectId, bindCallBack, overrideSelf, speed, isBreakKill)
  -- function num : 0_34 , upvalues : _ENV
  if speed == nil then
    speed = 1
  end
  local effect = (self.cluaSkillCtrl):CallEffect(target, luaSkill.cskill, effectId, bindCallBack, overrideSelf, speed)
  if luaSkill.effects ~= nil and effect ~= nil and isBreakKill then
    (table.insert)(luaSkill.effects, effect)
  end
  return effect
end

LuaSkillCtrl.CallEffectWithEmissionInCs = function(self, emission, luaSkill, effectId, bindCallBack, overrideSelf, speed, isBreakKill)
  -- function num : 0_35 , upvalues : _ENV
  if speed == nil then
    speed = 1
  end
  local effect = (self.cluaSkillCtrl):CallEffectWithEmission(emission, luaSkill.cskill, effectId, bindCallBack, overrideSelf, speed)
  if isBreakKill then
    (table.insert)(luaSkill.effects, effect)
  end
  return effect
end

LuaSkillCtrl.CallAddCircleColliderForEffect = function(self, effect, radius, influenceType, onCollisionStay, onCollisionEnter, onCollisionExit)
  -- function num : 0_36
  return (self.cluaSkillCtrl):CallAddCircleColliderForEffect(effect, radius, influenceType, onCollisionStay, onCollisionEnter, onCollisionExit)
end

LuaSkillCtrl.CallSelectTargetEffect = function(self, luaSkill, targetRole)
  -- function num : 0_37
  return (self.cluaSkillCtrl):CallSelectTargetEffect((luaSkill.cskill).maker, targetRole)
end

LuaSkillCtrl.CallRealDamage = function(self, luaSkill, target, effect, config, configArg, isTriggerSet, isIgnoreTrigger)
  -- function num : 0_38 , upvalues : _ENV
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
    setmetatable(config, {__index = realDamageConfig})
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  skillResult:HurtResult(config, configArg, isIgnoreTrigger or false)
  skillResult:EndResult()
end

LuaSkillCtrl.RemoveLife = function(self, hurt, luaSkill, target, isRealDmg, isTriggerSet, buff, isShowText, isIgnoreTrigger)
  -- function num : 0_39
  if isShowText == nil then
    isShowText = true
  end
  return (self.battleCtrl):SetRoleHurt(hurt, luaSkill.cskill, luaSkill.caster, target, false, false, isRealDmg or false, isTriggerSet or false, buff, isShowText, isIgnoreTrigger or false)
end

LuaSkillCtrl.CallHeal = function(self, heal, luaSkill, target, isIgnoreTrigger)
  -- function num : 0_40
  return (self.battleCtrl):SetRoleHeal(heal, luaSkill.cskill, luaSkill.caster, target, false, nil, false, isIgnoreTrigger or false)
end

LuaSkillCtrl.CallFloatText = function(self, role, floatTextId, damage)
  -- function num : 0_41
  if damage == nil then
    (self.cluaSkillCtrl):CallFloatText(role, floatTextId)
  else
    ;
    (self.cluaSkillCtrl):CallFloatText(role, floatTextId, damage)
  end
end

LuaSkillCtrl.CallSkillResult = function(self, effect, target, config)
  -- function num : 0_42
  return (self.cluaSkillCtrl):GetSkillResult(effect, target, config)
end

LuaSkillCtrl.CallSkillResultNoEffect = function(self, luaSkill, target, config)
  -- function num : 0_43
  return (self.cluaSkillCtrl):GetSkillResultNoEffect(luaSkill.cskill, target, config)
end

LuaSkillCtrl.HurtResult = function(self, skillResult, config, configArg, isTriggerSet, isIgnoreTrigger)
  -- function num : 0_44 , upvalues : _ENV
  if isIgnoreTrigger == nil then
    isIgnoreTrigger = false
  end
  if config == nil then
    config = generalHurtConfig
  end
  if isTriggerSet then
    config.isTriggerSet = true
  end
  if config ~= generalHurtConfig then
    setmetatable(config, {__index = generalHurtConfig})
  end
  skillResult:HurtResult(config, configArg, isIgnoreTrigger)
end

LuaSkillCtrl.HealResult = function(self, skillResult, config, configArg, isTriggerSet, isIgnoreTrigger)
  -- function num : 0_45 , upvalues : _ENV
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
  -- function num : 0_46
  return (self.cluaSkillCtrl):CallNewSkill(skillId, skillLevel or 1, skillType or 0, itemId or 0)
end

LuaSkillCtrl.CallFormulaNumber = function(self, formual, role, targetRole, ...)
  -- function num : 0_47 , upvalues : _ENV
  return (self.cluaSkillCtrl):CallFormulaNumber(formual, role, targetRole, (table.unpack)({...}))
end

LuaSkillCtrl.CallFormulaBool = function(self, formual, role, target, ...)
  -- function num : 0_48 , upvalues : _ENV
  return (self.cluaSkillCtrl):CallFormulaBool(formual, role, target, (table.unpack)({...}))
end

LuaSkillCtrl.CallFormulaNumberWithSkill = function(self, formual, role, target, luaSkill, ...)
  -- function num : 0_49 , upvalues : _ENV
  return (self.cluaSkillCtrl):CallFormulaNumberWithSkill(formual, role, target, luaSkill.cskill, (table.unpack)({...}))
end

LuaSkillCtrl.CallFormulaBoolWithSkill = function(self, formual, role, target, luaSkill, ...)
  -- function num : 0_50 , upvalues : _ENV
  return (self.cluaSkillCtrl):CallFormulaBoolWithSkill(formual, role, target, luaSkill.cskill, (table.unpack)({...}))
end

LuaSkillCtrl.CallResetCDForSingleSkill = function(self, battleSkill, offset)
  -- function num : 0_51
  battleSkill:ResetCDTimeOffsetNum(offset)
end

LuaSkillCtrl.CallResetCDRatioForRole = function(self, role, ofsPercent)
  -- function num : 0_52
  (self.cluaSkillCtrl):CallResetCDRatioForRole(role, ofsPercent)
end

LuaSkillCtrl.CallResetCDNumForRole = function(self, role, offset)
  -- function num : 0_53
  (self.cluaSkillCtrl):CallResetCDNumForRole(role, offset)
end

LuaSkillCtrl.CallResetComAtkCDRatioForRole = function(self, role, ratio)
  -- function num : 0_54
  (self.cluaSkillCtrl):CallResetComAtkCDRatioForRole(role, ratio)
end

LuaSkillCtrl.CallResetCDForTeam = function(self, belongNum, ofsPercent)
  -- function num : 0_55
  (self.cluaSkillCtrl):CallResetCDForTeam(belongNum, ofsPercent)
end

LuaSkillCtrl.CallResetCDForTeamSingleSkill = function(self, belongNum, luaSkill, ofsPercent)
  -- function num : 0_56
  (self.cluaSkillCtrl):CallResetCDForTeamSingleSkill(belongNum, (luaSkill.cskill).dataId, ofsPercent)
end

LuaSkillCtrl.CallResetMainSkillCDRatioForTeam = function(self, belongNum, ofsPercent)
  -- function num : 0_57
  (self.cluaSkillCtrl):CallResetMainSkillCDForTeam(belongNum, ofsPercent)
end

LuaSkillCtrl.CallResetMainSkillCDNumForTeam = function(self, belongNum, offset)
  -- function num : 0_58
  (self.cluaSkillCtrl):CallResetMainSkillCDNumForTeam(belongNum, offset)
end

LuaSkillCtrl.CallBreakAllSkill = function(self, role)
  -- function num : 0_59
  (self.cluaSkillCtrl):CallBreakAllLuaSkill(role)
end

LuaSkillCtrl.RecordSkillCompleted = function(self, luaSkill)
  -- function num : 0_60
  luaSkill.isSkillUncompleted = false
end

LuaSkillCtrl.RecordSkillUncompleted = function(self, luaSkill)
  -- function num : 0_61
  luaSkill.isSkillUncompleted = true
end

LuaSkillCtrl.IsAbleAttackTarget = function(self, role, target, attack_range)
  -- function num : 0_62
  return (self.cluaSkillCtrl):IsAbleAttackTarget(role, target, attack_range)
end

LuaSkillCtrl.IsAbleAttackTargetWithDir = function(self, role, targetRole, atk_range, dir_range)
  -- function num : 0_63
  return (self.cluaSkillCtrl):IsAbleAttackTargetWithDir(role, targetRole, atk_range, dir_range)
end

LuaSkillCtrl.IsAbleAttackCheckExcludedDir = function(self, role, targetRole, dir_range)
  -- function num : 0_64
  return (self.cluaSkillCtrl):IsAbleAttackCheckExcludedDir(role, targetRole, dir_range)
end

LuaSkillCtrl.IsWorthAttacking = function(self, role)
  -- function num : 0_65 , upvalues : _ENV
  if role:ContainBuffFeature(eBuffFeatureType.Bewitch) then
    if (self.battleCtrl):IsAllMemberBewitched(role.belong) then
      return true
    else
      return false
    end
  end
  return true
end

LuaSkillCtrl.CreateSummoner = function(self, luaSkill, monsterId, coordx, coordy)
  -- function num : 0_66
  return (self.cluaSkillCtrl):CreateSummoner(luaSkill.cskill, monsterId, coordx, coordy)
end

LuaSkillCtrl.AddSummonerRole = function(self, summoner)
  -- function num : 0_67
  return (self.cluaSkillCtrl):AddSummonerRole(summoner)
end

LuaSkillCtrl.CallFocusTimeLine = function(self, role)
  -- function num : 0_68
  (self.cUltSkillCtrl):PlayFocusTimeLine(role)
end

LuaSkillCtrl.CallBackViewTimeLine = function(self, role, isEndUltEffect)
  -- function num : 0_69
  (self.cUltSkillCtrl):PlayBackViewTimeLine(role, isEndUltEffect)
end

LuaSkillCtrl.EndUltEffectAndUnFreeze = function(self)
  -- function num : 0_70
  (self.battleCtrl):SetUltSkillUnFreeze()
end

LuaSkillCtrl.CallPlayUltMovie = function(self)
  -- function num : 0_71
  if self.cUltSkillCtrl ~= nil then
    (self.cUltSkillCtrl):PlayUltMovie()
  end
end

LuaSkillCtrl.CallBattleCamShake = function(self, level)
  -- function num : 0_72 , upvalues : _ENV
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

LuaSkillCtrl.StartTimerInUlt = function(self, delay, func, obj)
  -- function num : 0_73 , upvalues : _ENV
  local onDelayAction = BindCallback(self, func, obj)
  ;
  (self.cUltSkillCtrl):StartTimer(delay, onDelayAction)
end

LuaSkillCtrl.GetUltHMp = function(self)
  -- function num : 0_74
  if self.cluaSkillCtrl ~= nil then
    return (self.cUltSkillCtrl):GetCurUltMp()
  end
end

LuaSkillCtrl.CallCircledEmissionStraightly = function(self, luaSkill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, isDir, isArriveKill, onArrive, bindRole)
  -- function num : 0_75
  return (self.cluaSkillCtrl):CallCircledEmissionStraightly(luaSkill.cskill, caster, target, radius, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, isDir, isArriveKill, onArrive)
end

LuaSkillCtrl.CallSectorEmissionStraightly = function(self, luaSkill, caster, target, radius, arcAngle, arcAngleRange, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, isDir, isArriveKill, onArrive, bindRole)
  -- function num : 0_76
  return (self.cluaSkillCtrl):CallSectorEmissionStraightly(luaSkill.cskill, caster, target, radius, arcAngle, arcAngleRange, spdPerFrame, influenceType, onColiEnter, onColiStay, onColiExit, effect, bindRole, isDir, isArriveKill, onArrive)
end

LuaSkillCtrl.CallRestartEmit = function(self, luaSkill, skillEmission, speed, target, isToBorder, isArriveKill, onArrive)
  -- function num : 0_77
  if isToBorder then
    return skillEmission:ReStartEmitToBorder(self.battleCtrl, speed, skillEmission.skill, target, isArriveKill, onArrive)
  else
    return skillEmission:ReStartEmit(speed, luaSkill.skill, target, isArriveKill, onArrive)
  end
end

LuaSkillCtrl.CallGetCircleSkillCollider = function(self, luaSkill, radius, influenceType, onEnter, onStay, onExit)
  -- function num : 0_78
  return (self.cluaSkillCtrl):CallGetCircleSkillCollider(luaSkill.caster, radius, influenceType, onEnter, onStay, onExit)
end

LuaSkillCtrl.CallGetSectorSkillCollider = function(self, luaSkill, radius, arcAngle, arcAngleRange, influenceType, onEnter, onStay, onExit)
  -- function num : 0_79
  return (self.cluaSkillCtrl):CallGetSectorSkillCollider(luaSkill.caster, radius, arcAngle, arcAngleRange, influenceType, onEnter, onStay, onExit)
end

LuaSkillCtrl.CallGetRectSkillCollider = function(self, luaSkill, startTarget, halfWidth, halfHeight, dstTarget, influenceType, onEnter, onStay, onExit)
  -- function num : 0_80
  return (self.cluaSkillCtrl):CallGetRectSkillCollider(luaSkill.caster, startTarget, halfWidth, halfHeight, dstTarget, influenceType, onEnter, onStay, onExit)
end

LuaSkillCtrl.CallGetRoleCurDir = function(self, role)
  -- function num : 0_81
  return role:GetRoleForwardAngle()
end

LuaSkillCtrl.CallStartLocalScale = function(self, role, scale, duration)
  -- function num : 0_82
  if (role.lsObject).gameObject ~= nil then
    (role.lsObject):StartLocalScale(scale, duration)
  end
end

LuaSkillCtrl.CallAddRoleProperty = function(self, role, attrName, value, attrType)
  -- function num : 0_83
  role:AddRoleProperty(attrName, value, attrType)
end

LuaSkillCtrl.FindEmptyGrid = function(self, ruleFunc)
  -- function num : 0_84
  return (self.cluaSkillCtrl):CallFindEmptyGrid(ruleFunc)
end

LuaSkillCtrl.FindEmptyGridWithinRange = function(self, role, range)
  -- function num : 0_85
  return (self.cluaSkillCtrl):CallFindEmptyGridWithinRange(role, range)
end

LuaSkillCtrl.FindAllGridsWithinRange = function(self, target, range, isIncludeSelf)
  -- function num : 0_86
  return (self.cluaSkillCtrl):FindAllGridsWithinRange(target, range, isIncludeSelf)
end

LuaSkillCtrl.FindEmptyGridAroundRole = function(self, role)
  -- function num : 0_87
  return (self.cluaSkillCtrl):CallFindEmptyGridAroundRole(role)
end

LuaSkillCtrl.FindEmptyGridWithoutEfcGridAroundRole = function(self, role)
  -- function num : 0_88
  return (self.cluaSkillCtrl):CallFindEmptyGridWithoutEfcGridAroundRole(role)
end

LuaSkillCtrl.FindEmptyGridWithoutEfcGridAroundGrid = function(self, x, y)
  -- function num : 0_89
  return (self.cluaSkillCtrl):CallFindEmptyGridWithoutEfcGridAroundGrid(x, y)
end

LuaSkillCtrl.FindRoleRightEmptyGrid = function(self, role, range)
  -- function num : 0_90
  return (self.cluaSkillCtrl):CallFindRoleRightEmptyGrid(role, range or 1)
end

LuaSkillCtrl.FindRolesAroundRole = function(self, role)
  -- function num : 0_91
  return (self.cluaSkillCtrl):FindRolesAroundRole(role)
end

LuaSkillCtrl.FindRolesAroundGrid = function(self, grid, belongNum)
  -- function num : 0_92
  return (self.cluaSkillCtrl):FindRolesAroundGrid(grid, belongNum)
end

LuaSkillCtrl.CallFindEmptyGridNearest = function(self, role)
  -- function num : 0_93
  return (self.cluaSkillCtrl):CallFindEmptyGridNearest(role)
end

LuaSkillCtrl.CallFindGridMostRolesArounded = function(self, belongNum)
  -- function num : 0_94
  return (self.cluaSkillCtrl):CallFindGridMostRolesArounded(belongNum)
end

LuaSkillCtrl.SetRolePos = function(self, grid, role)
  -- function num : 0_95
  (self.cluaSkillCtrl):SetPosForce(grid, role)
end

LuaSkillCtrl.PreSetRolePos = function(self, grid, role)
  -- function num : 0_96
  (self.cluaSkillCtrl):PreSetPosForce(grid, role)
end

LuaSkillCtrl.PreSetRolePosWithCoord = function(self, x, y, role)
  -- function num : 0_97
  return (self.cluaSkillCtrl):PreSetPosForceWithCoord(x, y, role)
end

LuaSkillCtrl.CanclePreSetPos = function(self, role)
  -- function num : 0_98
  (self.cluaSkillCtrl):CanclePreSetPos(role)
end

LuaSkillCtrl.MoveRoleToTarget = function(self, luaSkill, grid, role, isOneStep, onfinish)
  -- function num : 0_99 , upvalues : _ENV
  local onFinish = nil
  if onfinish ~= nil then
    onFinish = BindCallback(luaSkill, onfinish, grid, role)
  end
  ;
  (self.cluaSkillCtrl):MoveToTarget(grid, role, isOneStep, onFinish)
end

LuaSkillCtrl.CallPhaseMove = function(self, luaSkill, role, gridX, gridY, moveDuration, notBeSelectBuffId, buffTier)
  -- function num : 0_100
  ;
  (self.cluaSkillCtrl):CallPhaseMove(luaSkill.cskill, gridX, gridY, role, moveDuration, notBeSelectBuffId or 0, buffTier or 1)
end

LuaSkillCtrl.CallPhaseMoveWithoutTurn = function(self, luaSkill, role, gridX, gridY, moveDuration, notBeSelectBuffId, buffTier)
  -- function num : 0_101
  ;
  (self.cluaSkillCtrl):CallPhaseMoveWithoutTurn(luaSkill.cskill, gridX, gridY, role, moveDuration, notBeSelectBuffId or 0, buffTier or 1)
end

LuaSkillCtrl.CallPhaseMoveWithoutTurnAndAllowCcd = function(self, luaSkill, role, gridX, gridY, moveDuration, notBeSelectBuffId, buffTier)
  -- function num : 0_102
  ;
  (self.cluaSkillCtrl):CallPhaseMoveWithoutTurnAndAllowCcd(luaSkill.cskill, gridX, gridY, role, moveDuration, notBeSelectBuffId or 0, buffTier or 1)
end

LuaSkillCtrl.IsRoleAdjacent = function(self, roleA, roleB)
  -- function num : 0_103
  return (self.cluaSkillCtrl):IsRoleAdjacent(roleA, roleB)
end

LuaSkillCtrl.GetGridsDistance = function(self, x1, y1, x2, y2)
  -- function num : 0_104
  return (self.cluaSkillCtrl):GetGridsDistance(x1, y1, x2, y2)
end

LuaSkillCtrl.GetRoleGridsDistance = function(self, role1, role2)
  -- function num : 0_105
  return (self.cluaSkillCtrl):GetGridsDistance(role1, role2)
end

LuaSkillCtrl.CallFindEmptyGridWithinRangeAndMostClosed = function(self, x, y, range, role)
  -- function num : 0_106
  return (self.cluaSkillCtrl):CallFindEmptyGridClosedToTarget(x, y, role)
end

LuaSkillCtrl.CallFindEmptyGridClosedToTarget = function(self, x, y, role)
  -- function num : 0_107
  return (self.cluaSkillCtrl):CallFindEmptyGridClosedToTarget(x, y, role)
end

LuaSkillCtrl.GetMapBorder = function(self)
  -- function num : 0_108
  return (self.cluaSkillCtrl):GetMapBorder()
end

LuaSkillCtrl.PlaySkillCv = function(self, roleId)
  -- function num : 0_109 , upvalues : _ENV
  if ControllerManager == nil then
    return nil
  end
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  return cvCtr:PlayCv(roleId, eSkillCv.UltSkill)
end

LuaSkillCtrl.PlayAuSource = function(self, role, audioId)
  -- function num : 0_110
  if role.auSource ~= nil then
    return (role.auSource):PlayAudioById(audioId)
  end
end

LuaSkillCtrl.GetEfcGridWithPos = function(self, x, y)
  -- function num : 0_111
  return ((self.battleCtrl).EfcGridController):GetEffectGrid(x, y)
end

LuaSkillCtrl.GetRoleEfcGrid = function(self, role)
  -- function num : 0_112
  return (self.cluaSkillCtrl):GetRoleEfcGrid(role)
end

LuaSkillCtrl.GetNearestEfcGrid = function(self, role, gridId)
  -- function num : 0_113
  return (self.cluaSkillCtrl):GetNearestEfcGrid(role, gridId)
end

LuaSkillCtrl.GetNearestEmptyEfcGrid = function(self, role, gridId)
  -- function num : 0_114
  return (self.cluaSkillCtrl):GetNearestEfcEmptyGrid(role, gridId)
end

LuaSkillCtrl.FindEmptyEfcGrid = function(self)
  -- function num : 0_115
  return (self.cluaSkillCtrl):FindEmptyEfcGrid()
end

LuaSkillCtrl.CallCreateEfcGrid = function(self, x, y, gridId)
  -- function num : 0_116 , upvalues : _ENV, DynEffectGrid
  local coord = (BattleUtil.XYCoord2Pos)(x, y)
  local effectGrid = (DynEffectGrid.New)(coord, gridId)
  local battleEffectGrid = ((self.battleCtrl).EfcGridController):AddEffectGridInBattle(effectGrid)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

  if battleEffectGrid ~= nil then
    (battleEffectGrid.luaGridScript).cskill = battleEffectGrid.battleSkill
  end
  return battleEffectGrid
end

LuaSkillCtrl.CallGetTotalEfcGridCount = function(self)
  -- function num : 0_117
  return ((self.battleCtrl).EfcGridController):GetAllActiveGridCount()
end

LuaSkillCtrl.CallGetTotalEfcGrid = function(self)
  -- function num : 0_118
  return ((self.battleCtrl).EfcGridController):GetGridList()
end

LuaSkillCtrl.CallLoseAllGridEffect = function(self)
  -- function num : 0_119
  local grids = ((self.battleCtrl).EfcGridController):GetGridList()
  if grids ~= nil and grids.Count > 0 then
    for i = grids.Count - 1, 0, -1 do
      (grids[i]):GridLoseEffect()
    end
  end
end

LuaSkillCtrl.GetRoleInBattle = function(self, isHero, index)
  -- function num : 0_120
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
  -- function num : 0_121 , upvalues : _ENV
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnDoodad, sender, targetRole)
end

LuaSkillCtrl.CallSheldBroken = function(self, sender, targetRole)
  -- function num : 0_122 , upvalues : _ENV
  self:BroadcastLuaTrigger(eSkillLuaTrigger.OnSheldBroken, sender, targetRole)
end

LuaSkillCtrl.RegisterLuaTrigger = function(self, luaTriggerId, action)
  -- function num : 0_123
  if self.luaTrigger == nil or action == nil or luaTriggerId == nil then
    return 
  end
  ;
  (self.luaTrigger):AddListener(luaTriggerId, action)
end

LuaSkillCtrl.UnRegisterLuaTrigger = function(self, luaTriggerId, action)
  -- function num : 0_124
  if self.luaTrigger == nil or action == nil or luaTriggerId == nil then
    return 
  end
  ;
  (self.luaTrigger):RemoveListener(luaTriggerId, action)
end

LuaSkillCtrl.UnRegisterLuaTriggerById = function(self, luaTriggerId)
  -- function num : 0_125
  if self.luaTrigger == nil then
    return 
  end
  if luaTriggerId ~= nil then
    (self.luaTrigger):RemoveListenerByType(luaTriggerId)
  end
end

LuaSkillCtrl.RemoveAllLuaTrigger = function(self)
  -- function num : 0_126
  if self.luaTrigger ~= nil then
    (self.luaTrigger):Clear()
    self.luaTrigger = nil
  end
end

LuaSkillCtrl.BroadcastLuaTrigger = function(self, luaTriggerId, ...)
  -- function num : 0_127
  if self.luaTrigger == nil or luaTriggerId == nil then
    return 
  end
  ;
  (self.luaTrigger):Broadcast(luaTriggerId, ...)
end

LuaSkillCtrl.OnDelete = function(self)
  -- function num : 0_128 , upvalues : _ENV
  if file ~= nil then
    file:write("战斗结束，持续帧数： " .. tostring((self.battleCtrl).frame) .. "\n\n\n\n\n\n")
    file:close()
  end
  self.cUltSkillCtrl = nil
  self.battleCtrl = nil
  self.cluaSkillCtrl = nil
  ;
  (self.logicTimerCtrl):StopAllTimer()
  sg = nil
  self:RemoveAllLuaTrigger()
end

return LuaSkillCtrl

