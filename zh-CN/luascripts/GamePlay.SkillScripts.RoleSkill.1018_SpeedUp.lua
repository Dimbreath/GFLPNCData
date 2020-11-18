-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1018 = class("bs_1018", LuaSkillBase)
local base = LuaSkillBase
bs_1018.config = {
heal_config = {baseheal_formula = 0, heal_number = 0, correct_formula = 0}
, buffId = 95, buffTier = 0, buffDuration = 0, effectId = 1034, selectId = 20}
bs_1018.ctor = function(self)
  -- function num : 0_0
end

bs_1018.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1018.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(10)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, 0)
  self:CallCasterLookAt(targetList)
  LuaSkillCtrl:CallEffect(targetList, (self.config).effectId, self, self.SkillEventFunc)
end

bs_1018.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    skillResult:BuffResult((self.config).buffId, (self.arglist)[1], (self.arglist)[2])
    skillResult:EndResult()
  end
end

bs_1018.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1018

