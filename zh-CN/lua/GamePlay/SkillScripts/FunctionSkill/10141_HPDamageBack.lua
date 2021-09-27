local bs_10141 = class("bs_10141", LuaSkillBase)
local base = LuaSkillBase
bs_10141.config = {damageFormula = 10040, buffId = 1026, buffId2 = 1131}
bs_10141.ctor = function(self)
  -- function num : 0_0
end

bs_10141.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10141_3", 1, self.OnAfterHurt, nil, self.caster)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10141_TotalDamage"] = 0
end

bs_10141.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R9 in 'UnsetPending'

  if target == self.caster and hurt ~= 0 then
    ((self.caster).recordTable)["10141_TotalDamage"] = ((self.caster).recordTable)["10141_TotalDamage"] + hurt
    local num = ((self.caster).recordTable)["10141_TotalDamage"]
    local damagerRate = LuaSkillCtrl:CallFormulaNumberWithSkill(10040, self.caster, self.caster, self, num)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, damagerRate, nil, true)
    self:PlayChipEffect()
  end
end

bs_10141.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10141

