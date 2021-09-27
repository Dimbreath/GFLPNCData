local bs_30032 = class("bs_30032", LuaSkillBase)
local base = LuaSkillBase
bs_30032.config = {}
bs_30032.ctor = function(self)
  -- function num : 0_0
end

bs_30032.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30032_1", 1, self.OnAfterPlaySkill)
  self:AddSetHurtTrigger("bs_30032_2", 2, self.OnSetHurt, self.caster)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["30032_AttackTime"] = 0
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).DamageFlag = false
end

bs_30032.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if skill.maker == self.caster and skill.isCommonAttack then
    ((self.caster).recordTable)["30032_AttackTime"] = ((self.caster).recordTable)["30032_AttackTime"] + 1
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    if (self.arglist)[1] <= ((self.caster).recordTable)["30032_AttackTime"] then
      ((self.caster).recordTable).DamageFlag = true
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["30032_AttackTime"] = 0
    end
  end
end

bs_30032.OnSetHurt = function(self, context)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  if context.sender == self.caster and (context.skill).isCommonAttack and not context.isTriggerSet and ((self.caster).recordTable).DamageFlag then
    if (self.caster).hp <= 1 then
      ((self.caster).recordTable).DamageFlag = false
      return 
    end
    if context.isCrit then
      context.hurt = (1000 + (self.caster).critDamage) * context.hurt // (1000 + (self.caster).critDamage)
    else
      context.isCrit = true
      context.hurt = (1000 + (self.caster).critDamage) * context.hurt // 1000
    end
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable).DamageFlag = false
  end
end

bs_30032.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30032

