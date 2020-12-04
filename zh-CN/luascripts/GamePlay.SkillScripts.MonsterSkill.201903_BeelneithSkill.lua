-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201903 = class("bs_201903", LuaSkillBase)
local base = LuaSkillBase
bs_201903.config = {action1 = 1008, action2 = 1009, effectstart = 10411, effectup = 10412, effectdown = 10413, effectdamge = 10414, effecthit = 10415, effectQ = 10510, effectQhit = 10511, effectQend = 10512, buffId = 71, buffIdSC = 186, buffIdSY = 187, buffId196 = 196, 
HurtConfig = {basehurt_formula = 10077}
}
bs_201903.ctor = function(self)
  -- function num : 0_0
end

bs_201903.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_201903.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
  if targetlist == nil or targetlist.Count == 0 then
    return 
  end
  ;
  (self.caster):LookAtTarget((targetlist[0]).targetRole)
  self:CallCasterWait(999)
  local triggerCallBack = BindCallback(self, self.OnActionCallBack, (targetlist[0]).targetRole)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectstart, self)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1008, 1, 15, triggerCallBack)
end

bs_201903.OnActionCallBack = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId196, 1, (self.arglist)[1] + 3)
  local targetgrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.effectQ = LuaSkillCtrl:CallEffect(targetgrid, (self.config).effectQ, self)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectup, self)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
  local cusEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectdamge, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local EmissionArrive = BindCallback(self, self.OnEmissionArrive, targetgrid, target)
  self.skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 20, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, false, EmissionArrive)
  local over = BindCallback(self, self.OnOver)
  self.timeover = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], over)
end

bs_201903.OnCollision = function(self, index, entity)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(entity, (self.config).effecthit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
  skillResult:EndResult()
end

bs_201903.OnEmissionArrive = function(self, targetgrid, lasttarget, skillEmission)
  -- function num : 0_5 , upvalues : _ENV
  local target_new = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
  if target_new.Count > 0 then
    local target_real = (target_new[0]).targetRole
    if (target_new[0]).targetRole == lasttarget then
      if target_new.Count > 1 then
        target_real = (target_new[1]).targetRole
      else
        local grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
    -- function num : 0_5_0
    do return x > -1 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        local targetgrid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
        target_real = targetgrid
      end
    end
    do
      lasttarget = target_real
      do
        local EmissionArrive = BindCallback(self, self.OnEmissionArrive, targetgrid, lasttarget)
        LuaSkillCtrl:CallRestartEmit(self, skillEmission, 10, target_real, true, false, EmissionArrive)
        LuaSkillCtrl:CallEffect(targetgrid, (self.config).effectQhit, self)
        self:OnOver()
        if self.timeover ~= nil then
          (self.timeover):Stop()
          self.timeover = nil
        end
      end
    end
  end
end

bs_201903.OnOver = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.skillEmission ~= nil then
    (self.skillEmission):EndAndDisposeEmission()
    self.skillEmission = nil
  end
  if self.effectQ ~= nil then
    (self.effectQ):Die()
    self.effectQ = nil
  end
  local grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
    -- function num : 0_6_0
    do return x > -1 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  LuaSkillCtrl:SetRolePos(grid, self.caster)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectdown, self)
  self:CancleCasterWait()
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 1)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId196, 1)
end

bs_201903.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_201903

