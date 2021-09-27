local bs_10062 = class("bs_10062", LuaSkillBase)
local base = LuaSkillBase
bs_10062.config = {buffId = 105, buffTier = 1}
bs_10062.ctor = function(self)
  -- function num : 0_0
end

bs_10062.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_10062_1", 1, self.OnHurtResultStart)
end

bs_10062.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster and (context.target).maxHp < (context.sender).maxHp then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  else
    if context.sender == self.caster and (context.sender).maxHp <= (context.target).maxHp then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
    end
  end
end

bs_10062.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10062

