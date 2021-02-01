-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40023 = class("bs_40023", LuaSkillBase)
local base = LuaSkillBase
bs_40023.config = {buffId = 1067, buffTier = 1}
bs_40023.ctor = function(self)
  -- function num : 0_0
end

bs_40023.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHeal, "bs_40023_5", 1, self.OnAfterHeal)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).passive = true
end

bs_40023.OnAfterHeal = function(self, sender, target, skill, heal)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster then
    local roleBuffTier = target:GetBuffTier((self.config).buffId)
    if roleBuffTier < (self.arglist)[2] then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.config).buffTier, nil)
    end
  end
end

bs_40023.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40023

