local bs_200 = class("bs_200", LuaSkillBase)
local base = LuaSkillBase
bs_200.config = {
hurt_config = {basehurt_formula = 2012}
, effectIdAttack = 6}
bs_200.ctor = function(self)
  -- function num : 0_0
end

bs_200.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_200.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 21, 20)
  self:CallCasterLookAt(targetList)
  LuaSkillCtrl:CallEffect(targetList, (self.config).effectIdAttack, self, self.SkillEventFunc)
end

bs_200.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_200.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_200

