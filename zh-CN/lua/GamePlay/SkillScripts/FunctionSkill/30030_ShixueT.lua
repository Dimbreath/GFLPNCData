local bs_30030 = class("bs_30030", LuaSkillBase)
local base = LuaSkillBase
bs_30030.config = {buffId_shixue = 257, buffTier = 1}
bs_30030.ctor = function(self)
  -- function num : 0_0
end

bs_30030.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30030_1", 1, self.OnAfterBattleStart)
end

bs_30030.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.timer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], self.Callback, self, -1)
end

bs_30030.Callback = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:PlayChipEffect()
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_shixue, (self.config).buffTier)
end

bs_30030.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

return bs_30030

