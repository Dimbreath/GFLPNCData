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
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10141_3", 1, self.OnAfterHurt)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10141_TotalDamage"] = 0
end

bs_10141.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R8 in 'UnsetPending'

  if target == self.caster and not isMiss then
    ((self.caster).recordTable)["10141_TotalDamage"] = ((self.caster).recordTable)["10141_TotalDamage"] + hurt
    local damagerRate = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormula, self.caster, self.caster, self)
    local buffTier = ((self.caster).recordTable)["10141_TotalDamage"] * damagerRate // (self.caster).maxHp
    local layer = (self.caster):GetBuffTier((self.config).buffId)
    if layer < buffTier then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buffTier - layer)
    end
  end
end

bs_10141.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10141

