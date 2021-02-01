-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40015 = class("bs_40015", LuaSkillBase)
local base = LuaSkillBase
bs_40015.config = {buffId = 1005}
bs_40015.ctor = function(self)
  -- function num : 0_0
end

bs_40015.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_40015_1", 1, self.OnSetHurt)
end

bs_40015.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).hp <= context.hurt and (context.target).hp > 0 and context.sender == self.caster then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], nil, true)
  end
end

bs_40015.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40015

