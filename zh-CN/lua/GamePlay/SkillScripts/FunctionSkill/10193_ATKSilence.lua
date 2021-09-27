local bs_10193 = class("bs_10193", LuaSkillBase)
local base = LuaSkillBase
bs_10193.config = {buffId = 66, buffTier = 1}
bs_10193.ctor = function(self)
  -- function num : 0_0
end

bs_10193.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10193_1", 1, self.OnAfterPlaySkill)
  self:AddSetHurtTrigger("bs_10193_2", 2, self.OnSetHurt, self.caster)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10193_AttackTime"] = 0
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).DamageFlag = false
end

bs_10193.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if skill.maker == self.caster and skill.isCommonAttack then
    ((self.caster).recordTable)["10193_AttackTime"] = ((self.caster).recordTable)["10193_AttackTime"] + 1
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    if (self.arglist)[1] < ((self.caster).recordTable)["10193_AttackTime"] then
      ((self.caster).recordTable).DamageFlag = true
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["10193_AttackTime"] = 0
    end
  end
end

bs_10193.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).isCommonAttack and not context.isTriggerSet and ((self.caster).recordTable).DamageFlag and not context.isTriggerSet then
    LuaSkillCtrl:CallBuff(self, context.target, (self.config).buffId, (self.config).buffTier, (self.arglist)[2])
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable).DamageFlag = false
    self:PlayChipEffect()
  end
end

bs_10193.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10193

