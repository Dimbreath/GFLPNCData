-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5002 = class("bs_5002", LuaSkillBase)
local base = LuaSkillBase
bs_5002.config = {effectIdAttack = 10295}
bs_5002.ctor = function(self)
  -- function num : 0_0
end

bs_5002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5002.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 7, 20)
  if targetList.Count >= 1 and targetList[0] ~= nil then
    LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
    return true
  else
    return false
  end
end

bs_5002.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 31, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local exhurt = (100 - (target.targetRole).hp * 100 // (target.targetRole).maxHp) * (self.arglist)[3] // (self.arglist)[2]
      local hurt = ((highAttRole[0]).targetRole).pow * (self.arglist)[1] // 1000 * (100 + exhurt) // 100
      if hurt <= 0 then
        hurt = 1
      end
      LuaSkillCtrl:RemoveLife(hurt, self, target)
    end
  end
end

bs_5002.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5002

