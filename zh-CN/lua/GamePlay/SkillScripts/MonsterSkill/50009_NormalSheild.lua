local bs_50009 = class("bs_50009", LuaSkillBase)
local base = LuaSkillBase
bs_50009.config = {buffId = 1076, reBuffId = 1049, sheildBuffId = 174, effectId = 10616, shieldKey = "50009_HuDun"}
bs_50009.ctor = function(self)
  -- function num : 0_0
end

bs_50009.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_50009_1", 1, self.OnSetHurt, nil, self.caster)
end

bs_50009.OnSetHurt = function(self, context)
  -- function num : 0_2
end

bs_50009.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50009

