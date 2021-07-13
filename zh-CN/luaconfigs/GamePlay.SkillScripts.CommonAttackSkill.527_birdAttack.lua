-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_527 = class("bs_527", bs_1)
local base = bs_1
bs_527.config = {action1 = 1001, action2 = 1001, buffId_26 = 26, 
HurtConfig = {basehurt_formula = 10086}
, effectId_bird = 10521}
bs_527.config = setmetatable(bs_527.config, {__index = base.config})
bs_527.ctor = function(self)
  -- function num : 0_0
end

bs_527.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.targetreal = ((self.caster).recordTable).attackTarget
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_527_10", 1, self.OnRoleDie)
  self.killcaster = nil
  self.time = ((self.caster).recordTable).time + 2
end

bs_527.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.targetreal then
    LuaSkillCtrl:DispelBuff(self.caster, 88, 0)
    LuaSkillCtrl:RemoveLife(999, self, self.caster, true, false, nil, false)
    ;
    (self.caster):BindHostEntity(nil)
  end
end

bs_527.RealPlaySkill = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV, base
  target = self.targetreal
  if target.hp <= 0 then
    LuaSkillCtrl:DispelBuff(self.caster, 88, 0)
    LuaSkillCtrl:RemoveLife(999, self, self.caster, true, false, nil, false)
    ;
    (self.caster):BindHostEntity(nil)
  end
  if self.killcaster == nil then
    self.killcaster = LuaSkillCtrl:StartTimer(nil, self.time, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    if self.killcaster ~= nil and (self.killcaster):IsOver() then
      self.killcaster = nil
    end
    if (self.caster).hp > 0 then
      LuaSkillCtrl:RemoveLife(999, self, self.caster, true, false, nil, false)
      self.killcaster = nil
    end
  end
, self)
  end
  if LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.NotBeSelected) or LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Exiled) then
    return 
  end
  ;
  (base.RealPlaySkill)(self, target, data)
end

bs_527.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_4 , upvalues : _ENV
  if data.audioId3 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
  end
  if not target.unableSelect then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_bird, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local arg = ((self.caster).recordTable).arg_1
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {arg})
    LuaSkillCtrl:PlayAuHit(self, target)
    skillResult:EndResult()
    local arg2 = ((self.caster).recordTable).arg_2
    local arg3 = ((self.caster).recordTable).arg_3
    if LuaSkillCtrl:CallRange(1, 1000) <= arg2 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_26, 1, arg3)
    end
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R9 in 'UnsetPending'

    if ((self.caster).recordTable).completeFirstComatk == nil then
      ((self.caster).recordTable).completeFirstComatk = true
    end
  else
    do
      self:BreakSkill()
    end
  end
end

bs_527.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_527

