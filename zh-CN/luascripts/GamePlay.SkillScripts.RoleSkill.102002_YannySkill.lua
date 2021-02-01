-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102002 = class("bs_102002", LuaSkillBase)
local base = LuaSkillBase
bs_102002.config = {action_start = 1008, action_loop = 1007, action_end = 1009, stun_buff = 185, cant_action_buff = 69, hookSpeed = 12, effectId = 10549}
bs_102002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_102002_1", 1, self.BeforeEndBattle)
  self:BindHookObj()
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102002_2", 1, self.OnBattleStart)
end

bs_102002.BindHookObj = function(self)
  -- function num : 0_1
  local bind = self:GetSelfBindingObj()
  if bind ~= nil then
    self.weaponChildren = bind.weaponChildren
    self.weaponRoot = bind.weaponRoot
    self.casterRoot = bind.casterRoot
  end
end

bs_102002.OnBattleStart = function(self)
  -- function num : 0_2
  if self:IsReadyToTake() then
    self:PlaySkill()
    self:OnSkillTake()
  end
end

bs_102002.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local emptyGrid = LuaSkillCtrl:FindRoleRightEmptyGrid(self.caster, 10)
  if emptyGrid ~= nil then
    local targetRole = LuaSkillCtrl:CallRightMaxDirEnemy(self.caster)
    if targetRole == nil then
      return 
    end
    local roleToEmpty = (math.abs)((self.caster).x - emptyGrid.x)
    local roleToTarget = (math.abs)((self.caster).x - targetRole.x)
    local emptyToTarget = (math.abs)(emptyGrid.x - targetRole.x)
    if emptyToTarget >= 1 and roleToEmpty < roleToTarget then
      local distance = LuaSkillCtrl:GetGridsDistance((self.caster).x, (self.caster).y, targetRole.x, targetRole.y)
      local flyTime = distance * 15 // (self.config).hookSpeed
      flyTime = (math.max)(3, flyTime)
      local position = ((targetRole.lsObject).localPosition):ToVector3() - (Vector3.New)(0, 0, 1)
      local startFlyHookTime = 12 + flyTime
      local hookArriveTime = startFlyHookTime + flyTime
      local backHookTime = hookArriveTime + flyTime
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).cant_action_buff, 1, backHookTime)
      LuaSkillCtrl:PreSetRolePos(emptyGrid, targetRole)
      self:CallCasterWait(backHookTime + 2)
      ;
      (self.caster):LookAtTarget(targetRole)
      LuaSkillCtrl:StartTimer(nil, 3, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).action_start)
  end
, self)
      LuaSkillCtrl:StartTimer(nil, startFlyHookTime, BindCallback(self, self.OnFlyHook, position, flyTime / 15))
      LuaSkillCtrl:StartTimer(nil, hookArriveTime, BindCallback(self, self.OnHooKGetRole, targetRole, emptyGrid, flyTime))
      LuaSkillCtrl:StartTimer(nil, backHookTime, BindCallback(self, self.OnHookEnd, targetRole))
    end
  end
end

bs_102002.OnFlyHook = function(self, targetPos, time)
  -- function num : 0_4
  if self.weaponRoot ~= nil and self.weaponChildren ~= nil and self.casterRoot ~= nil then
    (self.weaponRoot):SetParent(self.casterRoot, false)
    ;
    (self.weaponChildren):SetParent(self.weaponRoot, false)
    ;
    ((self.caster).lsObject):SelectTransAndStartMove(self.weaponRoot, targetPos, time)
  end
end

bs_102002.OnHooKGetRole = function(self, role, backGrid, duration)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  if self.weaponRoot ~= nil then
    (self.weaponRoot).localRotation = (Quaternion.Euler)(0, 0, 0)
    ;
    (self.weaponRoot):SetParent((role.lsObject).transform)
  end
  LuaSkillCtrl:CanclePreSetPos(role)
  LuaSkillCtrl:CallPhaseMove(self, role, backGrid.x, backGrid.y, duration)
end

bs_102002.OnHookEnd = function(self, targetRole)
  -- function num : 0_6 , upvalues : _ENV
  self:ResetActionState()
  local buffDuration = (self.arglist)[1]
  if buffDuration > 0 then
    LuaSkillCtrl:CallBuff(self, targetRole, (self.config).stun_buff, 1, buffDuration)
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  if (math.abs)(targetRole.x - (self.caster).x) <= 1 then
    ((self.caster).recordTable).lastAttackRole = targetRole
  end
end

bs_102002.ResetActionState = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.weaponRoot ~= nil and self.weaponChildren ~= nil and (self.weaponRoot).parent ~= self.weaponChildren then
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).action_end)
    ;
    (self.weaponChildren):SetParent(self.casterRoot, false)
    ;
    (self.weaponRoot):SetParent(self.weaponChildren, false)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.weaponRoot).localRotation = (Quaternion.Euler)(0, 0, 0)
  end
end

bs_102002.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  self:ResetActionState()
  ;
  (base.OnCasterDie)(self)
end

bs_102002.BeforeEndBattle = function(self)
  -- function num : 0_9
  self:ResetActionState()
end

bs_102002.OnSkillRemove = function(self)
  -- function num : 0_10 , upvalues : base
  self:ResetActionState()
  ;
  (base.OnSkillRemove)(self)
end

bs_102002.OnBreakSkill = function(self)
  -- function num : 0_11 , upvalues : base
  self:ResetActionState()
  ;
  (base.OnBreakSkill)(self)
end

return bs_102002

