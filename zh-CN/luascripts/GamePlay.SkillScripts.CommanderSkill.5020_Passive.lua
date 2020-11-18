-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5020 = class("bs_5020", LuaSkillBase)
local base = LuaSkillBase
bs_5020.config = {
buffALL = {141, 152, 66}
}
bs_5020.ctor = function(self)
  -- function num : 0_0
end

bs_5020.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeAddBuff, "bs_5020_4", 10, self.OnBeforeAddBuff)
end

bs_5020.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2 , upvalues : _ENV
  if (table.contain)((self.config).buffALL, (context.buff).dataId) and (context.buff).maker == self.caster then
    (context.buff):SetBuffDuration((context.buff).durationTime * (1000 + (self.arglist)[1]) // 1000, target)
  end
end

bs_5020.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5020

