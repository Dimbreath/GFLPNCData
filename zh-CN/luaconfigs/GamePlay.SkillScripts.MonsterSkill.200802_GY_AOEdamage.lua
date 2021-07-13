-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40000 = class("40000_AOEdamage", LuaSkillBase)
local base = LuaSkillBase
bs_40000.config = {attackdelay = 15, effectId1 = 10124, effectId2 = 10125, audioId1 = 54, 
hurtConfig = {basehurt_formula = 10012, hit_formula = 0, crit_formula = 0, correct_formula = 9989}
, skill_time = 30, skill_speed = 1, start_time = 5, startAnimId = 1002, select_id = 9, select_range = 10}
bs_40000.ctor = function(self)
  -- function num : 0_0
end

bs_40000.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_40000.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimId, (self.config).skill_speed, (self.config).start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, true)
end

bs_40000.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
  if targetList.Count <= 0 then
    return 
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallEffectWithArg((targetList[i]).targetRole, (self.config).effectId2, self, false, false, self.SkillEventFunc)
  end
end

bs_40000.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if effect.dataId == (self.config).effectId2 and eventId == eBattleEffectEvent.Trigger then
    local targetRole = target.targetRole
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurtConfig)
    skillResult:EndResult()
  end
end

bs_40000.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40000

