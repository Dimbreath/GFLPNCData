-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100802 = class("bs_100802", LuaSkillBase)
local base = LuaSkillBase
bs_100802.config = {buffId_160 = 160, buffId_161 = 161, audioId1 = 72, skill_time = 15, buffId_170 = 170}
bs_100802.ctor = function(self)
  -- function num : 0_0
end

bs_100802.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100802.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local buff_time = (self.config).skill_time + (self.arglist)[1]
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_160, 1, buff_time, true)
  if (self.arglist)[3] > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_161, 1, buff_time, true)
  end
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, buff_time, true)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallRoleAction(self.caster, 1002)
  LuaSkillCtrl:StartShowSkillDurationTime(self, buff_time)
end

bs_100802.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100802

