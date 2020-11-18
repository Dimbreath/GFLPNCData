-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5007 = class("bs_5007", LuaSkillBase)
local base = LuaSkillBase
bs_5007.config = {effectIdAttack = 10302, buffId = 152}
bs_5007.ctor = function(self)
  -- function num : 0_0
end

bs_5007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_5007.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 31, 10)
  if targetList.Count > 0 then
    self.BJ = LuaSkillCtrl:CallEffect((targetList[0]).targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
  end
end

bs_5007.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBattleCamShake(1)
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId, 1, (self.arglist)[1])
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_3_0 , upvalues : self
    if self.BJ ~= nil then
      (self.BJ):Die()
      self.BJ = nil
    end
  end
)
  end
end

bs_5007.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5007

