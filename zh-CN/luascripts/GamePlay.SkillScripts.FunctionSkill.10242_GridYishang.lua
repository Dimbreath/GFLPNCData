-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10242 = class("bs_10242", LuaSkillBase)
local base = LuaSkillBase
bs_10242.config = {buffId = 1093, buffTier = 1}
bs_10242.ctor = function(self)
  -- function num : 0_0
end

bs_10242.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_10242_1", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_10242_2", 2, self.OnAfterHurt)
end

bs_10242.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and LuaSkillCtrl:GetRoleEfcGrid(context.target) ~= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  end
end

bs_10242.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and not isTriggerSet then
    local buffTier = (self.caster):GetBuffTier((self.config).buffId)
    if buffTier <= 0 then
      return 
    end
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
  end
end

bs_10242.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10242

