local bs_5112 = class("bs_5112", LuaSkillBase)
local base = LuaSkillBase
bs_5112.config = {effectIdAttack = 511201, 
HurtConfig_1 = {hit_formula = 0, basehurt_formula = 10128}
, audioId_start = 122, audioId_hit = 123, skillId = 5112}
bs_5112.ctor = function(self)
  -- function num : 0_0
end

bs_5112.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_5112_1", 1, self.OnRoleDie, self.caster, nil, nil, nil, nil, nil, (self.config).skillId)
end

bs_5112.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
  if targetList.Count >= 1 and targetList[0] ~= nil then
    LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:PlayAuSource((targetList[0]).targetRole, (self.config).audioId_start)
    return true
  else
    return false
  end
end

bs_5112.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig_1, {((highAttRole[0]).targetRole).skill_intensity}, true)
      skillResult:EndResult()
      LuaSkillCtrl:PlayAuSource(target.targetRole, (self.config).audioId_hit)
    end
  end
end

bs_5112.OnRoleDie = function(self, killer, role, killSkill)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallAddPlayerMp((self.arglist)[4])
end

bs_5112.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5112

