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
  self:AddLuaTrigger(eSkillLuaTrigger.OnSheldBroken, self.OnSheldBroken)
end

bs_10176.OnSheldBroken = function(self, sender, targetRole)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.config).buffTier, (self.arglist)[1])
  LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId1, (self.arglist)[2], (self.arglist)[1])
end

bs_10176.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10176

