-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_536 = class("bs_536", bs_1)
local base = bs_1
bs_536.config = {effectId_trail = 10777, effectId_start1 = 10775, effectId_start2 = 10776, effectId_skill = 10780, 
aoe = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, 
hurt = {basehurt_formula = 10055}
, effectId_start1_skill = 10784, effectId_start2_skill = 10784}
bs_536.config = setmetatable(bs_536.config, {__index = base.config})
bs_536.ctor = function(self)
  -- function num : 0_0
end

bs_536.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_536.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : _ENV
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  if self.attackNum > 1 then
    local prob = LuaSkillCtrl:CallRange(1, 2)
    if prob == 1 then
      if data.audioId2 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time2, function()
    -- function num : 0_2_0 , upvalues : _ENV, self, data
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
  end
)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2) * (self.config).baseActionSpd
      atkActionId = data.action2
      atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
      self.attackNum = 0
    else
      if data.audioId1 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
    -- function num : 0_2_1 , upvalues : _ENV, self, data
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
  end
)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkActionId = data.action1
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed) * (self.config).baseActionSpd
      self.attackNum = self.attackNum + 1
    end
  else
    do
      if data.audioId1 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
    -- function num : 0_2_2 , upvalues : _ENV, self, data
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
  end
)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1) * (self.config).baseActionSpd
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
      atkActionId = data.action1
      self.attackNum = self.attackNum + 1
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId)
      local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
      if waitTime > 0 then
        self:CallCasterWait(waitTime)
      end
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
      -- DECOMPILER ERROR at PC148: Confused about usage of register: R9 in 'UnsetPending'

      if (self.caster).attackRange == 1 then
        if data.effectId_1 ~= nil then
          if atkActionId == data.action1 then
            ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_1, self, nil, nil, atkSpeedRatio, true)
          else
            -- DECOMPILER ERROR at PC161: Confused about usage of register: R9 in 'UnsetPending'

            ;
            ((self.caster).recordTable)["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_2, self, nil, nil, atkSpeedRatio, true)
          end
        end
        if data.effectId_3 ~= nil then
          LuaSkillCtrl:StartTimer(self, atkTriggerFrame, function()
    -- function num : 0_2_3 , upvalues : _ENV, target, data, self, atkSpeedRatio
    LuaSkillCtrl:CallEffect(target, data.effectId_3, self, nil, nil, atkSpeedRatio)
  end
)
        end
      end
      if ((self.caster).recordTable).attack == 1 then
        if atkActionId == data.action1 then
          LuaSkillCtrl:CallEffect(target, data.effectId_start1, self, nil, nil, atkSpeedRatio, true)
        else
          LuaSkillCtrl:CallEffect(target, data.effectId_start2, self, nil, nil, atkSpeedRatio, true)
        end
      else
        if ((self.caster).recordTable).attack == 2 then
          if atkActionId == data.action1 then
            LuaSkillCtrl:CallEffect(target, data.effectId_start1_skill, self, nil, nil, atkSpeedRatio, true)
          else
            LuaSkillCtrl:CallEffect(target, data.effectId_start2_skill, self, nil, nil, atkSpeedRatio, true)
          end
        end
      end
    end
  end
end

bs_536.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_3 , upvalues : base, _ENV
  if ((self.caster).recordTable).attack == 1 then
    (base.OnAttackTrigger)(self, target, data, atkSpeedRatio, atkActionId)
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  if ((self.caster).recordTable).attack == 2 then
    ((self.caster).recordTable).lastAttackRole = target
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
      if data.effectId_skill ~= nil then
        if data.audioId4 ~= nil then
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
        end
        LuaSkillCtrl:CallEffectWithArg(target, data.effectId_skill, self, true, false, self.SkillEventFunc, data)
      end
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R5 in 'UnsetPending'

      if ((self.caster).recordTable).completeFirstComatk == nil then
        ((self.caster).recordTable).completeFirstComatk = true
      end
    else
      self:BreakSkill()
    end
  end
end

bs_536.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, configData.audioId5)
    end
    local arg = ((self.caster).recordTable).arg
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt, {arg})
    skillResult:EndResult()
  end
end

bs_536.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_536

