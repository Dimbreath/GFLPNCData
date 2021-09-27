local bs_202402 = class("bs_202402", LuaSkillBase)
local base = LuaSkillBase
bs_202402.config = {effectId1 = 10438, effectId2 = 10439, 
hurtConfig = {basehurt_formula = 10055, hit_formula = 0, crit_formula = 0, correct_formula = 9989}
, select_id = 9, select_range = 0, startAnimId = 1002, start_time = 13, skill_time = 20, audioId1 = 313}
bs_202402.ctor = function(self)
  -- function num : 0_0
end

bs_202402.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202402.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
  if targetlist.Count > 0 then
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    self:CallCasterWait((self.config).skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimId, 1, (self.config).start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  end
end

bs_202402.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
  if targetlist.Count > 0 then
    local number = (self.arglist)[1] // targetlist.Count
    for i = 0, targetlist.Count - 1 do
      LuaSkillCtrl:CallEffect((targetlist[i]).targetRole, (self.config).effectId2, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[i]).targetRole)
      LuaSkillCtrl:PlayAuHit(self, (targetlist[i]).targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurtConfig, {number})
      skillResult:EndResult()
    end
  end
end

bs_202402.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202402

