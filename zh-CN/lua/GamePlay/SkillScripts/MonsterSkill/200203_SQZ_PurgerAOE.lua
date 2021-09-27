local bs_200203 = class("bs_200203", LuaSkillBase)
local base = LuaSkillBase
bs_200203.config = {effectId = 10170, startAnimID = 1020, 
hurt_config = {basehurt_formula = 10007, hit_formula = 0, crit_formula = 0, correct_formula = 9989}
, audioId1 = 56, attackTime = 4, skill_speed = 1, skill_time = 28, start_time = 13, select_id = 48, select_range = 10}
bs_200203.ctor = function(self)
  -- function num : 0_0
end

bs_200203.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_200203.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
  if targetList.Count == 0 then
    return 
  end
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait((self.config).skill_time)
  local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, targetList)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, (self.config).skill_speed, (self.config).start_time, moveAttackTrigger)
end

bs_200203.OnMoveAttackTrigger = function(self, targetList)
  -- function num : 0_3 , upvalues : _ENV
  if (self.config).audioId1 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  end
  local index = 0
  for i = 0, (self.config).attackTime - 1 do
    if ((targetList[index]).targetRole).intensity == 0 then
      index = 0
    end
    if (targetList[index]).targetRole ~= nil then
      LuaSkillCtrl:CallEffect((targetList[index]).targetRole, (self.config).effectId, self, self.SkillEventFunc)
    end
    index = index + 1
    if targetList.Count <= index then
      index = 0
    end
  end
end

bs_200203.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_200203.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_200203

