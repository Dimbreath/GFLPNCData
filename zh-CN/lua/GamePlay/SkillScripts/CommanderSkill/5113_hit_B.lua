local bs_5113 = class("bs_5113", LuaSkillBase)
local base = LuaSkillBase
bs_5113.config = {effectIdAttack = 511301, buffId = 247, buffTier = 1, 
HurtConfig1 = {hit_formula = 0, basehurt_formula = 10132}
, audioId_start = 124, audioId_hit = 125, skillId = 5113}
bs_5113.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0
  self:AddOnRoleDieTrigger("bs_5113_1", 1, self.OnRoleDie, self.caster, nil, nil, nil, nil, nil, (self.config).skillId)
end

bs_5113.PlaySkill = function(self, data)
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

bs_5113.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_2 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil and target ~= nil then
      local bonus = (self.caster):GetBuffTier((self.config).buffId)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig1, {((highAttRole[0]).targetRole).skill_intensity, bonus}, true)
      skillResult:EndResult()
      LuaSkillCtrl:PlayAuSource(target.targetRole, (self.config).audioId_hit)
    end
  end
end

bs_5113.OnRoleDie = function(self, killer, role, killSkill)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, (self.arglist)[2], true)
end

bs_5113.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5113

