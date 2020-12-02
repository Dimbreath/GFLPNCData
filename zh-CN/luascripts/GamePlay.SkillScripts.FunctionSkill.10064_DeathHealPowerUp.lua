-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10064 = class("bs_10064", LuaSkillBase)
local base = LuaSkillBase
bs_10064.config = {buffId = 1006}
bs_10064.ctor = function(self)
  -- function num : 0_0
end

bs_10064.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10064_1", 1, self.OnSetHurt)
end

bs_10064.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.target).hp <= context.hurt and (context.target).hp > 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
  end
end

bs_10064.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10064

