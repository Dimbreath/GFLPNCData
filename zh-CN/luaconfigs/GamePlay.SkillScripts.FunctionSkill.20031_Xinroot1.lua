-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20031 = class("bs_20031", LuaSkillBase)
local base = LuaSkillBase
bs_20031.config = {buffId = 1138, buffTier = 1}
bs_20031.ctor = function(self)
  -- function num : 0_0
end

bs_20031.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30000 then
    return 
  end
  self:AddSetHurtTrigger("bs_20031_2", 1, self.OnSetHurt, self.caster)
end

bs_20031.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).dataId == 300002 then
    LuaSkillCtrl:CallHeal(context.hurt, self, self.caster)
  end
end

bs_20031.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20031

