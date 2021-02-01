-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1041 = class("bs_1041", LuaSkillBase)
local base = LuaSkillBase
bs_1041.config = {effectId = 10054, 
hurt_config = {basehurt_formula = 10076}
, audioId1 = 16, audioId2 = 41}
bs_1041.ctor = function(self)
  -- function num : 0_0
end

bs_1041.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.attackTime = 0
end

bs_1041.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  if (self.arglist)[2] == 1 then
    self.attackTime = 6
  else
    self.attackTime = 5
  end
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count == 0 then
    return 
  end
  LuaSkillCtrl:CallRoleAction(self.caster, 1002)
  self:CallCasterWait(27)
  local step = self.attackTime
  for j = 1, step do
    for i = 0, targetList.Count - 1 do
      local target = targetList[i]
      if (targetList[i]).targetRole ~= nil and ((targetList[i]).targetRole).intensity ~= 0 then
        LuaSkillCtrl:StartTimer(self, (6 - self.attackTime) * 4, (BindCallback(self, self.RealPlaySkill, (targetList[i]).targetRole)), nil, 0)
        self.attackTime = self.attackTime - 1
      end
      if self.attackTime <= 0 then
        return 
      end
    end
  end
end

bs_1041.RealPlaySkill = function(self, targetRole)
  -- function num : 0_3 , upvalues : _ENV
  (self.caster):LookAtTarget(targetRole)
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_3_0 , upvalues : _ENV, targetRole, self
    LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self, self.SkillEventFunc)
  end
, nil, 0)
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_3_1 , upvalues : _ENV, self
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  end
)
end

bs_1041.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config, nil, false)
    skillResult:EndResult()
  end
end

bs_1041.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1041

