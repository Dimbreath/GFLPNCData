-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40031 = class("bs_40031", LuaSkillBase)
local base = LuaSkillBase
bs_40031.config = {buffId = 165, antion1 = 1008, antion2 = 1007, antion3 = 1009, effectId1 = 10237, effectId2 = 10238, 
HurtConfig = {hit_formula = 9991, def_formula = 9996, basehurt_formula = 10031, minhurt_formula = 9994, crit_formula = 9992, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
, audioId1 = 84, audioId2 = 85, audioId3 = 86, buffId196 = 196}
bs_40031.ctor = function(self)
  -- function num : 0_0
end

bs_40031.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_40031.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetlast = ((self.caster).recordTable).lastAttackRole
  if targetlast == nil or targetlast.hp <= 0 or (targetlast.recordTable).isPhaseSelect then
    targetlast = nil
    local selectTargets = LuaSkillCtrl:CallTargetSelect(self, 40, 10)
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
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (targetlast.recordTable).isPhaseSelect = true
    end
    ;
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    self:CallCasterWait(150)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId196, 1, 60)
    LuaSkillCtrl:CallBuff(self, targetlast, 124, 1, 20)
    local grid = LuaSkillCtrl:FindEmptyGridWithinRange(targetlast, 3)
    if IsNull(grid) then
      self:CancleCasterWait()
      return 
    end
    self.loopEfc = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
    ;
    (self.caster):LookAtTargetDir(LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y), targetlast)
    self.loopaudio = ((self.caster).auSource):PlayAudioById((self.config).audioId2)
    LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, self.caster, grid.x, grid.y, 8, 69)
    LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, function(table, grid)
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallRoleAction(self.caster, 1007)
  end
, grid))
    local arriveCallBack = BindCallback(self, self.OnArriveAction, targetlast)
    local phaseMove = BindCallback(self, function(table, targetlast)
    -- function num : 0_2_1 , upvalues : self, _ENV, arriveCallBack, grid
    (self.caster):LookAtTarget(targetlast)
    local afterRotation = BindCallback(self, function(table, grid)
      -- function num : 0_2_1_0 , upvalues : _ENV, self, targetlast, arriveCallBack
      LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, targetlast.x, targetlast.y, 3, 69)
      LuaSkillCtrl:StartTimer(self, 3, arriveCallBack)
    end
, grid)
    LuaSkillCtrl:StartTimer(self, 3, afterRotation)
  end
, targetlast)
    LuaSkillCtrl:StartTimer(self, 8, phaseMove)
  end
end

bs_40031.OnArriveAction = function(self, targetRole)
  -- function num : 0_3 , upvalues : _ENV
  AudioManager:StopAudioByBack(self.loopaudio)
  if self.loopEfc ~= nil then
    (self.loopEfc):Die()
    self.loopEfc = nil
  end
  ;
  ((self.caster).auSource):PlayAudioById((self.config).audioId3)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1009)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
  skillResult:EndResult()
  LuaSkillCtrl:DispelBuff(targetRole, 124, 1)
  LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, 1, 13)
  local maxRange = 3
  local grid = nil
  for tempRange = 1, maxRange do
    grid = LuaSkillCtrl:FindEmptyGridWithinRange(targetRole, tempRange)
    if grid ~= nil then
      LuaSkillCtrl:CallPhaseMove(self, targetRole, grid.x, grid.y, 5, 69)
      break
    end
  end
  do
    if grid == nil then
      grid = LuaSkillCtrl:FindEmptyGrid()
      if grid == nil then
        error("cant find empty grid")
        self:CancleCasterWait()
        return 
      end
      LuaSkillCtrl:CallPhaseMove(self, targetRole, grid.x, grid.y, 5, 69)
    end
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId196, 1)
    LuaSkillCtrl:StartTimer(nil, 6, function()
    -- function num : 0_3_0 , upvalues : self
    self:CancleCasterWait()
  end
)
    -- DECOMPILER ERROR at PC119: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (targetRole.recordTable).isPhaseSelect = nil
  end
end

bs_40031.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40031

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40031 = class("bs_40031", LuaSkillBase)
local base = LuaSkillBase
bs_40031.config = {
    buffId = 165,
    antion1 = 1008,
    antion2 = 1007,
    antion3 = 1009,
    effectId1 = 10237,
    effectId2 = 10238,
    HurtConfig = {
        hit_formula = 9991,
        def_formula = 9996,
        basehurt_formula = 10031,
        minhurt_formula = 9994,
        crit_formula = 9992,
        crithur_ratio = 9995,
        correct_formula = 9989,
        lifesteal_formula = 1001,
        spell_lifesteal_formula = 1002,
        returndamage_formula = 1000
    },
    audioId1 = 84,
    audioId2 = 85,
    audioId3 = 86,
    buffId196 = 196
}
bs_40031.ctor = function(self)
    -- function num : 0_0
end

bs_40031.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_40031.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local targetlast = ((self.caster).recordTable).lastAttackRole
    if targetlast == nil or targetlast.hp <= 0 or
        (targetlast.recordTable).isPhaseSelect then
        targetlast = nil
        local selectTargets = LuaSkillCtrl:CallTargetSelect(self, 40, 10)
        local targetCount = selectTargets.Count
        if targetCount > 0 then
            for i = 0, targetCount - 1 do
                if (selectTargets[i]).targetRole ~= nil and
                    not (((selectTargets[i]).targetRole).recordTable).isPhaseSelect then
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
            -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'


            (targetlast.recordTable).isPhaseSelect = true
        end
        ((self.caster).auSource):PlayAudioById((self.config).audioId1)
        self:CallCasterWait(150)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId196, 1, 60)
        LuaSkillCtrl:CallBuff(self, targetlast, 124, 1, 20)
        local grid = LuaSkillCtrl:FindEmptyGridWithinRange(targetlast, 3)
        if IsNull(grid) then
            self:CancleCasterWait()
            return
        end
        self.loopEfc = LuaSkillCtrl:CallEffect(self.caster,
                                               (self.config).effectId1, self);
        (self.caster):LookAtTargetDir(LuaSkillCtrl:GetTargetWithGrid(grid.x,
                                                                     grid.y),
                                      targetlast)
        self.loopaudio = ((self.caster).auSource):PlayAudioById(
                             (self.config).audioId2)
        LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, self.caster, grid.x, grid.y,
                                              8, 69)
        LuaSkillCtrl:StartTimer(self, 3,
                                BindCallback(self, function(table, grid)
            -- function num : 0_2_0 , upvalues : _ENV, self
            LuaSkillCtrl:CallRoleAction(self.caster, 1007)
        end, grid))
        local arriveCallBack = BindCallback(self, self.OnArriveAction,
                                            targetlast)
        local phaseMove = BindCallback(self, function(table, targetlast)
            -- function num : 0_2_1 , upvalues : self, _ENV, arriveCallBack, grid
            (self.caster):LookAtTarget(targetlast)
            local afterRotation = BindCallback(self, function(table, grid)
                -- function num : 0_2_1_0 , upvalues : _ENV, self, targetlast, arriveCallBack
                LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self,
                                                                 self.caster,
                                                                 targetlast.x,
                                                                 targetlast.y,
                                                                 3, 69)
                LuaSkillCtrl:StartTimer(self, 3, arriveCallBack)
            end, grid)
            LuaSkillCtrl:StartTimer(self, 3, afterRotation)
        end, targetlast)
        LuaSkillCtrl:StartTimer(self, 8, phaseMove)
    end
end

bs_40031.OnArriveAction = function(self, targetRole)
    -- function num : 0_3 , upvalues : _ENV
    AudioManager:StopAudioByBack(self.loopaudio)
    if self.loopEfc ~= nil then
        (self.loopEfc):Die()
        self.loopEfc = nil
    end
    ((self.caster).auSource):PlayAudioById((self.config).audioId3)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
    LuaSkillCtrl:CallRoleAction(self.caster, 1009)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
    LuaSkillCtrl:DispelBuff(targetRole, 124, 1)
    LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, 1, 13)
    local maxRange = 3
    local grid = nil
    for tempRange = 1, maxRange do
        grid = LuaSkillCtrl:FindEmptyGridWithinRange(targetRole, tempRange)
        if grid ~= nil then
            LuaSkillCtrl:CallPhaseMove(self, targetRole, grid.x, grid.y, 5, 69)
            break
        end
    end
    do
        if grid == nil then
            grid = LuaSkillCtrl:FindEmptyGrid()
            if grid == nil then
                error("cant find empty grid")
                self:CancleCasterWait()
                return
            end
            LuaSkillCtrl:CallPhaseMove(self, targetRole, grid.x, grid.y, 5, 69)
        end
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId196, 1)
        LuaSkillCtrl:StartTimer(nil, 6, function()
            -- function num : 0_3_0 , upvalues : self
            self:CancleCasterWait()
        end) -- DECOMPILER ERROR at PC119: Confused about usage of register: R5 in 'UnsetPending'
        ;
        (targetRole.recordTable).isPhaseSelect = nil
    end
end

bs_40031.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40031

