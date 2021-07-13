-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201905 = class("bs_201905", LuaSkillBase)
local base = LuaSkillBase
bs_201905.config = {startAnimId = 1008, endAnimId = 1009, effectstart = 10411, effectup = 10412, effectdown = 10413, effectdamge = 10414, effecthit = 10415, effectQ = 10510, effectQhit = 10511, effectQend = 10512, buffId_71 = 71, buffIdSC = 186, buffIdSY = 187, buffId_196 = 196, buffID_1158 = 1158, 
HurtConfig = {basehurt_formula = 10076, hit_formula = 0, crit_formula = 0, correct_formula = 9989}
, 
aoe_config = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1}
, 
hurt_config = {basehurt_formula = 10156}
, radius = 10, speed = 10, start_time = 15, select_id = 42, select_range = 10, start_x = 3, start_y = 2, effectRoot = 10850}
bs_201905.ctor = function(self)
  -- function num : 0_0
end

bs_201905.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).SkillFlag = false
end

bs_201905.PlaySkill = function(self, data)
  -- function num : 0_2
  self.realTime = 0
  self:RealPlaySkill()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).SkillFlag = true
end

bs_201905.RealPlaySkill = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
  if targetlist == nil or targetlist.Count == 0 then
    return 
  end
  ;
  (self.caster):LookAtTarget((targetlist[0]).targetRole)
  self:CallCasterWait(999)
  local triggerCallBack = BindCallback(self, self.OnActionCallBack, (targetlist[0]).targetRole)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectstart, self)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimId, 1, (self.config).start_time, triggerCallBack)
end

bs_201905.OnActionCallBack = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_196, 1, (self.arglist)[1] + 3)
  local targetgrid = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.effectQ = LuaSkillCtrl:CallEffect(targetgrid, (self.config).effectQ, self)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectup, self)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_71, 1)
  local cusEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectdamge, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local EmissionArrive = BindCallback(self, self.OnEmissionArrive, targetgrid, target)
  self.skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, (self.config).radius, (self.config).speed, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, true, EmissionArrive)
end

bs_201905.OnCollision = function(self, collider, index, entity)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(entity, (self.config).effecthit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:PlayAuHit(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
  skillResult:EndResult()
end

bs_201905.OnEmissionArrive = function(self, targetgrid, lasttarget, skillEmission)
  -- function num : 0_6
  self.realTime = self.realTime + 1
  self:OnOver()
end

bs_201905.OnOver = function(self)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.caster).recordTable).SkillFlag = false
  if self.skillEmission ~= nil then
    (self.skillEmission):EndAndDisposeEmission()
    self.skillEmission = nil
  end
  if self.effectQ ~= nil then
    (self.effectQ):Die()
    self.effectQ = nil
  end
  if self.realTime < (self.arglist)[2] then
    local grid = LuaSkillCtrl:FindEmptyGrid(nil)
    if grid ~= nil then
      LuaSkillCtrl:SetRolePos(grid, self.caster)
    end
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectdown, self)
    self:CancleCasterWait()
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_71, 1)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 1)
    self:RealPlaySkill()
  else
    do
      if ((self.caster).recordTable).lastAttackRole ~= nil then
        local targetRole = ((self.caster).recordTable).lastAttackRole
        local grid = LuaSkillCtrl:FindEmptyGridAroundRole(targetRole)
        if grid ~= nil then
          LuaSkillCtrl:SetRolePos(grid, self.caster)
          LuaSkillCtrl:CallEffect(self.caster, (self.config).effectdown, self)
          self:CancleCasterWait()
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_71, 1)
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 1)
        else
          local grid = LuaSkillCtrl:FindEmptyGrid(nil)
          if grid ~= nil then
            LuaSkillCtrl:SetRolePos(grid, self.caster)
          end
          LuaSkillCtrl:CallEffect(self.caster, (self.config).effectdown, self)
          self:CancleCasterWait()
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_71, 1)
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 1)
        end
      else
        do
          do
            local grid = LuaSkillCtrl:FindEmptyGrid(nil)
            if grid ~= nil then
              LuaSkillCtrl:SetRolePos(grid, self.caster)
            end
            LuaSkillCtrl:CallEffect(self.caster, (self.config).effectdown, self)
            self:CancleCasterWait()
            LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
            LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_71, 1)
            LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 1)
            if ((self.caster).recordTable)["20046_root4arg1"] ~= nil then
              local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).aoe_config)
              LuaSkillCtrl:PlayAuHit(self, self.caster)
              LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {((self.caster).recordTable)["20046_root4arg1"]}, false)
              LuaSkillCtrl:CallEffect(self.caster, (self.config).effectRoot, self)
              skillResult:EndResult()
            end
          end
        end
      end
    end
  end
end

bs_201905.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  self.realTime = 100
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  if self.skillEmission ~= nil then
    (self.skillEmission):EndAndDisposeEmission()
    self.skillEmission = nil
  end
  if self.effectQ ~= nil then
    (self.effectQ):Die()
    self.effectQ = nil
  end
end

bs_201905.OnBreakSkill = function(self, role)
  -- function num : 0_9 , upvalues : base
  (base.OnBreakSkill)(self, role)
end

bs_201905.LuaDispose = function(self)
  -- function num : 0_10 , upvalues : base
  (base.LuaDispose)(self)
  self.effectQ = nil
  self.skillEmission = nil
end

return bs_201905

