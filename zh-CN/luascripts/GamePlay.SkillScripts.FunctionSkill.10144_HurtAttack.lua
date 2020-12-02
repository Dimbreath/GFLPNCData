-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10144 = class("bs_10144", LuaSkillBase)
local base = LuaSkillBase
bs_10144.config = {buffId = 1009, buffTier = 1000, effectId = 10250}
bs_10144.ctor = function(self)
  -- function num : 0_0
end

bs_10144.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10144_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10144_1", 1, self.OnBeforePlaySkill)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10144_atkNum"] = 0
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10144_atkFlag"] = false
end

bs_10144.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and not isMiss and LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[1] * 2 and self:IsReadyToTake() then
    self:PlayChipEffect()
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10144_atkFlag"] = true
    self:OnSkillTake()
  end
  if target ~= self.caster and target.belongNum == (self.caster).belongNum and not isMiss and LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[1] and self:IsReadyToTake() then
    self:PlayChipEffect()
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10144_atkFlag"] = true
    self:OnSkillTake()
  end
  if sender == self.caster and skill.isCommonAttack then
    local tier = (self.caster):GetBuffTier((self.config).buffId)
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10144_atkNum"] = ((self.caster).recordTable)["10144_atkNum"] - 1
    if tier > 0 and ((self.caster).recordTable)["10144_atkNum"] <= 0 then
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

bs_10144.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  if (context.skill).maker == self.caster and (context.skill).isCommonAttack and ((self.caster).recordTable)["10144_atkFlag"] then
    ((self.caster).recordTable)["10144_atkFlag"] = false
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier)
    self.effect = LuaSkillCtrl:CallEffect((context.skill).maker, (self.config).effectId, self)
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10144_atkNum"] = 2
  end
end

bs_10144.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10144

