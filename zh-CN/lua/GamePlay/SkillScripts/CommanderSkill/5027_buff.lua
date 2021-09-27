local bs_5027 = class("bs_5027", LuaSkillBase)
local base = LuaSkillBase
bs_5027.config = {}
bs_5027.ctor = function(self)
  -- function num : 0_0
end

bs_5027.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetHurtTrigger("bs_5027_3", 1, self.OnSetHurt, self.caster)
end

bs_5027.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  local buffId = LuaSkillCtrl:GetSkillBindBuffId(self)
  if context.sender == self.caster and (context.skill).isCommonAttack and (self.caster):GetBuffTier(buffId) > 0 and not context.isMiss and context.hurt > 0 then
    context.hurt = context.hurt * (1000 - (self.arglist)[1]) // 1000
    LuaSkillCtrl:DispelBuff(self.caster, buffId, 1)
  end
end

bs_5027.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5027

