local bs_10008 = class("bs_10008", LuaSkillBase)
local base = LuaSkillBase
bs_10008.config = {
hurt_config = {basehurt_formula = 10007}
, effectIdAttack = 1006}
bs_10008.ctor = function(self)
  -- function num : 0_0
end

bs_10008.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_10008.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  self:CallCasterLookAt(targetList)
  LuaSkillCtrl:CallEffect(targetList, (self.config).effectIdAttack, self, self.SkillEventFunc)
end

bs_10008.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, true)
    skillResult:EndResult()
  end
end

bs_10008.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10008

