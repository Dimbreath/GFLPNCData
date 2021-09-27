local bs_101702 = class("bs_101702", LuaSkillBase)
local base = LuaSkillBase
bs_101702.config = {
heal_config = {baseheal_formula = 501, heal_number = 0, crit_formula = 0, crithur_ratio = 0, correct_formula = 9990}
, actionId = 1008, actionId_loop = 1007, actionId_end = 1009, action_speed = 2, skill_time = 13, start_time = 12, end_time = 15, audioId1 = 101701, audioId2 = 101702, effectId_start = 101705, effectId_player = 101703, effectId_entiy = 101704}
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
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 58, 10)
  if targetList.Count == 0 then
    return 
  end
  local target_skill = (targetList[0]).targetRole
  if target_skill ~= nil then
    self:CallCasterWait((self.config).skill_time + (self.config).end_time)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target_skill)
    ;
    (self.caster):LookAtTarget(target_skill)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
    LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_2_0 , upvalues : self
    self:SetBookDisActive(1)
    self:SetBookActive(2)
  end
)
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
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = (targetList[i]).targetRole
      if role ~= nil and role.hp > 0 then
        LuaSkillCtrl:CallEffect(role, (self.config).effectId_player, self)
        LuaSkillCtrl:CallResetCDNumForRole(role, (self.arglist)[1])
      end
    end
  end
  do
    local down = -(self.arglist)[2]
    LuaSkillCtrl:CallResetMainSkillCDNumForTeam(target.belongNum, down)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = (targetList[i]).targetRole
        if role ~= nil and role.hp > 0 and role.intensity ~= 0 then
          LuaSkillCtrl:CallEffect(role, (self.config).effectId_entiy, self)
        end
      end
    end
    do
      self:End(target)
    end
  end
end

bs_101702.End = function(self, target)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_end)
  LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_6_0 , upvalues : self
    self:CancleCasterWait()
  end
)
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_6_1 , upvalues : self
    self:SetBookDisActive(2)
    self:SetBookActive(1)
  end
)
end

bs_101702.OnSkillRemove = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnSkillRemove)(self)
end

bs_101702.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_101702.LuaDispose = function(self)
  -- function num : 0_9 , upvalues : base
  (base.LuaDispose)(self)
end

return bs_101702

