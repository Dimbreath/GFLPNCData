-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202502 = class("bs_202502", LuaSkillBase)
local base = LuaSkillBase
bs_202502.config = {buffId_194 = 194, skill_time = 30, startAnimId = 1002}
bs_202502.ctor = function(self)
  -- function num : 0_0
end

bs_202502.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202502.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_194, 1, (self.arglist)[1] + (self.config).skill_time)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).startAnimId)
end

bs_202502.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202502

