-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5010 = class("bs_5010", LuaSkillBase)
local base = LuaSkillBase
bs_5010.config = {effectIdAttack = 10306, buffId = 66}
bs_5010.ctor = function(self)
  -- function num : 0_0
end

bs_5010.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5010.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 20)
  if targetList.Count >= 1 then
    for i = 0, targetList.Count - 1 do
      local targetRole = (targetList[i]).targetRole
      LuaSkillCtrl:CallEffect(targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
    end
  end
end

bs_5010.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(2)
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 31, 20)
    if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
      local hurt = ((highAttRole[0]).targetRole).pow * (self.arglist)[1] // 1000
      do
        if hurt <= 0 then
          hurt = 1
        end
        LuaSkillCtrl:StartTimer(self, 6, function()
    -- function num : 0_3_0 , upvalues : _ENV, hurt, self, target
    LuaSkillCtrl:RemoveLife(hurt, self, target)
    LuaSkillCtrl:CallBuff(self, target.targetRole, 66, 1, (self.arglist)[2])
  end
)
      end
    end
  end
end

bs_5010.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5010

