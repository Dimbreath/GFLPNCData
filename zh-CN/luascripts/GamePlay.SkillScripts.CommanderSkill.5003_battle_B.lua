-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5003 = class("bs_5003", LuaSkillBase)
local base = LuaSkillBase
bs_5003.config = {effectIdAttack = 10296}
bs_5003.ctor = function(self)
  -- function num : 0_0
end

bs_5003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5003.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 38, 20)
  if targetList.Count >= 1 and targetList[0] ~= nil then
    LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
    return true
  else
    return false
  end
end

bs_5003.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(2)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 46, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local exhurt = (target.targetRole).hp * 100 // (target.targetRole).maxHp * ((self.arglist)[3] - (self.arglist)[2]) * 100 // 100 // 100
      local hurt = ((highAttRole[0]).targetRole).skill_intensity * (self.arglist)[1] * (1000 + exhurt + (self.arglist)[2]) // 1000 // 1000
      if hurt <= 0 then
        hurt = 1
      end
      LuaSkillCtrl:RemoveLife(hurt, self, target)
    end
  end
end

bs_5003.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5003

