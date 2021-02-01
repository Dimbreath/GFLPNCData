-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10158 = class("bs_10158", LuaSkillBase)
local base = LuaSkillBase
bs_10158.config = {effectId = 10258, effectDamageId = 10259}
bs_10158.ctor = function(self)
  -- function num : 0_0
end

bs_10158.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_10158_3", 1, self.OnAfterHurt)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10158_11", 1, self.OnBeforePlaySkill)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10158_AfterSkillCast"] = false
end

bs_10158.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  do
    if sender == self.caster and not isMiss and not skill.isCommonAttack and ((self.caster).recordTable)["10158_AfterSkillCast"] and not isTriggerSet and self.effect == nil then
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, 20, 10, target)
      if targetlist.Count > 0 then
        self.effect = LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId, self, nil, target)
        -- DECOMPILER ERROR at PC41: Confused about usage of register: R10 in 'UnsetPending'

        ;
        ((self.caster).recordTable)["10158_target1"] = target
        -- DECOMPILER ERROR at PC46: Confused about usage of register: R10 in 'UnsetPending'

        ;
        ((self.caster).recordTable)["10158_target2"] = (targetlist[0]).targetRole
      end
      if self.damTimer == nil and (self.arglist)[1] ~= nil then
        self.damTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], self.CallBack, self, 1)
      end
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["10158_AfterSkillCast"] = false
    end
    do
      if self.effect ~= nil and sender == self.caster and target == ((self.caster).recordTable)["10158_target1"] and ((self.caster).recordTable)["10158_target2"] ~= nil then
        local damage = (math.max)(1, hurt * (self.arglist)[2] // 1000)
        LuaSkillCtrl:RemoveLife(damage, self, ((self.caster).recordTable)["10158_target2"], true, true)
        LuaSkillCtrl:CallEffect(((self.caster).recordTable)["10158_target2"], (self.config).effectDamageId, self)
        LuaSkillCtrl:CallEffect(target, (self.config).effectDamageId, self)
      end
      if target.hp <= hurt and self.effect ~= nil then
        (self.effect):Die()
        self.effect = nil
      end
    end
  end
end

bs_10158.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  if (context.skill).maker == self.caster and not (context.skill).isCommonAttack then
    ((self.caster).recordTable)["10158_AfterSkillCast"] = true
  end
end

bs_10158.CallBack = function(self)
  -- function num : 0_4
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10158_target1"] = nil
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10158_target2"] = nil
end

bs_10158.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

return bs_10158

