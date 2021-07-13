-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10243 = class("bs_10243", LuaSkillBase)
local base = LuaSkillBase
bs_10243.config = {buffId = 1094, buffTier = 1}
bs_10243.ctor = function(self)
  -- function num : 0_0
end

bs_10243.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HealResultStart, "bs_10243_15", 1, self.OnHealResultStart)
  self:AddAfterHealTrigger("bs_10243_5", 1, self.OnAfterHeal, nil, self.caster)
end

bs_10243.OnHealResultStart = function(self, skill, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and LuaSkillCtrl:GetRoleEfcGrid(self.caster) ~= 0 and not context.isTriggerSet then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  end
end

bs_10243.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and not isTriggerSet then
    local buffTier = target:GetBuffTier((self.config).buffId)
    if buffTier <= 0 then
      return 
    end
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
  end
end

bs_10243.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10243

