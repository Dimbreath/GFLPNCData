local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_528 = class("bs_528", bs_1)
local base = bs_1
bs_528.config = {action1 = 1001, action2 = 1001, 
HurtConfig = {basehurt_formula = 10086}
}
bs_528.config = setmetatable(bs_528.config, {__index = base.config})
bs_528.ctor = function(self)
  -- function num : 0_0
end

bs_528.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.targetreal = ((self.caster).recordTable).attackTarget
  self.senderreal = ((self.caster).recordTable).senderTarget
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_528_10", 1, self.OnRoleDie)
  self:AddAfterHurtTrigger("bs_528_11", 1, self.OnAfterHurt, self.caster)
  self.killcaster = nil
  self.time = ((self.caster).recordTable).time + 2
end

bs_528.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster then
    local arg2 = ((self.caster).recordTable).arg_2
    local heal = hurt * arg2 // 1000
    if heal <= 0 then
      heal = 1
    end
    LuaSkillCtrl:CallHeal(heal, self, self.senderreal, true)
  end
end

bs_528.OnRoleDie = function(self, killer, role)
  -- function num : 0_3 , upvalues : _ENV
  if role == self.targetreal then
    LuaSkillCtrl:DispelBuff(self.caster, 88, 0)
    LuaSkillCtrl:RemoveLife(999, self, self.caster, false, nil, false, false, eHurtType.RealDmg)
    ;
    (self.caster):BindHostEntity(nil)
  end
end

bs_528.RealPlaySkill = function(self, target, data)
  -- function num : 0_4 , upvalues : _ENV, base
  target = self.targetreal
  if target.hp <= 0 then
    LuaSkillCtrl:DispelBuff(self.caster, 88, 0)
    LuaSkillCtrl:RemoveLife(999, self, self.caster, false, nil, false, false, eHurtType.RealDmg)
    ;
    (self.caster):BindHostEntity(nil)
  end
  if self.killcaster == nil then
    self.killcaster = LuaSkillCtrl:StartTimer(nil, self.time, function()
    -- function num : 0_4_0 , upvalues : self, _ENV
    if self.killcaster ~= nil and (self.killcaster):IsOver() then
      self.killcaster = nil
    end
    if (self.caster).hp > 0 then
      LuaSkillCtrl:RemoveLife(999, self, self.caster, false, nil, false, false, eHurtType.RealDmg)
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

bs_528.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_5 , upvalues : _ENV
  if data.audioId3 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
  end
  if not target.unableSelect then
    local arg = ((self.caster).recordTable).arg_1
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {arg})
    skillResult:EndResult()
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

    if ((self.caster).recordTable).completeFirstComatk == nil then
      ((self.caster).recordTable).completeFirstComatk = true
    end
  else
    do
      self:BreakSkill()
    end
  end
end

bs_528.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_528.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  self.targetreal = nil
  self.senderreal = nil
  ;
  (base.LuaDispose)(self)
end

return bs_528

