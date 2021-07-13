-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101902 = class("bs_101902", LuaSkillBase)
local base = LuaSkillBase
bs_101902.config = {effectId_skill = 10688, buffId_223 = 223, buffId_66 = 66, effectId_fly = 10690, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0}
, 
Aoe = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, skill_time = 30, start_time = 13, actionId = 1020, action_speed = 1}
bs_101902.ctor = function(self)
  -- function num : 0_0
end

bs_101902.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101902.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local target = ((self.caster).recordTable).lastAttackRole
  do
    if target == nil or target.hp <= 0 or target.belongNum == eBattleRoleBelong.neutral then
      local tempTarget = self:GetMoveSelectTarget()
      target = tempTarget.targetRole
    end
    if target ~= nil then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
      ;
      (self.caster):LookAtTarget(target)
      self:CallCasterWait((self.config).skill_time)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
    end
  end
end

bs_101902.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_fly, self)
  LuaSkillCtrl:StartTimer(nil, 16, function()
    -- function num : 0_3_0 , upvalues : _ENV, self, target
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_223, 1, 20, true)
    local target2 = LuaSkillCtrl:CallTargetSelect(self, 21, 10)
    LuaSkillCtrl:StartTimer(nil, 20, function()
      -- function num : 0_3_0_0 , upvalues : _ENV, target, self
      LuaSkillCtrl:CallEffect(target, (self.config).effectId_skill, self, self.SkillEventFunc)
    end
)
    if target2.Count <= 0 or (target2[0]).targetRole == target then
      return 
    end
    local grid = LuaSkillCtrl:FindEmptyGridWithoutEfcGridOfTypeAroundRole((target2[0]).targetRole, eEffectGridType.positive)
    if grid ~= nil and target.hp > 0 and target:GetBuffTier((self.config).buffId_223) > 0 then
      LuaSkillCtrl:CallPhaseMove(self, target, grid.x, grid.y, 20, 63)
    end
  end
)
end

bs_101902.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Create then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).Aoe)
    do
      if (self.arglist)[3] > 0 then
        skillResult:BuffResult((self.config).buffId_66, 1, (self.arglist)[2])
      else
        LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId_66, 1, (self.arglist)[2])
      end
      LuaSkillCtrl:StartTimer(nil, 3, function()
    -- function num : 0_4_0 , upvalues : _ENV, self, target, skillResult
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
  end
)
    end
  end
end

bs_101902.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101902

