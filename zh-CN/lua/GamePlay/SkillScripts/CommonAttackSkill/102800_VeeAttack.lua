local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102800 = class("bs_102800", bs_1)
local base = bs_1
bs_102800.config = {effectId_start1 = 10701, effectId_start2 = 10701, action1 = 1001, action2 = 1001, effectId_db = 10703, effectId_line = 10704, effectId_loop = 10705, effectId_hit = 10702, 
hurt_config = {hit_formula = 10051, crit_formula = 0}
, audioId1 = 266, audioId2 = 267, audioId5 = 268}
bs_102800.config = setmetatable(bs_102800.config, {__index = base.config})
bs_102800.ctor = function(self)
  -- function num : 0_0
end

bs_102800.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.db = nil
  self.db2 = nil
  self.loop = nil
  self.line = nil
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).passive = nil
end

bs_102800.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : _ENV, base
  if (self.caster).attackRange > 1 then
    self:CallSelectEffect()
    if target ~= ((self.caster).recordTable).passive then
      if self.db ~= nil then
        (self.db):Die()
        self.db = nil
        ;
        (self.db2):Die()
        self.db2 = nil
        ;
        (self.line):Die()
        self.line = nil
        ;
        (self.loop):Die()
        self.loop = nil
      end
      self.db = LuaSkillCtrl:CallEffect(target, (self.config).effectId_db, self)
      self.db2 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_db, self)
      self.line = LuaSkillCtrl:CallEffect(target, (self.config).effectId_line, self)
      self.loop = LuaSkillCtrl:CallEffect(target, (self.config).effectId_loop, self)
    end
    local actionSpeedRatio = 1
    local prob = (LuaSkillCtrl:CallRange(1, 2))
    local actionid = nil
    local time = 10
    if prob == 1 then
      actionid = 1004
      time = 7
      if data.audioId1 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
    -- function num : 0_2_0 , upvalues : _ENV, self, data
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
  end
)
      end
    else
      actionid = 1025
      time = 8
      if data.audioId2 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time2, function()
    -- function num : 0_2_1 , upvalues : _ENV, self, data
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
  end
)
      end
    end
    ;
    (self.caster):LookAtTarget(target)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger2, target, data, actionSpeedRatio, actionid, time)
    self:CallCasterWait(23)
    -- DECOMPILER ERROR at PC113: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = target
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, actionid, actionSpeedRatio, time, attackTrigger)
  else
    do
      ;
      (base.RealPlaySkill)(self, target, data)
    end
  end
end

bs_102800.OnAttackTrigger2 = function(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R6 in 'UnsetPending'

  ((self.caster).recordTable).lastAttackRole = target
  LuaSkillCtrl:CallEffect(target, 10727, self)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_hit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:PlayAuSource(target, (self.config).audioId5)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
  skillResult:EndResult()
  if target.hp <= 0 and self.db ~= nil then
    (self.db):Die()
    self.db = nil
    ;
    (self.db2):Die()
    self.db2 = nil
    ;
    (self.line):Die()
    self.line = nil
    ;
    (self.loop):Die()
    self.loop = nil
  end
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.caster).recordTable).passive = target
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R7 in 'UnsetPending'

  if ((self.caster).recordTable).completeFirstComatk == nil then
    ((self.caster).recordTable).completeFirstComatk = true
  end
  if self.isDoubleAttack then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  else
    do
      self:CancleCasterWait()
    end
  end
end

bs_102800.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.db ~= nil then
    (self.db):Die()
    self.db = nil
    ;
    (self.db2):Die()
    self.db2 = nil
    ;
    (self.line):Die()
    self.line = nil
    ;
    (self.loop):Die()
    self.loop = nil
  end
end

bs_102800.LuaDispose = function(self)
  -- function num : 0_5 , upvalues : base
  self.db = nil
  self.db2 = nil
  self.loop = nil
  self.line = nil
  self.loop = nil
  ;
  (base.LuaDispose)(self)
end

return bs_102800

