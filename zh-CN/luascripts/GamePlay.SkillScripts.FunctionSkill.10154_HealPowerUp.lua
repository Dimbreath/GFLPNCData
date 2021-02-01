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
  self:AddSelfTrigger(eSkillTriggerType.AfterHeal, "bs_10152_5", 1, self.OnAfterHeal)
end

bs_10154.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isTriggerSet then
    local time = (self.arglist)[4]
    local pre_tier = target:GetBuffTier((self.config).buffId)
    local self_tier = (self.caster):GetBuffTier((self.config).buffId)
    local tier = 1
    if pre_tier < (self.arglist)[3] then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, tier, time, true)
    else
      if (self.arglist)[3] < pre_tier then
        LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0)
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, (self.arglist)[3], time, true)
      end
    end
    if self_tier < (self.arglist)[3] then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, tier, time, true)
    else
      if (self.arglist)[3] < self_tier then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[3], time, true)
      end
    end
  end
end

bs_10154.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10154

