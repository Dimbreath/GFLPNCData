local bs_10127 = class("bs_10127", LuaSkillBase)
local base = LuaSkillBase
bs_10127.config = {buffId = 1132, buffTier = 1}
bs_10127.ctor = function(self)
  -- function num : 0_0
end

bs_10127.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10127_2", 10, self.OnAfterBattleStart)
end

bs_10127.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], arriveCallBack, self, -1)
end

bs_10127.OnArriveAction = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:PlayChipEffect()
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
end

bs_10127.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

return bs_10127

