-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_5022 = class("bs_5022", LuaSkillBase)
local base = LuaSkillBase
bs_5022.config = {
skillteam = {5001, 5002, 5003, 5004.5017}
}
bs_5022.ctor = function(self)
  -- function num : 0_0
end

bs_5022.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_5022_1", 15, self.OnSetHurt, self.caster)
end

bs_5022.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (table.contain)((self.config).skillteam, (context.skill).dataId) then
    context.hurt = context.hurt * (1000 + (self.arglist)[1]) // 1000
  end
end

bs_5022.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5022

