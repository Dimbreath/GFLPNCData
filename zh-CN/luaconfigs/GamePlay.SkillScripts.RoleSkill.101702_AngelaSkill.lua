-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101702 = class("bs_101702", LuaSkillBase)
local base = LuaSkillBase
bs_101702.config = {antion1 = 1008, antion2 = 1007, antion3 = 1009, effectHealId = 10285, effectId_line = 10284, buffId_170 = 170, effectHitId = 10283, effectHitId2 = nil, 
heal_config = {baseheal_formula = 501, heal_number = 0, crit_formula = 0, crithur_ratio = 0, correct_formula = 9990}
, buffId_269 = 269, buffId_268 = 268, actionId = 1008, actionId_loop = 1007, actionId_end = 1009, action_speed = 2, skill_time = 13, start_time = 12, end_time = 15}
bs_101702.ctor = function(self)
  -- function num : 0_0
end

bs_101702.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Open = false
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Skill_target = nil
  local bind = self:GetSelfBindingObj()
  if bind ~= nil and ((self.caster).recordTable).books == nil then
    local bookArray = {}
    for i = 1, 3 do
      (table.insert)(bookArray, (bind.specialObj)[i])
    end
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.caster).recordTable).books = bookArray
  end
end

bs_101702.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, nil, ture)
  local target_skill = nil
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 58, 10)
  for i = 0, targetList.Count - 1 do
    local role = (targetList[i]).targetRole
    if role.intensity ~= 0 then
      target_skill = role
      break
    end
  end
  do
    do
      if target_skill == nil or target_skill.intensity == 1 then
        local tempTarget = self:GetMoveSelectTarget()
        target_skill = tempTarget.targetRole
      end
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

      if target_skill ~= nil then
        ((self.caster).recordTable).Skill_target = target_skill
        -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.caster).recordTable).Open = true
        self:CallCasterWait((self.config).skill_time + (self.arglist)[1] + (self.config).end_time)
        local attackTrigger = BindCallback(self, self.OnAttackTrigger, target_skill)
        ;
        (self.caster):LookAtTarget(target_skill)
        LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
        LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_2_0 , upvalues : self
    self:SetBookDisActive(1)
    self:SetBookActive(2)
  end
)
      end
    end
  end
end

bs_101702.SetBookActive = function(self, index)
  -- function num : 0_3
  local bookArray = ((self.caster).recordTable).books
  if bookArray == nil then
    return 
  end
  if bookArray[index] ~= nil then
    (bookArray[index]):SetActive(true)
  end
end

bs_101702.SetBookDisActive = function(self, index)
  -- function num : 0_4
  local bookArray = ((self.caster).recordTable).books
  if bookArray == nil then
    return 
  end
  if bookArray[index] ~= nil then
    (bookArray[index]):SetActive(false)
  end
end

bs_101702.OnAttackTrigger = function(self, target)
  -- function num : 0_5 , upvalues : _ENV
  (self.caster):LookAtTarget(target)
  do
    if target == nil then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 10001, 10)
      if targetList.Count > 0 then
        target = (targetList[0]).targetRole
      else
        return 
      end
    end
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable).Skill_target = target
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_269, 1, (self.arglist)[1])
    if (self.arglist)[6] > 0 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_268, 1, (self.arglist)[1])
    end
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_loop)
    self.loop = LuaSkillCtrl:CallEffect(target, (self.config).effectId_line, self, nil, nil, nil, true)
    self.loophit = LuaSkillCtrl:CallEffect(target, (self.config).effectHitId, self, nil, nil, nil, true)
    self.isEnd = false
    LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[1])
    local times = ((self.arglist)[1] + 1) // (self.arglist)[2] - 1
    self.checkTime = LuaSkillCtrl:StartTimer(self, (self.arglist)[2], function()
    -- function num : 0_5_0 , upvalues : target, self, _ENV
    if target.hp > 0 then
      local hurt = (self.caster).skill_intensity * (self.arglist)[3] // 1000 + target.maxHp * (self.arglist)[4] // 1000
      local min = (self.caster).skill_intensity * (self.arglist)[5] // 1000
      if min < hurt then
        hurt = min
      end
      LuaSkillCtrl:RemoveLife(hurt, self, target, true)
    else
      do
        self:End(target)
        if self.checkTime ~= nil and (self.checkTime):IsOver() then
          self.checkTime = nil
        end
      end
    end
  end
, self, times, (self.arglist)[2] - 1)
    LuaSkillCtrl:StartTimer(self, (self.arglist)[1], function()
    -- function num : 0_5_1 , upvalues : self, target
    if self.isEnd then
      return 
    end
    self:End(target)
  end
)
  end
end

bs_101702.End = function(self, target)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 1)
  self.isEnd = true
  if self.checkTime ~= nil then
    (self.checkTime):Stop()
    self.checkTime = nil
  end
  if self.loop ~= nil then
    (self.loop):Die()
    self.loop = nil
  end
  if self.loophit ~= nil then
    (self.loophit):Die()
    self.loophit = nil
  end
  LuaSkillCtrl:DispelBuff(target, (self.config).buffId_268, 0)
  LuaSkillCtrl:DispelBuff(target, (self.config).buffId_269, 0)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion3)
  LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_6_0 , upvalues : self
    self:CancleCasterWait()
  end
)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Skill_target = nil
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Open = false
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_6_1 , upvalues : self
    self:SetBookDisActive(2)
    self:SetBookActive(1)
  end
)
end

bs_101702.OnBreakSkill = function(self, role)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnBreakSkill)(self, role)
  if role == self.caster then
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    local target = ((self.caster).recordTable).Skill_target
    self.isEnd = true
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.caster).recordTable).Skill_target = nil
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.caster).recordTable).Open = false
    self:SetBookDisActive(2)
    self:SetBookActive(1)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 1)
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId_268, 0)
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId_269, 0)
  end
end

bs_101702.OnSkillRemove = function(self)
  -- function num : 0_8 , upvalues : base
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.caster).recordTable).books = nil
  ;
  (base.OnSkillRemove)(self)
end

bs_101702.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.caster).recordTable).books = nil
  ;
  (base.OnCasterDie)(self)
end

bs_101702.LuaDispose = function(self)
  -- function num : 0_10 , upvalues : base
  (base.LuaDispose)(self)
  self.loop = nil
  self.loophit = nil
end

return bs_101702

