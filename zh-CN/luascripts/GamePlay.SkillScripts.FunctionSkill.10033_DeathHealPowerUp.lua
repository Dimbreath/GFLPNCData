-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10033 = class("bs_10033", LuaSkillBase)
local base = LuaSkillBase
bs_10033.config = {buffId = 1006}
bs_10033.ctor = function(self)
  -- function num : 0_0
end

bs_10033.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10033_1", 1, self.OnSetHurt)
end

bs_10033.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).hp <= context.hurt and (context.target).hp > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], nil, true)
  end
end

bs_10033.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10033

