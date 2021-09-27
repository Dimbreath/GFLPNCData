local bs_20032 = class("bs_20032", LuaSkillBase)
local base = LuaSkillBase
bs_20032.config = {buffId = 1039, buffTier = 1, damageBuffId = 1075, effectId1 = 91, effectId2 = 10339, effectId3 = 10340, healFormula = 10098, healEffectId = 10286}
bs_20032.ctor = function(self)
  -- function num : 0_0
end

bs_20032.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  if (self.caster).roleDataId ~= 30000 then
    return 
  end
  self:AddAfterHurtTrigger("bs_20032_1", 1, self.OnAfterHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20032_2", 1, self.OnAfterBattleStart)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["20032_effectFlag"] = true
  self.time = 0
end

bs_20032.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).hp * 1000 // (self.caster).maxHp <= (self.arglist)[1] and self:IsReadyToTake() and self.time == 0 then
    if ((self.caster).recordTable)["20032_effectFlag"] then
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).healEffectId, self)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).damageBuffId, (self.config).buffTier)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier)
    local healNum = (math.max)(LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).healFormula, self.caster, self.caster, self), 1)
    LuaSkillCtrl:CallHeal(healNum, self, self.caster)
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["20032_effectFlag"] = false
    self.time = 1
    self:OnSkillTake()
  end
end

bs_20032.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and (self.caster).hp * 1000 // (self.caster).maxHp <= (self.arglist)[1] and self:IsReadyToTake() and self.time == 0 then
    if ((self.caster).recordTable)["20032_effectFlag"] then
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).healEffectId, self)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).damageBuffId, (self.config).buffTier, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
    local healNum = (math.max)(LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).healFormula, self.caster, self.caster, self), 1)
    LuaSkillCtrl:CallHeal(healNum, self, self.caster, true)
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["20032_effectFlag"] = false
    self.time = 1
    self:OnSkillTake()
  end
end

bs_20032.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20032

