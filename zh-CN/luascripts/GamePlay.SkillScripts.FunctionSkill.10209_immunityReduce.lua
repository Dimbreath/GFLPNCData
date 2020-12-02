-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10209 = class("bs_10209", LuaSkillBase)
local base = LuaSkillBase
bs_10209.config = {buffId = 1059, effectId = 134}
bs_10209.ctor = function(self)
  -- function num : 0_0
end

bs_10209.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10209_3", 1, self.OnAfterHurt)
end

bs_10209.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] and (self.arglist)[3] > 0 and (self.arglist)[4] > 0 then
    local tier = 1
    self:PlayChipEffect()
    local time = (self.arglist)[4]
    local pre_tier = target:GetBuffTier((self.config).buffId)
    if (self.arglist)[3] <= pre_tier then
      LuaSkillCtrl:DispelBuff(target, (self.config).buffId, tier)
    end
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, tier, time)
  end
end

bs_10209.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10209

