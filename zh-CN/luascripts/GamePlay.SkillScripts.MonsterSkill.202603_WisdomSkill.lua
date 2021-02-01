-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202603 = class("bs_202603", LuaSkillBase)
local base = LuaSkillBase
bs_202603.config = {effectIdline = 10447, effectIdmiao = 10448, effectId = 10449, effectIdtrail = 10450, antion1 = 1008, antion2 = 1007, antion3 = 1009, buffId196 = 196, 
HurtConfig = {hit_formula = 0, def_formula = 0, basehurt_formula = 10055, crit_formula = 0, isRealDmg = true}
}
bs_202603.ctor = function(self)
  -- function num : 0_0
end

bs_202603.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202603.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local moveTarget = self:GetMoveSelectTarget()
  do
    if moveTarget ~= nil then
      local curAtkRole = moveTarget.targetRole
      if curAtkRole ~= nil then
        if self.lastAttackRole ~= curAtkRole then
          self.displaySelectEfc = true
        end
        self.lastAttackRole = curAtkRole
      end
    end
    local role = moveTarget.targetRole
    if role ~= nil then
      self:CallCasterWait(15 + (self.arglist)[1] + 18)
      local role = moveTarget.targetRole
      ;
      (self.caster):LookAtTarget(role)
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, role)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion1, 1, 15, attackTrigger)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId196, 1, (self.arglist)[1] + 15)
      self.loop = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
    end
  end
end

bs_202603.OnAttackTrigger = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  self.loopline = LuaSkillCtrl:CallEffect(role, (self.config).effectIdline, self, nil, nil, nil, true)
  self.loopMZ = LuaSkillCtrl:CallEffect(role, (self.config).effectIdmiao, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion2)
  local boom = BindCallback(self, self.Onboom, role)
  LuaSkillCtrl:StartTimer(self, (self.arglist)[1], boom, self)
end

bs_202603.Onboom = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  if role.hp > 0 then
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion3)
    LuaSkillCtrl:CallEffect(role, (self.config).effectIdtrail, self, self.SkillEventFunc)
    LuaSkillCtrl:StartTimer(self, 18, function()
    -- function num : 0_4_0 , upvalues : self
    self:CancleCasterWait()
    if self.loop ~= nil then
      (self.loop):Die()
      self.loop = nil
    end
  end
)
  end
  if self.loopMZ ~= nil then
    (self.loopMZ):Die()
    self.loopMZ = nil
  end
  if self.loopline ~= nil then
    (self.loopline):Die()
    self.loopline = nil
  end
  if role.hp <= 0 then
    self:CancleCasterWait()
    if self.loop ~= nil then
      (self.loop):Die()
      self.loop = nil
    end
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
  end
end

bs_202603.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local arg = (self.arglist)[2]
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {arg})
    skillResult:EndResult()
  end
end

bs_202603.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202603

