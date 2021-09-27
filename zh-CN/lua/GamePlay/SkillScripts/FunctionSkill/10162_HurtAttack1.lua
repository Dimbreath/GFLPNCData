local bs_10162 = class("bs_10162", LuaSkillBase)
local base = LuaSkillBase
bs_10162.config = {buffId = 1121, buffTier = 1, effectId = 10250}
bs_10162.ctor = function(self)
  -- function num : 0_0
end

bs_10162.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10162_3", 2, self.OnAfterHurt)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10162_1", 1, self.OnBeforePlaySkill)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10162_atkNum"] = 0
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10162_atkFlag"] = false
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10162_DamageNum"] = 0
end

bs_10162.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and not isMiss and LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[1] * 2 + ((self.caster).recordTable)["10162_DamageNum"] and self:IsReadyToTake() then
    self:PlayChipEffect()
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10162_atkFlag"] = true
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10162_DamageNum"] = 0
    self:OnSkillTake()
  else
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10162_DamageNum"] = ((self.caster).recordTable)["10162_DamageNum"] + 50
  end
  if target ~= self.caster and target.belongNum == (self.caster).belongNum and not isMiss and LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[1] + ((self.caster).recordTable)["10162_DamageNum"] and self:IsReadyToTake() then
    self:PlayChipEffect()
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10162_atkFlag"] = true
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10162_DamageNum"] = 0
    self:OnSkillTake()
  else
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10162_DamageNum"] = ((self.caster).recordTable)["10162_DamageNum"] + 50
  end
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R9 in 'UnsetPending'

  if sender == self.caster and skill.isCommonAttack then
    ((self.caster).recordTable)["10162_atkNum"] = 0
    if ((self.caster).recordTable)["10162_atkNum"] <= 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
      if self.effect ~= nil then
        (self.effect):Die()
        self.effect = nil
      end
    end
    if target.hp <= hurt and self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
  end
end

bs_10162.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  if (context.skill).maker == self.caster and (context.skill).isCommonAttack and ((self.caster).recordTable)["10162_atkFlag"] then
    ((self.caster).recordTable)["10162_atkFlag"] = false
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
    self.effect = LuaSkillCtrl:CallEffect((context.skill).maker, (self.config).effectId, self)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10162_atkNum"] = 2
  end
end

bs_10162.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_10162.LuaDispose = function(self)
  -- function num : 0_5 , upvalues : base
  (base.LuaDispose)(self)
  self.effect = nil
end

return bs_10162

