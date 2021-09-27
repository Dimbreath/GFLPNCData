local bs_30000 = class("bs_30000", LuaSkillBase)
local base = LuaSkillBase
bs_30000.config = {effectId = 1047, conditionCheck = "$1>=max(GetSkillArg(1),50)/1000*@maxHp", damageFormula = "max(GetSkillArg(1),50)/1000*@maxHp"}
bs_30000.ctor = function(self)
  -- function num : 0_0
end

bs_30000.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_30000_1", 1, self.OnSetHurt, nil, self.caster)
  self.time = 0
end

bs_30000.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.target == self.caster and self:IsReadyToTake() and self.time < (self.arglist)[2] and LuaSkillCtrl:CallFormulaBoolWithSkill((self.config).conditionCheck, self.caster, self.caster, self, context.hurt) then
    local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, context.target, self)
    context.hurt = damageNum
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil)
    self:OnSkillTake()
    self.time = self.time + 1
  end
end

bs_30000.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30000

