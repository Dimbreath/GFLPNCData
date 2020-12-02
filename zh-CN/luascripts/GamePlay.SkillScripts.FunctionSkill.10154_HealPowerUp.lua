-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10154 = class("bs_10154", LuaSkillBase)
local base = LuaSkillBase
bs_10154.config = {buffId = 1069}
bs_10154.ctor = function(self)
  -- function num : 0_0
end

bs_10154.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_10152_5", 1, self.OnAfterHeal)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).maxTier = (self.arglist)[3]
end

bs_10154.OnAfterHeal = function(self, sender, target, skill, heal)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster then
    local time = (self.arglist)[4]
    local pre_tier = target:GetBuffTier((self.config).buffId)
    local tier = 1
    if LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] then
      if ((self.caster).recordTable).maxTier < pre_tier + tier then
        LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0)
        tier = ((self.caster).recordTable).maxTier
      end
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, tier, time)
    end
  end
end

bs_10154.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10154

