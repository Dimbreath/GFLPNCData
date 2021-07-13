-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40031 = class("bs_40031", LuaSkillBase)
local base = LuaSkillBase
bs_40031.config = {buffId_63 = 63, buffId_69 = 69, buffId_50 = 50, PhaseMoveDuration = 8, PhaseMoveDuration2 = 16, buffId_124 = 278, duration_124 = 180, buffId_165 = 165, duration_165 = 13, buffId_196 = 196, duration_196 = 90, buffID_1158 = 1158, antion1 = 1008, antion2 = 1007, antion3 = 1009, findGridRange = 3, effectId1 = 10237, effectId2 = 10238, effectId3 = 10861, effectId4 = 10867, audioId1 = 84, audioId2 = 85, audioId3 = 86, 
HurtConfig = {hit_formula = 0, def_formula = 9996, basehurt_formula = 10031, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
, select_id = 40, select_id2 = 19, select_range = 10, skill_time = 999}
bs_40031.ctor = function(self)
  -- function num : 0_0
end

bs_40031.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.skill_open = false
end

bs_40031.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.skill_open = true
  local targetlast = ((self.caster).recordTable).lastAttackRole
  do
    if ((self.caster).recordTable)["20036_root2arg"] then
      local temTarget = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id2, (self.config).select_range)
      targetlast = (temTarget[0]).targetRole
    end
    if targetlast == nil or targetlast.hp <= 0 or (targetlast.recordTable).isPhaseSelect or targetlast.intensity == 0 then
      targetlast = nil
      local selectTargets = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
      local targetCount = selectTargets.Count
      if targetCount > 0 then
        for i = 0, targetCount - 1 do
          if (selectTargets[i]).targetRole ~= nil and not (((selectTargets[i]).targetRole).recordTable).isPhaseSelect then
            targetlast = (selectTargets[i]).targetRole
            break
          end
        end
      end
    end
    do
      if targetlast == nil then
        return 
      else
        -- DECOMPILER ERROR at PC66: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (targetlast.recordTable).isPhaseSelect = true
      end
      LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
      self:CallCasterWait((self.config).skill_time, true)
      self:AbandonSkillCdAutoReset(true)
      local buffAction = BindCallback(self, self.OnActionTrigger1, targetlast)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion1, 1, 30, buffAction)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_196, 1, (self.config).duration_196)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_50, 1, (self.config).duration_196)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffID_1158, 1)
      LuaSkillCtrl:StartTimer(nil, 6, function()
    -- function num : 0_2_0 , upvalues : _ENV, targetlast, self
    LuaSkillCtrl:CallEffect(targetlast, (self.config).effectId3, self)
    self.effect0 = LuaSkillCtrl:CallEffect(targetlast, (self.config).effectId4, self)
    LuaSkillCtrl:CallBuff(self, targetlast, (self.config).buffId_124, 1, (self.config).duration_124)
  end
)
    end
  end
end

bs_40031.OnActionTrigger1 = function(self, targetlast)
  -- function num : 0_3 , upvalues : _ENV
  self:Onboolen(targetlast)
  if self.skill_open == false then
    return 
  end
  local grid = LuaSkillCtrl:FindEmptyGridWithinRange(targetlast, (self.config).findGridRange)
  if IsNull(grid) then
    self:CancleCasterWait()
    self:CallNextBossSkill()
    return 
  end
  ;
  (self.caster):LookAtTargetDir(LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y), targetlast)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, self.caster, grid.x, grid.y, (self.config).PhaseMoveDuration2, (self.config).buffId_69)
  LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, function(table, grid)
    -- function num : 0_3_0 , upvalues : self, targetlast, _ENV
    self:Onboolen(targetlast)
    if self.skill_open == false then
      return 
    end
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion2)
  end
, grid))
  local arriveCallBack = BindCallback(self, self.OnArriveAction, targetlast)
  local phaseMove = BindCallback(self, function(table, targetlast)
    -- function num : 0_3_1 , upvalues : self, _ENV, arriveCallBack, grid
    self:Onboolen(targetlast)
    ;
    (self.caster):LookAtTarget(targetlast)
    local afterRotation = BindCallback(self, function(table, grid)
      -- function num : 0_3_1_0 , upvalues : self, targetlast, _ENV, arriveCallBack
      self:Onboolen(targetlast)
      if self.skill_open == false then
        return 
      end
      LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, targetlast.x, targetlast.y, 3, 69)
      LuaSkillCtrl:StartTimer(self, 3, arriveCallBack)
    end
, grid)
    self:Onboolen(targetlast)
    if self.skill_open == false then
      return 
    end
    self.loopEfc = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, true)
    LuaSkillCtrl:StartTimer(self, 26, afterRotation)
  end
, targetlast)
  LuaSkillCtrl:StartTimer(self, (self.config).PhaseMoveDuration, phaseMove)
end

bs_40031.Onboolen = function(self, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  if LuaSkillCtrl:RoleContainsBuffFeature(targetRole, eBuffFeatureType.NotBeSelected) and self.skill_open == true then
    LuaSkillCtrl:DispelBuff(targetRole, (self.config).buffId_124, 0)
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    if self.loopEfc ~= nil then
      (self.loopEfc):Die()
      self.loopEfc = nil
    end
    self:CancleCasterWait()
    self:CallNextBossSkill()
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (targetRole.recordTable).isPhaseSelect = nil
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 0)
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
    self.skill_open = false
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
  end
end

bs_40031.OnArriveAction = function(self, targetRole)
  -- function num : 0_5 , upvalues : _ENV
  do
    if self.skill_open == false then
      local grid = LuaSkillCtrl:FindEmptyGrid(nil)
      if grid == nil then
        return 
      end
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_up, self)
      LuaSkillCtrl:SetRolePos(grid, self.caster)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_down, self)
      return 
    end
    LuaSkillCtrl:DispelBuff(targetRole, (self.config).buffId_124, 0, true)
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    if self.loopEfc ~= nil then
      (self.loopEfc):Die()
      self.loopEfc = nil
    end
    if self.effect0 ~= nil then
      (self.effect0):Die()
      self.effect0 = nil
    end
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId3)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion3)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:PlayAuHit(self, targetRole)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
    if targetRole.hp > 0 then
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId_165, 1, (self.config).duration_165)
      local maxRange = (self.config).findGridRange
      local grid = nil
      for tempRange = 1, maxRange do
        grid = LuaSkillCtrl:FindEmptyGridWithinRange(targetRole, tempRange)
        if grid ~= nil then
          LuaSkillCtrl:CallPhaseMove(self, targetRole, grid.x, grid.y, 5, (self.config).buffId_63)
          break
        end
      end
      do
        do
          if grid == nil then
            grid = LuaSkillCtrl:FindEmptyGrid()
            if grid == nil then
              error("cant find empty grid")
              self:CancleCasterWait()
              self:CallNextBossSkill()
              return 
            end
            LuaSkillCtrl:CallPhaseMove(self, targetRole, grid.x, grid.y, 5, (self.config).buffId_63)
          end
          LuaSkillCtrl:StartTimer(nil, 46, function()
    -- function num : 0_5_0 , upvalues : self, _ENV
    self:CancleCasterWait()
    self:CallNextBossSkill()
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 1)
  end
)
          -- DECOMPILER ERROR at PC167: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (targetRole.recordTable).isPhaseSelect = nil
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
          self.skill_open = false
        end
      end
    end
  end
end

bs_40031.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
  if self.effect0 ~= nil then
    (self.effect0):Die()
    self.effect0 = nil
  end
end

bs_40031.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  (base.LuaDispose)(self)
  self.loopEfc = nil
  self.loopaudio = nil
end

return bs_40031

