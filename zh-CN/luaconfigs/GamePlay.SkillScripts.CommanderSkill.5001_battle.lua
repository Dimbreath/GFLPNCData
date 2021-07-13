-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5001 = class("bs_5001", LuaSkillBase)
local base = LuaSkillBase
bs_5001.config = {effectIdAttack = 10294, 
HurtConfig = {basehurt_formula = 10127}
, audioId_start = 120, audioId_hit = 121}
bs_5001.ctor = function(self)
  -- function num : 0_0
end

bs_5001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5001.PlaySkill = function(self, data)
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

bs_5001.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {((highAttRole[0]).targetRole).skill_intensity}, true)
      skillResult:EndResult()
      LuaSkillCtrl:PlayAuSource(target, (self.config).audioId_hit)
    end
  end
end

bs_5001.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5001

