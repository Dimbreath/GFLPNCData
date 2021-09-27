local bs_103602 = class("bs_103602", LuaSkillBase)
local base = LuaSkillBase
bs_103602.config = {effectId1 = 10181, effectId2 = 10183, effectIdHit1 = 10182, effectIdHit2 = 10184, 
HurtConfig1 = {hit_formula = 0, basehurt_formula = 3000, crit_formula = 0, crithur_ratio = 0}
, 
HurtConfig2 = {hit_formula = 0, basehurt_formula = 3000, crit_formula = 10003}
, audioId1 = 113, skill_time = 30, start_time = 7, actionId = 1002, action_speed = 1}
bs_103602.ctor = function(self)
  -- function num : 0_0
end

bs_103602.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103602.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 38, 10)
  if targetList ~= nil and targetList.Count > 0 and targetList[0] ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
    ;
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    self:CallCasterWait((self.config).skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
  end
end

bs_103602.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  self.roll = LuaSkillCtrl:CallRange(1, 1000)
  if self.roll <= (self.caster).crit then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
    local Callback = BindCallback(self, self.OnCallback, 1, target, data)
    LuaSkillCtrl:StartTimer(self, 5, Callback, self)
  else
    do
      LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self)
      local Callback = BindCallback(self, self.OnCallback, 2, target, data)
      LuaSkillCtrl:StartTimer(self, 5, Callback, self)
    end
  end
end

bs_103602.OnCallback = function(self, num, target, data)
  -- function num : 0_4 , upvalues : _ENV
  local hurtpro = 1000 + target.hp * 1000 // target.maxHp * (self.arglist)[3] // (self.arglist)[2]
  local Arg = (self.arglist)[1] * hurtpro // 1000
  if num == 1 then
    LuaSkillCtrl:CallEffect(target, (self.config).effectIdHit2, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig2, {Arg})
    skillResult:EndResult()
  else
    do
      LuaSkillCtrl:CallEffect(target, (self.config).effectIdHit1, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:PlayAuHit(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig1, {Arg})
      skillResult:EndResult()
    end
  end
end

bs_103602.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103602

