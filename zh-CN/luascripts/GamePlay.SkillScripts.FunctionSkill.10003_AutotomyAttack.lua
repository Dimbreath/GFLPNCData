-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10003 = class("bs_10003", LuaSkillBase)
local base = LuaSkillBase
bs_10003.config = {effectId = 10344, effectAttackId = 10336, buffId = 82}
bs_10003.ctor = function(self)
  -- function num : 0_0
end

bs_10003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_10003_3", 3, self.OnAfterHurt)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10003_1", 2, self.OnAfterPlaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10003_11", 1, self.OnBeforePlaySkill)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10003_atkFlag"] = false
end

bs_10003.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
  if skill.maker == self.caster and not skill.isCommonAttack then
    self:PlayChipEffect()
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10003_atkFlag"] = true
  end
end

bs_10003.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and (self.caster):GetBuffTier((self.config).buffId) > 0 and not isTriggerSet then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  end
end

bs_10003.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_4 , upvalues : _ENV
  if role == self.caster and (context.skill).isCommonAttack and ((self.caster).recordTable)["10003_atkFlag"] then
    local passdata = {effectId = (self.config).effectAttackId}
    context.passdata = passdata
    local dmgUp1 = (self.caster).hp * (self.arglist)[1] // 1000
    local dmgUp2 = (self.caster).hp * (self.arglist)[1] * (self.arglist)[2] // 10000
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, dmgUp2)
    LuaSkillCtrl:RemoveLife(dmgUp1, self, self.caster)
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10003_atkFlag"] = false
  end
end

bs_10003.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10003

