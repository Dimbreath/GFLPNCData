-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103902 = class("bs_103902", LuaSkillBase)
local base = LuaSkillBase
bs_103902.config = {
hurt_config = {basehurt_formula = 10077}
, 
hurt_config1 = {basehurt_formula = 10080}
, beatBackBuff = 151, stunBuff = 66, effectIdStart = 10465, effectIdEnd = 10468, effectIdAttack = 10467, effectIdAttackSj = 10516, effectIdSj = 10469, effectIdEnd2 = 10535, effectIdAttack2 = 10534, actionIdStart1 = 1008, actionIdLoop1 = 1007, actionIdEnd1 = 1009, actionIdStart2 = 1022, actionIdLoop2 = 1023, actionIdEnd2 = 1024}
bs_103902.ctor = function(self)
  -- function num : 0_0
end

bs_103902.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103902.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.effectEnd = (self.config).effectIdEnd
  if LuaSkillCtrl:CallRange(1, 1000) <= 500 then
    self.actionStart = (self.config).actionIdStart1
    self.actionLoop = (self.config).actionIdLoop1
    self.actionEnd = (self.config).actionIdEnd1
    self.effectAttack = (self.config).effectIdAttack
  else
    self.actionStart = (self.config).actionIdStart2
    self.actionLoop = (self.config).actionIdLoop2
    self.actionEnd = (self.config).actionIdEnd2
    self.effectAttack = (self.config).effectIdAttack2
  end
  local target = nil
  local lastAttackRole = ((self.caster).recordTable).lastAttackRole
  if lastAttackRole ~= nil and lastAttackRole.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, lastAttackRole, 1) then
    target = lastAttackRole
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R5 in 'UnsetPending'

    if targetList.Count ~= 0 then
      ((self.caster).recordTable).lastAttackRole = (targetList[0]).targetRole
      target = (targetList[0]).targetRole
    end
  end
  do
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, 1) then
      (self.caster):LookAtTarget(target)
      if LuaSkillCtrl:IsAbleAttackCheckExcludedDir(self.caster, target, 30) then
        self.rotateWaited = true
        LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, self.RealPlaySkill, target, data))
      else
        self.rotateWaited = false
        self:RealPlaySkill(target, data)
      end
    end
  end
end

bs_103902.RealPlaySkill = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  if target == nil then
    return 
  end
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, 1) then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    self:CallCasterWait(50)
    ;
    (self.caster):LookAtTarget(target)
    LuaSkillCtrl:CallRoleAction(self.caster, self.actionStart, 1)
    self.effectIdStart = LuaSkillCtrl:CallEffect(target, (self.config).effectIdStart, self)
    LuaSkillCtrl:StartTimer(self, 17, function()
    -- function num : 0_3_0 , upvalues : self, target
    self:multiAttack(target)
  end
)
  end
end

bs_103902.multiAttack = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, 1) then
    (self.caster):LookAtTarget(target)
    LuaSkillCtrl:CallRoleAction(self.caster, self.actionLoop, 1)
    LuaSkillCtrl:CallBuff(self, target, (self.config).stunBuff, 1, (self.arglist)[1])
    self.effectIdAttack = LuaSkillCtrl:CallEffect(target, self.effectAttack, self)
    self.effectIdAttackSj = LuaSkillCtrl:CallEffect(target, (self.config).effectIdAttackSj, self)
    LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_4_0 , upvalues : self, target
    self:hurtUnit(target)
  end
)
    LuaSkillCtrl:StartTimer(self, 6, function()
    -- function num : 0_4_1 , upvalues : self, target
    self:hurtUnit(target)
  end
)
    LuaSkillCtrl:StartTimer(self, 9, function()
    -- function num : 0_4_2 , upvalues : self, target
    self:hurtUnit(target)
  end
)
    LuaSkillCtrl:StartTimer(self, 12, function()
    -- function num : 0_4_3 , upvalues : self, target
    self:hurtUnit(target)
  end
)
    LuaSkillCtrl:StartTimer(self, 15, function()
    -- function num : 0_4_4 , upvalues : self, target
    self:hurtUnit(target)
    self:finalAttack(target)
  end
)
  else
    self:CancleCasterWait()
    if self.effectIdStart ~= nil then
      (self.effectIdStart):Die()
      self.effectIdStart = nil
    end
    if self.effectIdAttack ~= nil then
      (self.effectIdAttack):Die()
      self.effectIdAttack = nil
    end
  end
end

bs_103902.hurtUnit = function(self, target)
  -- function num : 0_5 , upvalues : _ENV
  if target == nil or target.hp <= 0 then
    self:BreakSkill()
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
  skillResult:EndResult()
end

bs_103902.finalAttack = function(self, target)
  -- function num : 0_6 , upvalues : _ENV
  if self.effectIdAttack ~= nil then
    (self.effectIdAttack):Die()
    self.effectIdAttack = nil
  end
  if self.effectIdAttackSj ~= nil then
    (self.effectIdAttackSj):Die()
    self.effectIdAttackSj = nil
  end
  if self.effectIdStart ~= nil then
    (self.effectIdStart):Die()
    self.effectIdStart = nil
  end
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, 1) then
    LuaSkillCtrl:CallRoleAction(self.caster, self.actionEnd, 1)
    ;
    (self.caster):LookAtTarget(target)
    LuaSkillCtrl:StartTimer(self, 8, function()
    -- function num : 0_6_0 , upvalues : _ENV, self, target
    LuaSkillCtrl:CallBuff(self, target, (self.config).stunBuff, 1, (self.arglist)[3])
    self.effectIdEnd = LuaSkillCtrl:CallEffect(target, self.effectEnd, self)
    self.effectIdSj = LuaSkillCtrl:CallEffect(target, (self.config).effectIdSj, self)
    local targetX = target.x
    local targetY = target.y
    local buffCheck = LuaSkillCtrl:CallBuffLifeEvent(self, target, (self.config).beatBackBuff, 1, 3, BindCallback(self, self.OnBuffLifeEvent, target))
    if (self.arglist)[4] == 1 and buffCheck ~= nil and target.x == targetX and target.y == targetY then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config1)
      skillResult:EndResult()
    end
  end
)
  else
    self:CancleCasterWait()
  end
end

bs_103902.OnBuffLifeEvent = function(self, role, lifeType, arg)
  -- function num : 0_7 , upvalues : _ENV
  if lifeType == eBuffLifeEvent.NewAdd then
    (role.lsObject):StartLocalScale((Vector3.New)(1.4, 1.4, 0.6), 0.2)
    LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_7_0 , upvalues : role, _ENV
    (role.lsObject):StartLocalScale((Vector3.New)(1, 1, 1), 0.2)
  end
)
  end
end

bs_103902.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103902

