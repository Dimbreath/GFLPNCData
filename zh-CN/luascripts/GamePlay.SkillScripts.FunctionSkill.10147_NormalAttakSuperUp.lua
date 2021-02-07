-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10147 = class("bs_10147", LuaSkillBase)
local base = LuaSkillBase
bs_10147.config = {buffId = 1028, buffTier = 1, effectId1 = 10252, effectId2 = 10253, effectId = 10336, effectIdAttack = 10254, 
hurt_config = {basehurt_formula = 10032}
}
bs_10147.ctor = function(self)
  -- function num : 0_0
end

bs_10147.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10147_3", 3, self.OnAfterPlaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_10147_3", 2, self.OnAfterHurt)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10147_1", 1, self.OnBeforePlaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10147_10", 4, self.OnRoleDie)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10147_attackflag"] = false
end

bs_10147.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  if skill.maker == self.caster and not skill.isCommonAttack then
    ((self.caster).recordTable)["10147_attackflag"] = true
  end
end

bs_10147.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if skill.maker == self.caster and skill.isCommonAttack and ((self.caster).recordTable)["10147_attackflag"] and not isTriggerSet then
    local lastAtkRole = ((self.caster).recordTable).lastComAttackRole
    if lastAtkRole ~= nil then
      local loopTime = (self.arglist)[3] // (self.arglist)[1]
      local arriveCallBack = BindCallback(self, self.OnArriveAction, lastAtkRole)
      self.timer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], arriveCallBack, self, loopTime, (self.arglist)[1])
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["10147_attackflag"] = false
    end
  end
end

bs_10147.OnArriveAction = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Unhandled construct in 'MakeBoolean' P1

  if role.hp == 0 and self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  LuaSkillCtrl:CallEffect(role, (self.config).effectIdAttack, self, self.SkillEventFunc)
end

bs_10147.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10147.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_6
  local tier = (self.caster):GetBuffTier((self.config).buffId)
  if role == self.caster and (context.skill).isCommonAttack and tier > 0 then
    local passdata = {effectId = (self.config).effectId}
    context.passdata = passdata
  end
end

bs_10147.OnRoleDie = function(self, killer, role)
  -- function num : 0_7
  if role == ((self.caster).recordTable).lastComAttackRole and self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

bs_10147.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10147

