-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_33 = class("bs_33", bs_1)
local base = bs_1
bs_33.config = {effectstartId1 = 10701, effectstartId2 = 10701, action1 = 1001, action2 = 1001, effectId_db = 10703, effectId_line = 10704, effectId_loop = 10705, effectId_hit = 10702, 
hurt_config11 = {hit_formula = 10051, crit_formula = 0}
, 
hurt_config22 = {hit_formula = 10051, def_formula = 0, crit_formula = 0}
}
bs_33.config = setmetatable(bs_33.config, {__index = base.config})
bs_33.ctor = function(self)
  -- function num : 0_0
end

bs_33.InitSkill = function(self, isMidwaySkill)
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

bs_33.RealPlaySkill = function(self, target, data)
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
    local attackTrigger = BindCallback(self, self.OnAttackTrigger2, target)
    local prob = (LuaSkillCtrl:CallRange(1, 2))
    local actionid, time = nil, nil
    if prob == 1 then
      actionid = 1004
      time = 7
    else
      actionid = 1025
      time = 8
    end
    ;
    (self.caster):LookAtTarget(target)
    self:CallCasterWait(23)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, actionid, 1, time, attackTrigger)
  else
    do
      ;
      (base.RealPlaySkill)(self, target, data)
    end
  end
end

bs_33.OnAttackTrigger2 = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, 10727, self)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_hit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  if LuaSkillCtrl:CallRange(1, 1000) <= ((self.caster).recordTable).passive_roll then
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config22)
  else
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config11)
  end
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
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.caster).recordTable).passive = target
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R6 in 'UnsetPending'

  if ((self.caster).recordTable).completeFirstComatk == nil then
    ((self.caster).recordTable).completeFirstComatk = true
  end
  self:CancleCasterWait()
end

bs_33.OnCasterDie = function(self)
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

return bs_33

