local bs_102009 = class("bs_102009", LuaSkillBase)
local base = LuaSkillBase
bs_102009.config = {buffId = 102003}
bs_102009.ctor = function(self)
  -- function num : 0_0
end

bs_102009.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_102009_3", 1, self.OnAfterHurt, nil, self.caster)
end

bs_102009.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and (self.caster):GetBuffTier((self.config).buffId) > 0 and not isMiss and hurt > 0 and LuaSkillCtrl:CallRange(1, 1000) <= ((self.caster).recordTable)["102009_UltBuff"] then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  end
end

bs_102009.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102009

