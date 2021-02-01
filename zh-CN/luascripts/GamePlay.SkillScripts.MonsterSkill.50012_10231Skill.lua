-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_50012 = class("bs_50012", LuaSkillBase)
local base = LuaSkillBase
bs_50012.config = {buffId = 1086, effectId = 10642}
bs_50012.ctor = function(self)
  -- function num : 0_0
end

bs_50012.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_50012_3", 2, self.OnAfterHurt)
end

bs_50012.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and not isMiss then
    local buffTier = target:GetBuffTier((self.config).buffId)
    if buffTier > 0 then
      if buffTier == 1 then
        LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
      end
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 1)
    end
  end
end

bs_50012.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_50012

