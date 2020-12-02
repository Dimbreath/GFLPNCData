-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5023 = class("bs_5023", LuaSkillBase)
local base = LuaSkillBase
bs_5023.config = {
skillteam = {5009, 5010, 5011, 5012}
}
bs_5023.ctor = function(self)
  -- function num : 0_0
end

bs_5023.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_5023_1", 15, self.OnSetHurt)
end

bs_5023.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (table.contain)((self.config).skillteam, (context.skill).dataId) then
    context.hurt = context.hurt * (1000 + (self.arglist)[1]) // 1000
  end
end

bs_5023.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5023

