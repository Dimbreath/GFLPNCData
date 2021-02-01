-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102502 = class("bs_102502", LuaSkillBase)
local base = LuaSkillBase
bs_102502.config = {effectId1 = 10714, effectId2 = 10715, effectId3 = 10716, effectId4 = 10717, buffId = 230, buffId170 = 170, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10108, crit_formula = 0}
, 
HurtConfig2 = {hit_formula = 0, basehurt_formula = 10077, crit_formula = 0}
}
bs_102502.ctor = function(self)
  -- function num : 0_0
end

bs_102502.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_102502_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_102502_4", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_102502_12", 1, self.OnAfterPlaySkill)
end

bs_102502.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastAttackRole
  local target, target2 = nil, nil
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
    if targetList.Count > 0 then
      target = (targetList[0]).targetRole
    end
  end
  do
    do
      if target ~= nil then
        local targetlist2 = LuaSkillCtrl:CallTargetSelect(self, 46, 10, target)
        if targetlist2.Count > 0 then
          target2 = (targetlist2[0]).targetRole
        end
      end
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, target2)
      ;
      (self.caster):LookAtTarget(target)
      self:CallCasterWait(31)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 17, attackTrigger)
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId170, 1, (self.arglist)[4] + 27, true)
    end
  end
end

bs_102502.OnAttackTrigger = function(self, target, target2)
  -- function num : 0_3 , upvalues : _ENV
  if target2 ~= nil then
    if target.hp > 0 then
      LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self)
    end
    if target2.hp > 0 then
      LuaSkillCtrl:CallEffect(target2, (self.config).effectId1, self)
    end
    LuaSkillCtrl:StartTimer(nil, 10, function()
    -- function num : 0_3_0 , upvalues : target, target2, _ENV, self
    if target.hp > 0 and target2.hp > 0 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 1, (self.arglist)[4], true)
      LuaSkillCtrl:CallBuff(self, target2, (self.config).buffId, 1, (self.arglist)[4], true)
      self.target1 = target
      self.target2 = target2
      self.effect = LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self, nil, target2, nil, false)
      LuaSkillCtrl:StartTimer(nil, (self.arglist)[4], function()
      -- function num : 0_3_0_0 , upvalues : self, _ENV
      if self.effect ~= nil then
        (self.effect):Die()
        self.effect = nil
      end
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId170, 0, true)
    end
)
    end
    if target.hp <= 0 and target2.hp > 0 then
      LuaSkillCtrl:CallBuff(self, target2, (self.config).buffId, 2, (self.arglist)[4], true)
    end
    if target2.hp <= 0 and target.hp > 0 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 2, (self.arglist)[4], true)
    end
  end
)
  else
    LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self)
    LuaSkillCtrl:StartTimer(nil, 10, function()
    -- function num : 0_3_1 , upvalues : target, _ENV, self
    if target.hp > 0 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, 2, (self.arglist)[4], true)
      self.target1 = target
      self.target2 = nil
    end
  end
)
  end
end

bs_102502.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_4 , upvalues : _ENV
  if role:GetBuffTier((self.config).buffId) > 0 and (self.arglist)[3] > 0 then
    LuaSkillCtrl:CallEffect(role, (self.config).effectId4, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig2, nil, true)
    skillResult:EndResult()
  end
end

bs_102502.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_5 , upvalues : _ENV
  if target:GetBuffTier((self.config).buffId) == 1 and hurt > 0 and skill.dataId ~= 102502 and isTriggerSet ~= true then
    if target == self.target1 then
      if (self.target2).hp == 0 then
        LuaSkillCtrl:DispelBuff(self.target1, (self.config).BuffId, 0, true)
        if self.effect ~= nil then
          (self.effect):Die()
          self.effect = nil
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId170, 0, true)
        end
        return 
      end
      local hurt_callback = BindCallback(self, self.Onhurt, self.target2, hurt)
      LuaSkillCtrl:CallEffect(self.target2, (self.config).effectId3, self, nil, target, nil, false)
      LuaSkillCtrl:StartTimer(nil, 15, hurt_callback)
    else
      do
        if (self.target1).hp == 0 then
          LuaSkillCtrl:DispelBuff(self.target2, (self.config).BuffId, 0, true)
          if self.effect ~= nil then
            (self.effect):Die()
            self.effect = nil
            LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId170, 0, true)
          end
          return 
        end
        do
          local hurt_callback = BindCallback(self, self.Onhurt, self.target1, hurt)
          LuaSkillCtrl:CallEffect(self.target1, (self.config).effectId3, self, nil, target, nil, false)
          LuaSkillCtrl:StartTimer(nil, 15, hurt_callback)
          if target:GetBuffTier((self.config).buffId) == 2 and hurt > 0 and skill.dataId ~= 102502 and isTriggerSet ~= true then
            LuaSkillCtrl:CallEffect(target, (self.config).effectId4, self)
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
            LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {hurt}, true)
            skillResult:EndResult()
          end
        end
      end
    end
  end
end

bs_102502.Onhurt = function(self, target, hurt)
  -- function num : 0_6 , upvalues : _ENV
  if target.hp > 0 then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId4, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {hurt}, true)
    skillResult:EndResult()
  end
end

bs_102502.OnRoleDie = function(self, killer, role)
  -- function num : 0_7 , upvalues : _ENV
  if role == self.target1 or role == self.target2 then
    if (self.target1):GetBuffTier((self.config).buffId) == 1 then
      LuaSkillCtrl:DispelBuff(self.target1, (self.config).BuffId, 0, true)
    end
    if self.targt2 ~= nil and (self.target2):GetBuffTier((self.config).buffId) == 1 then
      LuaSkillCtrl:DispelBuff(self.target2, (self.config).BuffId, 0, true)
    end
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId170, 0, true)
  end
end

bs_102502.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102502

