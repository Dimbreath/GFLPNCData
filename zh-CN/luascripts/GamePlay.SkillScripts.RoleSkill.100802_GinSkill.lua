-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1051 = class("bs_1051", LuaSkillBase)
local base = LuaSkillBase
bs_1051.config = {effectId = 10210, buffId1 = 160, buffId2 = 161, audioId1 = 72}
bs_1051.ctor = function(self)
  -- function num : 0_0
end

bs_1051.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_1051.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1, (self.arglist)[1] + 15, true)
  if (self.arglist)[3] > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, (self.arglist)[1] + 15, true)
  end
  self:CallCasterWait(15)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallRoleAction(self.caster, 1002)
end

bs_1051.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1051

