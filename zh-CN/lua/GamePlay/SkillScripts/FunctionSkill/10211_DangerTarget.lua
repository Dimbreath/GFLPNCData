local bs_10211 = class("bs_10211", LuaSkillBase)
local base = LuaSkillBase
bs_10211.config = {effectId = 1050, buffId = 1059, 
hurt_config = {basehurt_formula = 10076}
}
bs_10211.ctor = function(self)
  -- function num : 0_0
end

bs_10211.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10211_12", 1, self.OnAfterPlaySkill)
end

bs_10211.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if not (skill.maker).unableSelect and (skill.maker).belongNum ~= (self.caster).belongNum and not skill.isCommonAttack and not skill.isPassive then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(skill.maker, (self.config).effectId, self, self.SkillEventFunc)
  end
end

bs_10211.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10211.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10211

