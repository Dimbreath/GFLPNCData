-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5003 = class("bs_5003", LuaSkillBase)
local base = LuaSkillBase
bs_5003.config = {effectIdAttack = 10297, buffId = 247, buffTier = 1, 
HurtConfig = {basehurt_formula = 10127}
, 
HurtConfig1 = {basehurt_formula = 10132}
, audioId_start = 124, audioId_hit = 125}
bs_5003.ctor = function(self)
  -- function num : 0_0
end

bs_5003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5003.PlaySkill = function(self, data)
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

bs_5003.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil and target ~= nil then
      if (self.cskill).level >= 2 then
        local bonus = (target.targetRole):GetBuffTier((self.config).buffId)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig1, {((highAttRole[0]).targetRole).skill_intensity, bonus}, true)
        skillResult:BuffResult((self.config).buffId, (self.config).buffTier, (self.arglist)[2])
        skillResult:EndResult()
      else
        do
          do
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
            LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {((highAttRole[0]).targetRole).skill_intensity}, true)
            skillResult:EndResult()
            LuaSkillCtrl:PlayAuSource(target, (self.config).audioId_hit)
          end
        end
      end
    end
  end
end

bs_5003.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5003

