-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1067 = class("bs_1067", LuaSkillBase)
local base = LuaSkillBase
bs_1067.config = {effectId1 = 10563, effectId2 = 10365, effectId3 = 10363, effectId4 = 10367, effectId5 = 10362, buffId = 124, 
HurtConfig = {def_formula = 9996, basehurt_formula = 10077, minhurt_formula = 9994, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000}
}
bs_1067.ctor = function(self)
  -- function num : 0_0
end

bs_1067.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_1067.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local grid = LuaSkillCtrl:CallFindGridMostRolesArounded(2)
  if grid ~= nil then
    local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    self:CallCasterWait(35)
    local triggerCallBack = BindCallback(self, self.OnActionCallBack, target, grid)
    LuaSkillCtrl:CallEffect(target, (self.config).effectId3, self)
    self.weaponeffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId4, self)
    self:PlaySkillEnd()
    ;
    (self.caster):LookAtTarget(target)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, triggerCallBack)
    self.mark = {}
    self.arivedRoles = {}
    self.realTime = 0
    self.effectBall = nil
    self.skillEmission = nil
  end
end

bs_1067.OnActionCallBack = function(self, target, grid)
  -- function num : 0_3 , upvalues : _ENV
  if self.weaponeffect ~= nil then
    (self.weaponeffect):Die()
    self.weaponeffect = nil
  end
  self.effectBall = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
  local target2 = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
  local RemoveArrive = BindCallback(self, self.OnRemoveArrive)
  self.skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target2, 80, 1, eColliderInfluenceType.Enemy, collisionTrigger, nil, RemoveArrive, self.effectBall, true, false, EmissionArrive)
  self:RealPlaySkill()
end

bs_1067.RealPlaySkill = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self.arglist)[4] < self.realTime then
    self:PlaySkillEnd()
  else
    if self.arivedRoles ~= nil and #self.arivedRoles > 0 then
      for i = 1, #self.arivedRoles do
        local role = (self.arivedRoles)[i]
        if role.hp > 0 and self.skillEmission ~= nil then
          LuaSkillCtrl:CallEffectWithEmission(self.skillEmission, (self.config).effectId2, self, nil, role, nil, false)
          LuaSkillCtrl:CallEffect(role, (self.config).effectId5, self)
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
          skillResult:EndResult()
          if (self.arglist)[3] >= 1 and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[5] then
            LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, 1, 1)
          end
        end
      end
    end
    do
      self.realTime = self.realTime + (self.arglist)[1]
      LuaSkillCtrl:StartTimer(self, (self.arglist)[1], function()
    -- function num : 0_4_0 , upvalues : self
    self:RealPlaySkill()
  end
)
    end
  end
end

bs_1067.PlaySkillEnd = function(self)
  -- function num : 0_5
  self.arivedRoles = {}
  self.mark = {}
  self.realTime = 0
  if self.effectBall ~= nil then
    (self.effectBall):Die()
    self.effectBall = nil
  end
  if self.skillEmission ~= nil then
    (self.skillEmission):EndAndDisposeEmission()
    self.skillEmission = nil
  end
end

bs_1067.OnCollision = function(self, index, entity)
  -- function num : 0_6 , upvalues : _ENV
  if (self.mark)[entity] == nil or (self.mark)[entity] == 0 then
    (table.insert)(self.arivedRoles, entity)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.mark)[entity] = 1
  end
end

bs_1067.OnRemoveArrive = function(self, entity)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  if (self.mark)[entity] == 1 then
    (self.mark)[entity] = 0
    ;
    (table.removebyvalue)(self.arivedRoles, entity)
  end
end

bs_1067.OnEmissionArrive = function(self, skillEmission)
  -- function num : 0_8 , upvalues : _ENV
  local target_new = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if target_new.Count > 0 then
    local target_real = (target_new[0]).targetRole
    local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
    LuaSkillCtrl:CallRestartEmit(self, skillEmission, 1, target_real, true, false, EmissionArrive)
  end
end

bs_1067.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1067

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1067 = class("bs_1067", LuaSkillBase)
local base = LuaSkillBase
bs_1067.config = {
    effectId1 = 10563,
    effectId2 = 10365,
    effectId3 = 10363,
    effectId4 = 10367,
    effectId5 = 10362,
    buffId = 124,
    HurtConfig = {
        def_formula = 9996,
        basehurt_formula = 10077,
        minhurt_formula = 9994,
        crithur_ratio = 9995,
        correct_formula = 9989,
        lifesteal_formula = 1001,
        spell_lifesteal_formula = 1002,
        returndamage_formula = 1000
    }
}
bs_1067.ctor = function(self)
    -- function num : 0_0
end

bs_1067.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_1067.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local grid = LuaSkillCtrl:CallFindGridMostRolesArounded(2)
    if grid ~= nil then
        local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
        self:CallCasterWait(35)
        local triggerCallBack = BindCallback(self, self.OnActionCallBack,
                                             target, grid)
        LuaSkillCtrl:CallEffect(target, (self.config).effectId3, self)
        self.weaponeffect = LuaSkillCtrl:CallEffect(self.caster,
                                                    (self.config).effectId4,
                                                    self)
        self:PlaySkillEnd();
        (self.caster):LookAtTarget(target)
        LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20,
                                               triggerCallBack)
        self.mark = {}
        self.arivedRoles = {}
        self.realTime = 0
        self.effectBall = nil
        self.skillEmission = nil
    end
end

bs_1067.OnActionCallBack = function(self, target, grid)
    -- function num : 0_3 , upvalues : _ENV
    if self.weaponeffect ~= nil then
        (self.weaponeffect):Die()
        self.weaponeffect = nil
    end
    self.effectBall = LuaSkillCtrl:CallEffect(self.caster,
                                              (self.config).effectId1, self)
    local target2 = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    local collisionTrigger = BindCallback(self, self.OnCollision)
    local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
    local RemoveArrive = BindCallback(self, self.OnRemoveArrive)
    self.skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self,
                                                                    self.caster,
                                                                    target2, 80,
                                                                    1,
                                                                    eColliderInfluenceType.Enemy,
                                                                    collisionTrigger,
                                                                    nil,
                                                                    RemoveArrive,
                                                                    self.effectBall,
                                                                    true, false,
                                                                    EmissionArrive)
    self:RealPlaySkill()
end

bs_1067.RealPlaySkill = function(self)
    -- function num : 0_4 , upvalues : _ENV
    if (self.arglist)[4] < self.realTime then
        self:PlaySkillEnd()
    else
        if self.arivedRoles ~= nil and #self.arivedRoles > 0 then
            for i = 1, #self.arivedRoles do
                local role = (self.arivedRoles)[i]
                if role.hp > 0 and self.skillEmission ~= nil then
                    LuaSkillCtrl:CallEffectWithEmission(self.skillEmission,
                                                        (self.config).effectId2,
                                                        self, nil, role, nil,
                                                        false)
                    LuaSkillCtrl:CallEffect(role, (self.config).effectId5, self)
                    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(
                                            self, role)
                    LuaSkillCtrl:HurtResult(skillResult,
                                            (self.config).HurtConfig)
                    skillResult:EndResult()
                    if (self.arglist)[3] >= 1 and
                        LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[5] then
                        LuaSkillCtrl:CallBuff(self, role, (self.config).buffId,
                                              1, 1)
                    end
                end
            end
        end
        do
            self.realTime = self.realTime + (self.arglist)[1]
            LuaSkillCtrl:StartTimer(self, (self.arglist)[1], function()
                -- function num : 0_4_0 , upvalues : self
                self:RealPlaySkill()
            end)
        end
    end
end

bs_1067.PlaySkillEnd = function(self)
    -- function num : 0_5
    self.arivedRoles = {}
    self.mark = {}
    self.realTime = 0
    if self.effectBall ~= nil then
        (self.effectBall):Die()
        self.effectBall = nil
    end
    if self.skillEmission ~= nil then
        (self.skillEmission):EndAndDisposeEmission()
        self.skillEmission = nil
    end
end

bs_1067.OnCollision = function(self, index, entity)
    -- function num : 0_6 , upvalues : _ENV
    if (self.mark)[entity] == nil or (self.mark)[entity] == 0 then
        (table.insert)(self.arivedRoles, entity) -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.mark)[entity] = 1
    end
end

bs_1067.OnRemoveArrive = function(self, entity)
    -- function num : 0_7 , upvalues : _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

    if (self.mark)[entity] == 1 then
        (self.mark)[entity] = 0;
        (table.removebyvalue)(self.arivedRoles, entity)
    end
end

bs_1067.OnEmissionArrive = function(self, skillEmission)
    -- function num : 0_8 , upvalues : _ENV
    local target_new = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
    if target_new.Count > 0 then
        local target_real = (target_new[0]).targetRole
        local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
        LuaSkillCtrl:CallRestartEmit(self, skillEmission, 1, target_real, true,
                                     false, EmissionArrive)
    end
end

bs_1067.OnCasterDie = function(self)
    -- function num : 0_9 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1067

