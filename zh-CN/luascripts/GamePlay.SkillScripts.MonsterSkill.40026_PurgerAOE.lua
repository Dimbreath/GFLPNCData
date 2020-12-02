-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40026 = class("bs_40026", LuaSkillBase)
local base = LuaSkillBase
bs_40026.config = {effectId = 10170, startAnimID = 1020, 
hurt_config = {basehurt_formula = 10007}
, audioId1 = 56}
bs_40026.ctor = function(self)
  -- function num : 0_0
end

bs_40026.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_40026.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.attackTime = 4
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:CallRoleAction(self.caster, 1020)
  self:CallCasterWait(28)
  local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, target, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, 1, 13, moveAttackTrigger)
end

bs_40026.OnMoveAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  if (self.config).audioId1 ~= nil then
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count == 0 then
    return 
  end
  while self.attackTime ~= 0 do
    for i = targetList.Count - 1, 0, -1 do
      if (targetList[i]).targetRole ~= nil then
        LuaSkillCtrl:CallEffect((targetList[i]).targetRole, (self.config).effectId, self, self.SkillEventFunc)
        self.attackTime = self.attackTime - 1
      end
    end
  end
  do
    if self.attackTime > 0 then
    end
  end
end

bs_40026.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_40026.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40026

