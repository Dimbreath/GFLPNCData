-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20033 = class("bs_20033", LuaSkillBase)
local base = LuaSkillBase
bs_20033.config = {}
bs_20033.ctor = function(self)
  -- function num : 0_0
end

bs_20033.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30000 then
    return 
  end
  self:AddSetHurtTrigger("bs_20033_2", 1, self.OnSetHurt, self.caster)
end

bs_20033.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.sender == self.caster and (context.skill).dataId == 300001 then
    context.hurt = context.hurt * 2
  end
end

bs_20033.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20033

