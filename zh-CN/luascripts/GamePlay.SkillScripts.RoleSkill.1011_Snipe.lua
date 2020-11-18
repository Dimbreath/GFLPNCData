-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1011 = class("bs_1011", LuaSkillBase)
local base = LuaSkillBase
bs_1011.config = {
hurt_config1 = {hit_formula = 0, basehurt_formula = 1059, crit_formula = 1060}
, 
hurt_config2 = {hit_formula = 0, basehurt_formula = 1059, crit_formula = 0}
, effectIdAttack = 1040, effectIdStay = 1038}
bs_1011.ctor = function(self)
  -- function num : 0_0
end

bs_1011.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1011.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(30)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, (self.cskill).rangeOffset)
  self:CallCasterLookAt(targetList)
  LuaSkillCtrl:CallEffect(targetList, (self.config).effectIdStay, self)
  LuaSkillCtrl:StartTimer(self, 25, function()
    -- function num : 0_2_0 , upvalues : _ENV, targetList, self
    LuaSkillCtrl:CallEffect(targetList, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
, nil)
end

bs_1011.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    if (self.arglist)[4] == 1 then
      LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config1)
    else
      LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config2)
    end
    skillResult:EndResult()
  end
end

bs_1011.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1011

