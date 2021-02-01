-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10141 = class("bs_10141", LuaSkillBase)
local base = LuaSkillBase
bs_10141.config = {damageFormula = 10040, buffId = 1026}
bs_10141.ctor = function(self)
  -- function num : 0_0
end

bs_10141.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_10141_15", 1, self.OnHurtResultEnd)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10141_TotalDamage"] = 0
end

bs_10141.OnHurtResultEnd = function(self, skill, targetRole, hurtValue)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  if targetRole == self.caster then
    ((self.caster).recordTable)["10141_TotalDamage"] = ((self.caster).recordTable)["10141_TotalDamage"] + hurtValue
    local damagerRate = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, self.caster, self)
    local buffTier = ((self.caster).recordTable)["10141_TotalDamage"] * damagerRate // (self.caster).maxHp
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buffTier, nil, true)
  end
end

bs_10141.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10141

