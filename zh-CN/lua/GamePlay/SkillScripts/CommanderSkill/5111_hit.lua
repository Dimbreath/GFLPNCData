local bs_5111 = class("bs_5111", LuaSkillBase)
local base = LuaSkillBase
bs_5111.config = {effectIdAttack = 511101, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10127}
, audioId_start = 120, audioId_hit = 121, skillId = 5111}
bs_5111.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0
  self:AddOnRoleDieTrigger("bs_5111_1", 1, self.OnRoleDie, self.caster, nil, nil, nil, nil, nil, (self.config).skillId)
end

bs_5111.PlaySkill = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
  if targetList.Count >= 1 and targetList[0] ~= nil then
    LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource((targetList[0]).targetRole, (self.config).audioId_start)
    return true
  else
    return false
  end
end

bs_5111.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_2 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:PlayAuSource(target.targetRole, (self.config).audioId_hit)
    LuaSkillCtrl:CallBattleCamShake(1)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {((highAttRole[0]).targetRole).skill_intensity}, true)
      skillResult:EndResult()
    end
  end
end

bs_5111.OnRoleDie = function(self, killer, role, killSkill)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallAddPlayerMp((self.arglist)[2])
end

bs_5111.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5111

