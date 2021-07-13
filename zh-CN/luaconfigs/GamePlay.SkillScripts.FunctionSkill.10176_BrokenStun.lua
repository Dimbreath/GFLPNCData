-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10176 = class("bs_10176", LuaSkillBase)
local base = LuaSkillBase
bs_10176.config = {buffId = 66, buffTier = 1, buffId1 = 1054}
bs_10176.ctor = function(self)
  -- function num : 0_0
end

bs_10176.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_10176_22", 1, self.OnBreakShield)
end

bs_10176.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_2 , upvalues : _ENV
  if target.belongNum ~= (self.caster).belongNum then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, (self.arglist)[1])
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, (self.arglist)[2], (self.arglist)[1], true)
  end
end

bs_10176.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10176

