local bs_10018 = class("bs_10018", LuaSkillBase)
local base = LuaSkillBase
bs_10018.config = {effectId = 1047, buffId = 1140, buffTier = 1, conditionCheck = "$1>=max(GetSkillArg(1),50)/1000*@maxHp", damageFormula = "max(GetSkillArg(1),50)/1000*@maxHp"}
bs_10018.ctor = function(self)
  -- function num : 0_0
end

bs_10018.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10018", 1, self.OnSetHurt, nil, self.caster)
  self.time = 0
end

bs_10018.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and self:IsReadyToTake() and self.time < (self.arglist)[3] and LuaSkillCtrl:CallFormulaBoolWithSkill((self.config).conditionCheck, self.caster, self.caster, self, context.hurt) then
    local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, context.target, self)
    context.hurt = damageNum
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
    self:OnSkillTake()
    self.time = self.time + 1
  end
end

bs_10018.SkillBack = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
  end
end

bs_10018.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10018

