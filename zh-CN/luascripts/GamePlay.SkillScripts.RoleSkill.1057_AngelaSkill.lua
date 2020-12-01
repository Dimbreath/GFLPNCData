-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1057 = class("bs_1057", LuaSkillBase)
local base = LuaSkillBase
bs_1057.config = {antion1 = 1008, antion2 = 1007, antion3 = 1009, effectHealId = 10285, effectId_line = 10284, CDbuffId = 170, effectHitId = 10283, effectHitId2 = nil, 
heal_config = {baseheal_formula = 501, heal_number = 0, crit_formula = 0, crithur_ratio = 0, correct_formula = 9990}
}
bs_1057.ctor = function(self)
  -- function num : 0_0
end

bs_1057.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Open = false
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Skill_target = nil
  local bind = self:GetSelfBindingObj()
  if ((self.caster).recordTable).books == nil then
    local bookArray = {}
    for i = 1, 3 do
      (table.insert)(bookArray, (bind.specialObj)[i])
    end
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.caster).recordTable).books = bookArray
  end
end

bs_1057.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).CDbuffId, 1)
  local targetList = (LuaSkillCtrl:CallTargetSelect(self, 32, 20))
  -- DECOMPILER ERROR at PC14: Overwrote pending register: R3 in 'AssignReg'

  local target_skill = .end
  if targetList.Count > 0 and targetList[0] ~= nil then
    for i = 0, targetList.Count - 1 do
      if ((targetList[i]).targetRole).intensity == 4 then
        target_skill = (targetList[i]).targetRole
        break
      end
    end
    do
      if target_skill == nil then
        for i = 0, targetList.Count - 1 do
          if ((targetList[i]).targetRole).intensity == 3 then
            target_skill = (targetList[i]).targetRole
            break
          end
        end
      end
      do
        if target_skill == nil then
          for i = 0, targetList.Count - 1 do
            if ((targetList[i]).targetRole).intensity == 2 then
              target_skill = (targetList[i]).targetRole
              break
            end
          end
        end
        do
          if target_skill == nil then
            target_skill = (targetList[0]).targetRole
          end
          -- DECOMPILER ERROR at PC73: Confused about usage of register: R4 in 'UnsetPending'

          ;
          ((self.caster).recordTable).Skill_target = target_skill
          -- DECOMPILER ERROR at PC76: Confused about usage of register: R4 in 'UnsetPending'

          ;
          ((self.caster).recordTable).Open = true
          self:CallCasterWait(25 + (self.arglist)[1] + 15)
          local attackTrigger = BindCallback(self, self.OnAttackTrigger, target_skill)
          ;
          (self.caster):LookAtTarget(target_skill)
          LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion1, 1, 24, attackTrigger)
          LuaSkillCtrl:StartTimer(self, 15, function()
    -- function num : 0_2_0 , upvalues : self
    self:SetBookDisActive(1)
    self:SetBookActive(2)
  end
)
        end
      end
    end
  end
end

bs_1057.SetBookActive = function(self, index)
  -- function num : 0_3
  local bookArray = ((self.caster).recordTable).books
  if bookArray == nil then
    return 
  end
  if bookArray[index] ~= nil then
    (bookArray[index]):SetActive(true)
  end
end

bs_1057.SetBookDisActive = function(self, index)
  -- function num : 0_4
  local bookArray = ((self.caster).recordTable).books
  if bookArray == nil then
    return 
  end
  if bookArray[index] ~= nil then
    (bookArray[index]):SetActive(false)
  end
end

bs_1057.OnAttackTrigger = function(self, target)
  -- function num : 0_5 , upvalues : _ENV
  (self.caster):LookAtTarget(target)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion2)
  self.loop = LuaSkillCtrl:CallEffect(target, (self.config).effectId_line, self)
  self.loophit = LuaSkillCtrl:CallEffect(target, (self.config).effectHitId, self)
  local hurt = target.maxHp * (self.arglist)[2] // 1000
  local Times = ((self.arglist)[1] + 1) // (self.arglist)[5] - 1
  self.isEnd = false
  self.checkTime = LuaSkillCtrl:StartTimer(self, (self.arglist)[5], function()
    -- function num : 0_5_0 , upvalues : target, _ENV, hurt, self
    if target.hp > 0 then
      LuaSkillCtrl:RemoveLife(hurt, self, target, true)
      if (self.arglist)[4] > 0 then
        LuaSkillCtrl:CallEffectWithArgOverride(self.caster, (self.config).effectHealId, self, target, false, self.SkillEventFunc, hurt)
      end
    end
    if target.hp <= 0 then
      self:End()
    end
  end
, self, Times, (self.arglist)[5] - 1)
  LuaSkillCtrl:StartTimer(self, (self.arglist)[1], function()
    -- function num : 0_5_1 , upvalues : self
    if self.isEnd then
      return 
    end
    self:End()
  end
)
end

bs_1057.End = function(self)
  -- function num : 0_6 , upvalues : _ENV
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
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion3)
  LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_6_0 , upvalues : self
    self:CancleCasterWait()
  end
)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Skill_target = nil
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Open = false
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_6_1 , upvalues : self, _ENV
    self:SetBookDisActive(2)
    self:SetBookActive(1)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).CDbuffId, 1)
  end
)
end

bs_1057.SkillEventFunc = function(self, hurt, effect, eventId, target)
  -- function num : 0_7 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger and effect.dataId == (self.config).effectHealId then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    local heal = hurt * (self.arglist)[3] // 1000
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {heal})
    skillResult:EndResult()
  end
end

bs_1057.OnBreakSkill = function(self, role)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnBreakSkill)(self, role)
  if role == self.caster then
    self.isEnd = true
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable).Skill_target = nil
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable).Open = false
    self:SetBookDisActive(2)
    self:SetBookActive(1)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).CDbuffId, 1)
  end
end

bs_1057.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1057

