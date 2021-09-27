local bs_6001 = class("bs_6001", LuaSkillBase)
local base = LuaSkillBase
bs_6001.config = {buffId_1151 = 1151}
bs_6001.ctor = function(self)
  -- function num : 0_0
end

bs_6001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_6001_4", 1, self.OnSetHeal, self.caster)
end

bs_6001.OnSetHeal = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster then
    local targetRole = context.target
    local time = (self.arglist)[2]
    LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId_1151, 1, time, true)
  end
end

bs_6001.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6001

