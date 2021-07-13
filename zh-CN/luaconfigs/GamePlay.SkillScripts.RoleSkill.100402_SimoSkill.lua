-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100402 = class("bs_100402", LuaSkillBase)
local base = LuaSkillBase
bs_100402.config = {effectId_trail = 10054, 
hurt_config = {hit_formula = 0, basehurt_formula = 10076, crit_formula = 0, crithur_ratio = 0}
, 
hurt_config_ex = {hit_formula = 0, basehurt_formula = 10076}
, audioId_attack = 16, skill_time = 27, actionId = 1002, selectId = 9, selectrange = 10}
bs_100402.ctor = function(self)
  -- function num : 0_0
end

bs_100402.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.attackTime = 0
end

bs_100402.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  if (self.arglist)[2] == 1 then
    self.attackTime = (self.arglist)[4]
  else
    self.attackTime = (self.arglist)[3]
  end
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, (self.config).selectrange)
  if targetList.Count == 0 then
    return 
  end
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, 1, 1, BindCallback(self, self.OnActionTrigger, targetList))
end

bs_100402.OnActionTrigger = function(self, targetList)
  -- function num : 0_3 , upvalues : _ENV
  local step = self.attackTime
  for j = 1, step do
    for i = 0, targetList.Count - 1 do
      local target = targetList[i]
      if (targetList[i]).targetRole ~= nil and ((targetList[i]).targetRole).intensity ~= 0 then
        LuaSkillCtrl:StartTimer(self, (step - self.attackTime) * (10 - step), (BindCallback(self, self.RealPlaySkill, (targetList[i]).targetRole)), nil, 0)
        self.attackTime = self.attackTime - 1
      end
      if self.attackTime <= 0 then
        return 
      end
    end
  end
end

bs_100402.RealPlaySkill = function(self, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  (self.caster):LookAtTarget(targetRole)
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_4_0 , upvalues : _ENV, targetRole, self
    LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId_trail, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_attack)
  end
)
end

bs_100402.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if (self.arglist)[2] > 0 then
      local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
      LuaSkillCtrl:PlayAuHit(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config_ex, nil, false)
      skillResult:EndResult()
    else
      do
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
        LuaSkillCtrl:PlayAuHit(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, false)
        skillResult:EndResult()
      end
    end
  end
end

bs_100402.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100402

