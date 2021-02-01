-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10181 = class("bs_10181", LuaSkillBase)
local base = LuaSkillBase
bs_10181.config = {sheildBuffId = 174, buffId = 1068}
bs_10181.ctor = function(self)
  -- function num : 0_0
end

bs_10181.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_10181_3", 1, self.OnSetHurt)
end

bs_10181.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and not context.isTriggerSet then
    local restTier = (context.target):GetBuffTier((self.config).sheildBuffId)
    if restTier > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, nil, true)
    else
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
    end
  end
end

bs_10181.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10181

