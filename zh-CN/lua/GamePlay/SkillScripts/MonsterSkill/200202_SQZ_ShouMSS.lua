local bs_200202 = class("bs_200202", LuaSkillBase)
local base = LuaSkillBase
bs_200202.config = {
hurt_config = {basehurt_formula = 10013, hit_formula = 0, crit_formula = 0, correct_formula = 9989}
, damageFormula = 10013, startAnimID = 1002, EffectId = 10090, audioId1 = 56, atk_range = 3, skill_time = 25, skill_speed = 1, start_time = 13}
bs_200202.ctor = function(self)
  -- function num : 0_0
end

bs_200202.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_200202.PlaySkill = function(self, data)
  -- function num : 0_2
  if ((self.caster).recordTable).lastAttackRole ~= nil then
    self:DamageAnimation(((self.caster).recordTable).lastAttackRole)
  else
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
      if moveTarget.targetRole ~= nil then
        self:DamageAnimation(moveTarget.targetRole)
      end
    end
  end
end

bs_200202.DamageAnimation = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.config).atk_range) then
    local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, target)
    self:CallCasterWait((self.config).skill_time)
    ;
    (self.caster):LookAtTarget(target)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, (self.config).skill_speed, (self.config).start_time, moveAttackTrigger)
  else
    do
      self:BreakSkill()
    end
  end
end

bs_200202.OnMoveAttackTrigger = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallEffect(target, (self.config).EffectId, self, self.SkillEventFunc)
end

bs_200202.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_200202.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_200202.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  (base.LuaDispose)(self)
  self.lastAttackRole = nil
end

return bs_200202

