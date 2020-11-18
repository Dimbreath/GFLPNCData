-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10160 = class("bs_10160", LuaSkillBase)
local base = LuaSkillBase
bs_10160.config = {buffId = 1042}
bs_10160.ctor = function(self)
  -- function num : 0_0
end

bs_10160.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_10160_1", 1, self.OnAfterMove)
end

bs_10160.OnAfterMove = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
end

bs_10160.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10160

