-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103509 = class("bs_103509", LuaSkillBase)
local base = LuaSkillBase
bs_103509.config = {}
bs_103509.ctor = function(self)
  -- function num : 0_0
end

bs_103509.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_103509_6", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
end

bs_103509.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2
  if target == self.caster and (context.buff).buffType == 2 then
    context.active = false
  end
end

bs_103509.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103509

