local bs_100402 = class("bs_100402", LuaSkillBase)
local base = LuaSkillBase
bs_100402.config = {effectId_trail = 100403, 
hurt_config = {hit_formula = 0, basehurt_formula = 3000}
, skill_time = 27, actionId = 1002, selectId = 9, selectrange = 10}
bs_100402.ctor = function(self)
  -- function num : 0_0
end

bs_100402.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_100402.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, (self.config).selectrange)
  if targetList.Count == 0 then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return 
  end
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, 1, 1, BindCallback(self, self.OnActionTrigger, targetList))
end

bs_100402.OnActionTrigger = function(self, targetList)
  -- function num : 0_3 , upvalues : _ENV
  local step = (self.arglist)[2]
  for j = 1, step do
    for i = 0, targetList.Count - 1 do
      local targetRole = (targetList[i]).targetRole
      if targetRole ~= nil and targetRole.intensity ~= 0 then
        LuaSkillCtrl:StartTimer(self, ((self.arglist)[2] - step) * (10 - (self.arglist)[2]), (BindCallback(self, self.RealPlaySkill, targetRole)), nil, 0)
        step = step - 1
      end
      if step <= 0 then
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
  end
)
end

bs_100402.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]}, false)
    skillResult:EndResult()
  end
end

bs_100402.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100402

