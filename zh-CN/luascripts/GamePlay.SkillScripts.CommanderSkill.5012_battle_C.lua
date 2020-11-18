-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5012 = class("bs_5012", LuaSkillBase)
local base = LuaSkillBase
bs_5012.config = {effectIdAttack = 10309, 
real_Config = {basehurt_formula = 502}
}
bs_5012.ctor = function(self)
  -- function num : 0_0
end

bs_5012.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5012.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBattleCamShake(1)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if targetList.Count >= 1 then
    for i = 0, targetList.Count - 1 do
      local targetRole = (targetList[i]).targetRole
      do
        local Roll = LuaSkillCtrl:CallRange((self.arglist)[1], (self.arglist)[2])
        LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_2_0 , upvalues : _ENV, targetRole, self
    LuaSkillCtrl:CallEffect(targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
, self, Roll, 3)
      end
    end
  end
end

bs_5012.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 31, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local hurt = ((highAttRole[0]).targetRole).pow * (self.arglist)[3] // 1000
      if hurt <= 0 then
        hurt = 1
      end
      LuaSkillCtrl:RemoveLife(hurt, self, target)
    end
  end
end

bs_5012.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5012

