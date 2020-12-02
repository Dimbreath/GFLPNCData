-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10120 = class("bs_10120", LuaSkillBase)
local base = LuaSkillBase
bs_10120.config = {buffId1 = 1021, buffId2 = 1022, effectId = 91}
bs_10120.ctor = function(self)
  -- function num : 0_0
end

bs_10120.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10120_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10120_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10120_2", 1, self.OnSetHurt)
end

bs_10120.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, (self.arglist)[1])
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, (self.arglist)[1])
end

bs_10120.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster then
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  end
end

bs_10120.OnSetHurt = function(self, context)
  -- function num : 0_4 , upvalues : _ENV
  if context.sender == self.caster and not context.isMiss and context.isRealDmg then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId2, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, (self.arglist)[1] * 3)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, (self.arglist)[1] * 3)
  else
    if context.sender == self.caster and not context.isMiss and not context.isRealDmg then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId2, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, (self.arglist)[1])
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, (self.arglist)[1])
    end
  end
end

bs_10120.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10120

