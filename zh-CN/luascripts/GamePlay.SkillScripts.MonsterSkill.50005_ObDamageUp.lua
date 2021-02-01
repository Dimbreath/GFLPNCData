-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50005 = class("bs_50005", LuaSkillBase)
local base = LuaSkillBase
bs_50005.config = {}
bs_50005.ctor = function(self)
  -- function num : 0_0
end

bs_50005.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_50005_2", 1, self.OnSetHurt)
end

bs_50005.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.sender == self.caster and (context.target).belongNum == 0 then
    context.hurt = context.hurt * 2
  end
end

bs_50005.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50005

