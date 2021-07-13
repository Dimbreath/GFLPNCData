-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102502 = class("bs_102502", LuaSkillBase)
local base = LuaSkillBase
bs_102502.config = {effectId1 = 10714, effectId2 = 10715, effectId3 = 10716, effectId4 = 10717, buffId_230 = 230, buffId_250 = 250, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10108, crit_formula = 0, correct_formula = 10105, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0}
, skill_time = 31, start_time = 17, actionId = 1002, action_speed = 1, gap_time = 10, select_target_id = 53}
bs_102502.ctor = function(self)
  -- function num : 0_0
end

bs_102502.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_102502_3", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.enemy)
  self.__linkData = {}
  self.__linkCount = 0
end

bs_102502.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastAttackRole
  local target, target2 = nil, nil
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local moveTarget = self:GetMoveSelectTarget()
    if moveTarget ~= nil then
      target = moveTarget.targetRole
    end
  end
  do
    if target ~= nil then
      local targetlist2 = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_target_id, 10, target)
      if targetlist2.Count > 0 then
        target2 = (targetlist2[0]).targetRole
      end
      if target2 == nil and (self.arglist)[3] == 0 then
        return false
      end
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, target2)
      ;
      (self.caster):LookAtTarget(target)
      self:CallCasterWait((self.config).skill_time)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
    end
  end
end

bs_102502.OnAttackTrigger = function(self, target, target2)
  -- function num : 0_3 , upvalues : _ENV
  if target2 ~= nil then
    if target.hp > 0 then
      LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self)
    end
    if target2.hp > 0 then
      LuaSkillCtrl:CallEffect(target2, (self.config).effectId1, self)
    end
    LuaSkillCtrl:StartTimer(nil, 10, function()
    -- function num : 0_3_0 , upvalues : target, target2, _ENV, self
    if target.hp <= 0 or target2.hp <= 0 then
      return 
    end
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_230, 1, (self.arglist)[1], true)
    LuaSkillCtrl:CallBuff(self, target2, (self.config).buffId_230, 1, (self.arglist)[1], true)
    local effect = LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self, nil, target2, nil, false)
    self:__SaveSkillLinkData(target, target2, effect)
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
      -- function num : 0_3_0_0 , upvalues : self, target, target2
      self:__ClearSkillLinkData(target, target2)
    end
)
  end
)
  else
    LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self)
    LuaSkillCtrl:StartTimer(nil, 10, function()
    -- function num : 0_3_1 , upvalues : target, _ENV, self
    if target.hp <= 0 then
      return 
    end
    LuaSkillCtrl:CallBuffLifeEvent(self, target, (self.config).buffId_250, 1, (self.arglist)[1], BindCallback(self, self.OnBuffLifeEvent))
  end
)
  end
end

bs_102502.OnBuffLifeEvent = function(self, lifeType, arg)
  -- function num : 0_4 , upvalues : _ENV
  if lifeType == eBuffLifeEvent.NewAdd then
    self.__linkCount = self.__linkCount + 1
  else
    if lifeType == eBuffLifeEvent.Remove then
      self.__linkCount = self.__linkCount - 1
      self:__JudgeLinkCount()
    end
  end
end

bs_102502.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_5 , upvalues : _ENV
  if target.hp <= 0 and target:GetBuffTier((self.config).buffId_230) > 0 then
    self:__ClearTargetSkillLinkData(target)
  end
  if target:GetBuffTier((self.config).buffId_230) == 1 and hurt > 0 and skill.dataId ~= 102502 and isTriggerSet ~= true then
    local links = (self.__linkData)[target]
    if links ~= nil then
      for _,t2 in ipairs(links) do
        if t2 ~= nil then
          local hurt_callback = BindCallback(self, self.Onhurt, t2, hurt)
          LuaSkillCtrl:CallEffect(t2, (self.config).effectId3, self, nil, target, nil, false)
          LuaSkillCtrl:StartTimer(nil, (self.config).gap_time, hurt_callback)
        end
      end
    end
  end
  do
    if target:GetBuffTier((self.config).buffId_250) == 1 and hurt > 0 and skill.dataId ~= 102502 and isTriggerSet ~= true and target ~= nil and target.hp > 0 then
      LuaSkillCtrl:CallEffect(target, (self.config).effectId4, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {hurt}, true, true)
      skillResult:EndResult()
    end
  end
end

bs_102502.Onhurt = function(self, target, hurt)
  -- function num : 0_6 , upvalues : _ENV
  if target == nil then
    return 
  end
  if target.hp > 0 then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId4, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {hurt}, true, true)
    skillResult:EndResult()
  end
end

bs_102502.__SaveSkillLinkData = function(self, t1, t2, effect)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  if (self.__linkData)[t1] == nil then
    (self.__linkData)[t1] = {}
  end
  ;
  (table.insert)((self.__linkData)[t1], t2)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.__linkData)[t1])[t2] = effect
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  if (self.__linkData)[t2] == nil then
    (self.__linkData)[t2] = {}
  end
  ;
  (table.insert)((self.__linkData)[t2], t1)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.__linkData)[t2])[t1] = effect
  self.__linkCount = self.__linkCount + 1
end

bs_102502.__ClearTargetSkillLinkData = function(self, target)
  -- function num : 0_8 , upvalues : _ENV
  local links = (self.__linkData)[target]
  if links == nil then
    return 
  end
  for _,t2 in ipairs(links) do
    local effect = ((self.__linkData)[target])[t2]
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.__linkData)[t2])[target] = nil
    ;
    (table.removebyvalue)((self.__linkData)[t2], target)
    effect:Die()
    self.__linkCount = self.__linkCount - 1
    if (table.count)((self.__linkData)[t2]) == 0 then
      LuaSkillCtrl:DispelBuff(t2, (self.config).buffId_230, 0, true)
    end
  end
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__linkData)[target] = nil
  self:__JudgeLinkCount()
end

bs_102502.__ClearSkillLinkData = function(self, t1, t2)
  -- function num : 0_9 , upvalues : _ENV
  local effect = nil
  if (self.__linkData)[t1] ~= nil and ((self.__linkData)[t1])[t2] ~= nil then
    effect = ((self.__linkData)[t1])[t2]
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.__linkData)[t1])[t2] = nil
    ;
    (table.removebyvalue)((self.__linkData)[t1], t2)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.__linkData)[t2])[t1] = nil
    ;
    (table.removebyvalue)((self.__linkData)[t2], t1)
    self.__linkCount = self.__linkCount - 1
  end
  if effect ~= nil then
    effect:Die()
  end
  self:__JudgeLinkCount()
end

bs_102502.__JudgeLinkCount = function(self)
  -- function num : 0_10 , upvalues : base
  if self.__linkCount <= 0 and self.__isCastDie then
    (base.OnCasterDie)(self)
  end
end

bs_102502.OnCasterDie = function(self)
  -- function num : 0_11
  self.__isCastDie = true
end

bs_102502.LuaDispose = function(self)
  -- function num : 0_12 , upvalues : base
  (base.LuaDispose)(self)
  self.__linkData = nil
end

return bs_102502

