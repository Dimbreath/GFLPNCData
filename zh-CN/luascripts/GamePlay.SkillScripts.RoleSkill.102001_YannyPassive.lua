-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102001 = class("bs_102001", LuaSkillBase)
local base = LuaSkillBase
bs_102001.config = {actionId = 1001, effectId = 10399, effectIdSj = 10401, 
hurt_config = {basehurt_formula = 10007}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
}
bs_102001.ctor = function(self)
  -- function num : 0_0
end

bs_102001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_102001_1", 1, self.OnBeforePlaySkill)
end

bs_102001.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster and (context.skill).isCommonAttack then
    local realTarget = nil
    if ((self.caster).recordTable).lastAttackRole ~= nil and LuaSkillCtrl:IsAbleAttackTarget(self.caster, ((self.caster).recordTable).lastAttackRole, 1) then
      realTarget = ((self.caster).recordTable).lastAttackRole
    end
    do
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
      if targetlist.Count > 0 and LuaSkillCtrl:IsAbleAttackTarget(self.caster, (targetlist[0]).targetRole, 1) then
        realTarget = (targetlist[0]).targetRole
      end
      if realTarget == nil then
        return 
      end
      local realList = {}
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, realTarget, (self.config).aoe_config)
      if (skillResult.roleList).Count ~= 0 then
        for i = 0, (skillResult.roleList).Count - 1 do
          local role = (skillResult.roleList)[i]
          if LuaSkillCtrl:IsRoleAdjacent(role, self.caster) then
            (table.insert)(realList, role)
          end
        end
      end
      do
        skillResult:EndResult()
        if #realList >= 2 then
          context.active = false
          self:RealPlaySkill(realList, realTarget)
        end
      end
    end
  end
end

bs_102001.RealPlaySkill = function(self, targetList, mainTarget)
  -- function num : 0_3 , upvalues : _ENV
  (self.caster):LookAtTarget(mainTarget)
  self:CallCasterWait(41)
  LuaSkillCtrl:CallRoleAction(self.caster, 1001, 1)
  LuaSkillCtrl:CallEffect(mainTarget, (self.config).effectId, self)
  LuaSkillCtrl:StartTimer(self, 12, function()
    -- function num : 0_3_0 , upvalues : targetList, _ENV, self
    for i = 1, #targetList do
      if targetList[i] ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i], (self.config).hurtConfig)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
        skillResult:EndResult()
      end
    end
    if (self.arglist)[2] == 1 then
      local heal = ((self.caster).maxHp - (self.caster).hp) * (self.arglist)[3] // 1000
      if heal < 1 then
        heal = 1
      end
      LuaSkillCtrl:CallHeal(heal, self, self.caster)
    end
  end
, nil, 0)
end

bs_102001.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102001

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102001 = class("bs_102001", LuaSkillBase)
local base = LuaSkillBase
bs_102001.config = {
    actionId = 1001,
    effectId = 10399,
    effectIdSj = 10401,
    hurt_config = {basehurt_formula = 10007},
    aoe_config = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
}
bs_102001.ctor = function(self)
    -- function num : 0_0
end

bs_102001.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_102001_1", 1,
                    self.OnBeforePlaySkill)
end

bs_102001.OnBeforePlaySkill = function(self, role, context)
    -- function num : 0_2 , upvalues : _ENV
    if role == self.caster and (context.skill).isCommonAttack then
        local realTarget = nil
        if ((self.caster).recordTable).lastAttackRole ~= nil and
            LuaSkillCtrl:IsAbleAttackTarget(self.caster,
                                            ((self.caster).recordTable).lastAttackRole,
                                            1) then
            realTarget = ((self.caster).recordTable).lastAttackRole
        end
        do
            local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
            if targetlist.Count > 0 and
                LuaSkillCtrl:IsAbleAttackTarget(self.caster,
                                                (targetlist[0]).targetRole, 1) then
                realTarget = (targetlist[0]).targetRole
            end
            if realTarget == nil then return end
            local realList = {}
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     realTarget,
                                                                     (self.config).aoe_config)
            if (skillResult.roleList).Count ~= 0 then
                for i = 0, (skillResult.roleList).Count - 1 do
                    local role = (skillResult.roleList)[i]
                    if LuaSkillCtrl:IsRoleAdjacent(role, self.caster) then
                        (table.insert)(realList, role)
                    end
                end
            end
            do
                skillResult:EndResult()
                if #realList >= 2 then
                    context.active = false
                    self:RealPlaySkill(realList, realTarget)
                end
            end
        end
    end
end

bs_102001.RealPlaySkill = function(self, targetList, mainTarget)
    -- function num : 0_3 , upvalues : _ENV
    (self.caster):LookAtTarget(mainTarget)
    self:CallCasterWait(41)
    LuaSkillCtrl:CallRoleAction(self.caster, 1001, 1)
    LuaSkillCtrl:CallEffect(mainTarget, (self.config).effectId, self)
    LuaSkillCtrl:StartTimer(self, 12, function()
        -- function num : 0_3_0 , upvalues : targetList, _ENV, self
        for i = 1, #targetList do
            if targetList[i] ~= nil then
                local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                         targetList[i],
                                                                         (self.config).hurtConfig)
                LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
                skillResult:EndResult()
            end
        end
        if (self.arglist)[2] == 1 then
            local heal = ((self.caster).maxHp - (self.caster).hp) *
                             (self.arglist)[3] // 1000
            if heal < 1 then heal = 1 end
            LuaSkillCtrl:CallHeal(heal, self, self.caster)
        end
    end, nil, 0)
end

bs_102001.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_102001

