-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200601 = class("bs_200601", LuaSkillBase)
local base = LuaSkillBase
bs_200601.config = {buffId_1067 = 1067, buffTier = 1}
bs_200601.ctor = function(self)
  -- function num : 0_0
end

bs_200601.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_200601_5", 1, self.OnAfterHeal, self.caster)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).passive = true
end

bs_200601.OnAfterHeal = function(self, sender, target, skill, heal)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster then
    local roleBuffTier = target:GetBuffTier((self.config).buffId_1067)
    if roleBuffTier < (self.arglist)[2] then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_1067, (self.config).buffTier, nil)
    end
  end
end

bs_200601.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_200601

