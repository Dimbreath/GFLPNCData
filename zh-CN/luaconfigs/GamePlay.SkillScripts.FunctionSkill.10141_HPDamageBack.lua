-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10141 = class("bs_10141", LuaSkillBase)
local base = LuaSkillBase
bs_10141.config = {damageFormula = 10040, buffId = 1026, buffId2 = 1131}
bs_10141.ctor = function(self)
  -- function num : 0_0
end

bs_10141.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10141_2", 10, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_10141_3", 1, self.OnAfterHurt, nil, self.caster)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10141_TotalDamage"] = 0
end

bs_10141.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
end

bs_10141.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R9 in 'UnsetPending'

  if target == self.caster then
    ((self.caster).recordTable)["10141_TotalDamage"] = ((self.caster).recordTable)["10141_TotalDamage"] + hurt
    local num = ((self.caster).recordTable)["10141_TotalDamage"]
    local damagerRate = LuaSkillCtrl:CallFormulaNumberWithSkill(10040, self.caster, self.caster, self, num)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, damagerRate, nil, true)
    self:PlayChipEffect()
  end
end

bs_10141.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10141

