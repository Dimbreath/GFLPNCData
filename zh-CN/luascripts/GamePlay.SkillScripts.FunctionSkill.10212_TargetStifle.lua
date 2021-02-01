-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10212 = class("bs_10212", LuaSkillBase)
local base = LuaSkillBase
bs_10212.config = {checkBuffId = 26, buffId = 1062}
bs_10212.ctor = function(self)
  -- function num : 0_0
end

bs_10212.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_10212_2", 1, self.OnSetHurt)
end

bs_10212.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isMiss and LuaSkillCtrl:RoleContainsCtrlBuff(context.target) then
    self:PlayChipEffect()
    local preTier = (self.caster):GetBuffTier((self.config).buffId)
    local tier = 1
    if (self.arglist)[3] <= preTier then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, tier, true)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, tier, (self.arglist)[2], true)
  end
end

bs_10212.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10212

