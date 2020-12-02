-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10116 = class("bs_10116", LuaSkillBase)
local base = LuaSkillBase
bs_10116.config = {buffId = 1016}
bs_10116.ctor = function(self)
  -- function num : 0_0
end

bs_10116.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10116_1", 1, self.OnAfterBattleStart)
end

bs_10116.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
end

bs_10116.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10116

