local bs_1067 = class("bs_1067", LuaSkillBase)
local base = LuaSkillBase
bs_1067.config = {effectId_loop = 101207, effectId_line = 101208, effectId_weapon = 101210, effectId_start = 101206, buffId_66 = 3006, actionId = 1002, action_speed = 1, skill_time = 25, start_time = 20, 
HurtConfig = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0, crithur_ratio = 0, returndamage_formula = 0}
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
  if grid == nil then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return 
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local targetlist = LuaSkillCtrl:FindRolesAroundGrid(grid, 2)
  if targetlist ~= nil and targetlist.Count == 1 and targetlist[0] then
    target = LuaSkillCtrl:GetTargetWithGrid((targetlist[0]).x, (targetlist[0]).y)
  end
  self:CallCasterWait((self.config).skill_time)
  local triggerCallBack = BindCallback(self, self.OnActionCallBack, target, grid)
  ;
  (self.caster):LookAtTarget(target)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, triggerCallBack)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_weapon, self)
  LuaSkillCtrl:StartTimer(self, 7, function()
    -- function num : 0_2_0 , upvalues : _ENV, target, self
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_start, self)
  end
)
end

bs_1067.OnActionCallBack = function(self, target, grid)
  -- function num : 0_3 , upvalues : _ENV
  local effectBall = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_loop, self)
  local ballSkillData = {effectBall = effectBall, lastTime = (self.arglist)[4], 
roleMarks = {}
, 
arivedRoles = {}
}
  local target2 = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  local collisionTrigger = BindCallback(self, self.OnCollision, ballSkillData)
  local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
  local RemoveArrive = BindCallback(self, self.OnRemoveArrive, ballSkillData)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target2, 80, 1, eColliderInfluenceType.Enemy, collisionTrigger, nil, RemoveArrive, effectBall, true, false, EmissionArrive)
  if skillEmission == nil then
    return 
  end
  self:RealPlaySkill(ballSkillData, skillEmission)
end

bs_1067.RealPlaySkill = function(self, ballSkillData, skillEmission)
  -- function num : 0_4 , upvalues : _ENV
  local intervalTime = (self.arglist)[1]
  local timer = nil
  timer = LuaSkillCtrl:StartTimer(nil, intervalTime, function()
    -- function num : 0_4_0 , upvalues : skillEmission, self, ballSkillData, timer, intervalTime, _ENV
    if skillEmission.collider == nil then
      self:KillEffectBall(ballSkillData.effectBall)
      timer:Stop()
      return 
    end
    ballSkillData.lastTime = ballSkillData.lastTime - intervalTime
    if ballSkillData.lastTime < 0 then
      timer:Stop()
      self:PlaySkillEnd(ballSkillData, skillEmission)
      return 
    end
    for i = 1, #ballSkillData.arivedRoles do
      local role = (ballSkillData.arivedRoles)[i]
      if role.hp > 0 then
        LuaSkillCtrl:CallEffectWithEmission(skillEmission, (self.config).effectId_line, self, nil, role, nil, false)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {(self.arglist)[2]})
        skillResult:EndResult()
        if LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[5] then
          LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_66, 1, (self.arglist)[6])
        end
      end
    end
  end
, nil, -1)
end

bs_1067.PlaySkillEnd = function(self, ballSkillData, skillEmission)
  -- function num : 0_5
  self:KillEffectBall(ballSkillData.effectBall)
  skillEmission:EndAndDisposeEmission()
end

bs_1067.KillEffectBall = function(self, effectBall)
  -- function num : 0_6
  if effectBall ~= nil then
    effectBall:Die()
    effectBall = nil
  end
end

bs_1067.OnCollision = function(self, ballSkillData, collider, index, entity)
  -- function num : 0_7 , upvalues : _ENV
  if (ballSkillData.roleMarks)[entity] == nil then
    (table.insert)(ballSkillData.arivedRoles, entity)
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (ballSkillData.roleMarks)[entity] = true
  end
end

bs_1067.OnRemoveArrive = function(self, ballSkillData, collider, entity)
  -- function num : 0_8 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  if (ballSkillData.roleMarks)[entity] then
    (ballSkillData.roleMarks)[entity] = nil
    ;
    (table.removebyvalue)(ballSkillData.arivedRoles, entity)
  end
end

bs_1067.OnEmissionArrive = function(self, skillEmission)
  -- function num : 0_9 , upvalues : _ENV
  local target_new = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if target_new.Count > 0 then
    local target_real = (target_new[0]).targetRole
    local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
    LuaSkillCtrl:CallRestartEmit(self, skillEmission, 1, target_real, true, false, EmissionArrive)
  end
end

bs_1067.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1067

