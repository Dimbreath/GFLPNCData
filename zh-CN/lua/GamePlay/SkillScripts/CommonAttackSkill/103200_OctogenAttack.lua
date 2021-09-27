local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103200 = class("bs_103200", bs_1)
local base = bs_1
bs_103200.config = {effectId_trail = 103201, action1 = 1001, action2 = 1001, baseActionSpd = 1, skill_time = 46, start_time = 9, action_pass = 1004, effectId_ex = 103204, effectId_X = 103203, effectId_hit = 103207, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10086, crit_formula = 0, crithur_ratio = 0}
, audioId1 = 103201, time1 = 0, audioId2 = 103202, time2 = 0, audioId5 = 103203, audioId_pass = 103204}
bs_103200.config = setmetatable(bs_103200.config, {__index = base.config})
bs_103200.ctor = function(self)
  -- function num : 0_0
end

bs_103200.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103200.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : _ENV, base
  if ((self.caster).recordTable).passive == true then
    local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
    local atkSpeedRatio = 1
    local atkActionId = data.action_pass
    local atkTriggerFrame = 0
    atkSpeedRatio = self:CalcAtkActionSpeedForAirplane(atkSpeed, 2) * (self.config).baseActionSpd
    atkActionId = data.action_pass
    atkTriggerFrame = self:GetAtkTriggerFrameForAirplane(2, atkSpeed)
    local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CallCasterWait(atkSpeed + 2)
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = target
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).action_pass, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.caster).recordTable).passive = false
  else
    do
      ;
      (base.RealPlaySkill)(self, target, data)
    end
  end
end

bs_103200.CalcAtkActionSpeedForAirplane = function(self, atkInterval, atkId)
  -- function num : 0_3
  local atkTotalFrames = (self.config).skill_time
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

bs_103200.GetAtkTriggerFrameForAirplane = function(self, atkId, atkInterval)
  -- function num : 0_4
  local atkTotalFrames = (self.config).skill_time
  local triggerFrameCfg = (self.config).start_time
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

bs_103200.OnAttackTrigger2 = function(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_ex, self, self.SkillEventFunc2)
end

bs_103200.SkillEventFunc2 = function(self, effect, eventId, target)
  -- function num : 0_6 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:PlayAuSource(target.targetRole, (self.config).audioId_pass)
    LuaSkillCtrl:CallEffect(target.targetRole, (self.config).effectId_hit, self)
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult)
    skillResult:EndResult()
    local _Cskill = ((self.caster).recordTable).cs_Passive
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {((self.caster).recordTable).pass_arg})
    skillResult:EndResult()
    local grid_role = LuaSkillCtrl:GetGridWithRole(target.targetRole)
    local grid_X_list = LuaSkillCtrl:CallFindXLineGrid(grid_role, 1)
    if grid_X_list.Count > 0 then
      for i = 0, grid_X_list.Count - 1 do
        local target_grid = LuaSkillCtrl:GetTargetWithGrid((grid_X_list[i]).x, (grid_X_list[i]).y)
        if target_grid ~= nil then
          local cusEffect = LuaSkillCtrl:CallEffect(target, (self.config).effectId_X, self)
          local collisionTrigger = BindCallback(self, self.OnCollision, target)
          self.skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, target.targetRole, target_grid, 15, 5, 10, collisionTrigger, nil, nil, cusEffect, true, true, nil)
        end
      end
    end
  end
end

bs_103200.OnCollision = function(self, target, collider, index, entity)
  -- function num : 0_7 , upvalues : _ENV
  if entity ~= target.targetRole then
    local _Cskill = ((self.caster).recordTable).cs_Passive
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, entity)
    LuaSkillCtrl:PlayAuHit(self, entity)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {((self.caster).recordTable).pass_arg})
    skillResult:EndResult()
  end
end

bs_103200.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103200

