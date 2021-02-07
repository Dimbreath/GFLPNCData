-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202003 = class("bs_202003", LuaSkillBase)
local base = LuaSkillBase
bs_202003.config = {effectId1 = 10501, effectId2 = 10502, effectId3 = 10503, antion1 = 1008, antion2 = 1007, antion3 = 1009, buffId1 = 196, buffId2 = 124, buffId3 = 70}
bs_202003.ctor = function(self)
  -- function num : 0_0
end

bs_202003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_202003_10", 1, self.OnAfterHurt)
end

bs_202003.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId3, 1)
  local targetList = (LuaSkillCtrl:CallTargetSelect(self, 43, 10))
  -- DECOMPILER ERROR at PC22: Overwrote pending register: R3 in 'AssignReg'

  local role = .end
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      role = (targetList[i]).targetRole
      if LuaSkillCtrl:GetRoleGridsDistance(self.caster, role) ~= 1 then
        do
          local grid = LuaSkillCtrl:FindEmptyGridWithinRange(role, 1)
          if grid ~= nil then
            LuaSkillCtrl:CallEffect(self.caster, 10263, self)
            LuaSkillCtrl:SetRolePos(grid, self.caster)
            LuaSkillCtrl:CallEffect(self.caster, 10264, self)
            break
          end
          -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if LuaSkillCtrl:IsRoleAdjacent(self.caster, role) then
    local arg5 = (self.arglist)[5]
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId2, 1, arg5)
    if role:GetBuffTier((self.config).buffId2) < 1 or role:GetBuffTier((self.config).buffId1) >= 1 then
      for i = 1, 10 do
        LuaSkillCtrl:CallBuff(self, role, (self.config).buffId2, 1, arg5)
      end
    end
    do
      if role:GetBuffTier((self.config).buffId2) < 1 then
        self:CallCasterWait(999)
        ;
        (self.caster):LookAtTarget(role)
        do
          local attackTrigger = BindCallback(self, self.OnAttackTrigger, role, arg5)
          LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion1, 1, 21, attackTrigger)
          self.targetrole = role
          LuaSkillCtrl:CallEffect(self.caster, 10501, self)
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId3, 0)
        end
      end
    end
  end
end

bs_202003.OnAttackTrigger = function(self, target, arg5)
  -- function num : 0_3 , upvalues : _ENV
  (self.caster):LookAtTarget(target)
  local gridtip = LuaSkillCtrl:GetGridWithRole(target)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion2)
  self.loophit = LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
  local hurt = BindCallback(self, self.Onhurt, target, gridtip)
  self.tiemr = LuaSkillCtrl:StartTimer(self, (self.arglist)[2], hurt, self, -1, 0)
  local over = BindCallback(self, self.Onover, target)
  LuaSkillCtrl:StartTimer(self, arg5, over, self)
end

bs_202003.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_4 , upvalues : _ENV
  if sender == self.caster and skill.dataId == 202003 then
    local heal = hurt * (self.arglist)[4] // 1000
    LuaSkillCtrl:CallHeal(heal, self, self.caster, true)
  end
end

bs_202003.Onover = function(self, target)
  -- function num : 0_5 , upvalues : _ENV
  if target.hp >= 0 then
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion3)
    if self.loophit ~= nil then
      (self.loophit):Die()
      self.loophit = nil
    end
    if self.tiemr ~= nil then
      (self.tiemr):Stop()
      self.tiemr = nil
    end
    LuaSkillCtrl:StartTimer(self, 20, function()
    -- function num : 0_5_0 , upvalues : self
    self:CancleCasterWait()
  end
)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId3, 0)
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId2, 0)
  end
end

bs_202003.Onhurt = function(self, target, grid)
  -- function num : 0_6 , upvalues : _ENV
  local hurt = target.maxHp * (self.arglist)[3] // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, target, true, true)
  if target.hp <= 0 then
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion3)
    if self.loophit ~= nil then
      (self.loophit):Die()
      self.loophit = nil
    end
    if self.tiemr ~= nil then
      (self.tiemr):Stop()
      self.tiemr = nil
    end
    LuaSkillCtrl:StartTimer(self, 20, function()
    -- function num : 0_6_0 , upvalues : self
    self:CancleCasterWait()
  end
)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId3, 0)
  end
  local grid2 = LuaSkillCtrl:GetGridWithRole(target)
  if grid ~= grid2 or LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.NotBeSelected) or LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Exiled) then
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion3)
    if self.loophit ~= nil then
      (self.loophit):Die()
      self.loophit = nil
    end
    if self.tiemr ~= nil then
      (self.tiemr):Stop()
      self.tiemr = nil
    end
    LuaSkillCtrl:StartTimer(self, 20, function()
    -- function num : 0_6_1 , upvalues : self
    self:CancleCasterWait()
  end
)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId3, 0)
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId2, 0)
  end
end

bs_202003.OnBreakSkill = function(self, role)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnBreakSkill)(self, role)
  if role == self then
    LuaSkillCtrl:DispelBuff(self.targetrole, (self.config).buffId2, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId3, 0)
  end
end

bs_202003.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  LuaSkillCtrl:DispelBuff(self.targetrole, (self.config).buffId2, 0)
  if self.loophit ~= nil then
    (self.loophit):Die()
    self.loophit = nil
  end
end

return bs_202003

