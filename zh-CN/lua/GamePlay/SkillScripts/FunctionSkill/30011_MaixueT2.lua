local bs_30011 = class("bs_30011", LuaSkillBase)
local base = LuaSkillBase
bs_30011.config = {damageFormular = 10041, effectId = 10334, effectId2 = 10335}
bs_30011.ctor = function(self)
  -- function num : 0_0
end

bs_30011.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30011_1", 1, self.OnAfterPlaySkill)
  self:AddSetHurtTrigger("bs_30011_2", 2, self.OnSetHurt, self.caster)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["30011_AttackTime"] = 0
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).DamageFlag = false
end

bs_30011.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if skill.maker == self.caster and skill.isCommonAttack then
    ((self.caster).recordTable)["30011_AttackTime"] = ((self.caster).recordTable)["30011_AttackTime"] + 1
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

    if ((self.caster).recordTable)["30011_AttackTime"] >= 3 then
      ((self.caster).recordTable).DamageFlag = true
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["30011_AttackTime"] = 0
    end
  end
end

bs_30011.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).isCommonAttack and not context.isTriggerSet and ((self.caster).recordTable).DamageFlag then
    local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormular, self.caster, context.target, self)
    if damageNum <= 1 then
      return 
    end
    if (self.caster).hp <= 1 then
      return 
    end
    local enemyDamage = damageNum * (self.arglist)[2] // 1000
    local lastComAtkRole = ((self.caster).recordTable).lastAttackRole
    if lastComAtkRole ~= nil then
      LuaSkillCtrl:RemoveLife(enemyDamage, self, lastComAtkRole, true, nil, true, false, eHurtType.RealDmg)
      LuaSkillCtrl:RemoveLife(damageNum, self, self.caster, true, nil, true, false, eHurtType.RealDmg)
      LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self)
      LuaSkillCtrl:CallEffect(context.target, (self.config).effectId2, self)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
      -- DECOMPILER ERROR at PC88: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.caster).recordTable).DamageFlag = false
      self:PlayChipEffect()
    end
  end
end

bs_30011.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30011

