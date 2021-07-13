-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40020 = class("bs_40020", LuaSkillBase)
local base = LuaSkillBase
bs_40020.config = {buffId_1012 = 1012, attackdelay = 15, effectId = 10608}
bs_40020.ctor = function(self)
  -- function num : 0_0
end

bs_40020.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40020_1", 1, self.OnAfterBattleStart)
end

bs_40020.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.damTimer = LuaSkillCtrl:StartTimer(self, (self.config).attackdelay, self.CallBack, self, -1)
end

bs_40020.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.damTimer ~= nil and (self.damTimer):IsOver() then
    self.damTimer = nil
  end
  if (self.caster).hp < (self.caster).maxHp * (self.arglist)[1] // 1000 and self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1012, (self.arglist)[3])
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
end

bs_40020.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
end

return bs_40020

