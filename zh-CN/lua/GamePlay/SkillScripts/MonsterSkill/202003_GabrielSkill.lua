local bs_202003 = class("bs_202003", LuaSkillBase)
local base = LuaSkillBase
bs_202003.config = {effectId1 = 10501, effectId2 = 10502, effectId3 = 10503, effectId4 = 10263, effectId5 = 10264, effectId6 = 10867, antion11 = 1011, antion12 = 1012, antion2 = 1007, antion3 = 1009, buffId_196 = 196, buffId_278 = 278, buffId_70 = 70, buffId_1153 = 1153, buffId_270 = 270, select_id = 43, select_range = 10, start_time = 25, end_time = 20, buffId_root = 1154, audioId_loop = 339, audioId_up = 379, audioId_down = 380, audioId_end = 381, audioId_hit = 382, 
HealConfig = {baseheal_formula = 501}
}
bs_202003.ctor = function(self)
  -- function num : 0_0
end

bs_202003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_202003.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  if ((self.caster).recordTable)["20050_root3arg1"] ~= nil then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_root, 1)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_196, 1)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_70, 1)
  ;
  (LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range))
  local targetList = nil
  local role, grid = nil, nil
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      role = (targetList[i]).targetRole
      if LuaSkillCtrl:GetRoleGridsDistance(self.caster, role) ~= 0 then
        do
          grid = LuaSkillCtrl:FindEmptyGridWithinRange(role, 1)
          if grid ~= nil then
            LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_up)
            LuaSkillCtrl:PreSetRolePos(grid, self.caster)
            break
          end
          -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if role == nil then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_root, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_70, 0)
    return 
  end
  if grid == nil then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_root, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_70, 0)
    return 
  end
  local arg5 = (self.arglist)[5]
  if role.roleDataId == 102 then
    LuaSkillCtrl:CallBuff(self, role, 124, 1, arg5 + (self.config).start_time + 11)
  else
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_278, 1, arg5 + (self.config).start_time + 11)
  end
  self.effect0 = LuaSkillCtrl:CallEffect(role, (self.config).effectId6, self)
  self.dispelEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, 1)
  if role:GetBuffTier((self.config).buffId_278) < 1 and role.roleDataId ~= 102 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_root, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_70, 0)
    return 
  end
  self:CallCasterWait(999)
  self:AbandonSkillCdAutoReset(true)
  ;
  (self.caster):LookAtTarget(role)
  LuaSkillCtrl:StartTimer(self, 18, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId4, self)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_270, 1, 30)
  end
)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, role, arg5, grid)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).antion11, 1, (self.config).start_time, attackTrigger)
  self.targetrole = role
  self.loopAudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_loop)
end

bs_202003.OnAttackTrigger = function(self, target, arg5, grid)
  -- function num : 0_3 , upvalues : _ENV
  if LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.NotBeSelected) or LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Exiled) or LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.NotBeSelectedExceptSameBlong) then
    self:Onover(target)
  end
  LuaSkillCtrl:CanclePreSetPos(self.caster)
  LuaSkillCtrl:SetRolePos(grid, self.caster)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId5, self)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_down)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_270, 0)
  if self.dispelEffect ~= nil then
    (self.dispelEffect):Die()
    self.dispelEffect = nil
  end
  ;
  (self.caster):LookAtInstantly(target)
  if LuaSkillCtrl:IsRoleAdjacent(self.caster, target) then
    local gridtip = LuaSkillCtrl:GetGridWithRole(target)
    do
      LuaSkillCtrl:BreakCurrentAction(self.caster)
      ;
      (self.caster):LookAtTarget(target)
      LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion12)
      LuaSkillCtrl:StartTimer(nil, 11, function()
    -- function num : 0_3_0 , upvalues : _ENV, self, target, gridtip, arg5
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion2)
    self.loophit = LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
    local hurt = BindCallback(self, self.Onhurt, target, gridtip)
    LuaSkillCtrl:StartShowSkillDurationTime(self, arg5 + (self.config).end_time + 2)
    self.tiemr = LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], hurt, self, -1, 0)
    local over = BindCallback(self, self.Onover, target)
    self.endTimer = LuaSkillCtrl:StartTimer(self, arg5, over, self)
  end
, self)
      if self.loophit ~= nil then
        (self.loophit):Die()
        self.loophit = nil
      end
      if self.tiemr ~= nil then
        (self.tiemr):Stop()
        self.tiemr = nil
      end
      if self.endTimer ~= nil then
        (self.endTimer):Stop()
        self.endTimer = nil
      end
    end
  else
    do
      if self.effect0 ~= nil then
        (self.effect0):Die()
        self.effect0 = nil
      end
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_root, 0)
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 0)
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_70, 0)
      LuaSkillCtrl:DispelBuff(target, (self.config).buffId_278, 0)
      self:CancleCasterWait()
      LuaSkillCtrl:StopShowSkillDurationTime(self)
      self:CallNextBossSkill()
    end
  end
end

bs_202003.Onover = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).antion3)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_end)
  if self.loophit ~= nil then
    (self.loophit):Die()
    self.loophit = nil
  end
  if self.tiemr ~= nil then
    (self.tiemr):Stop()
    self.tiemr = nil
  end
  if self.endTimer ~= nil then
    (self.endTimer):Stop()
    self.endTimer = nil
  end
  if self.effect0 ~= nil then
    (self.effect0):Die()
    self.effect0 = nil
  end
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopAudio)
    self.loopAudio = nil
  end
  LuaSkillCtrl:StartTimer(nil, (self.config).end_time, function()
    -- function num : 0_4_0 , upvalues : self, _ENV
    self:CancleCasterWait()
    self:CallNextBossSkill()
    LuaSkillCtrl:StopShowSkillDurationTime(self)
  end
)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 0)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_70, 0)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_root, 0)
  if self.targetrole ~= nil then
    self.targetrole = nil
  end
  if target.hp > 0 then
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId_278, 0)
    LuaSkillCtrl:StartTimer(nil, (self.config).end_time, function()
    -- function num : 0_4_1 , upvalues : _ENV, self
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1153, 1, (self.arglist)[6], true)
  end
)
  end
end

bs_202003.Onhurt = function(self, target, grid)
  -- function num : 0_5 , upvalues : _ENV
  if self.tiemr ~= nil and (self.tiemr):IsOver() then
    self.tiemr = nil
  end
  local hurt = target.maxHp * (self.arglist)[3] // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, target, true, nil, true, false, eHurtType.RealDmg)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_hit)
  local heal = hurt * (self.arglist)[4] // 1000
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {heal}, true)
  skillResult:EndResult()
  if target.hp <= 0 then
    self:Onover(target)
  end
  local grid2 = LuaSkillCtrl:GetGridWithRole(target)
  if grid ~= grid2 or LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.NotBeSelected) or LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.Exiled) or LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.NotBeSelectedExceptSameBlong) then
    self:Onover(target)
  end
end

bs_202003.OnBreakSkill = function(self, role)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnBreakSkill)(self, role)
  if role == self then
    if self.targetrole ~= nil then
      LuaSkillCtrl:DispelBuff(self.targetrole, (self.config).buffId_278, 0)
    end
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_root, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_196, 0)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_70, 0)
  end
  if self.effect0 ~= nil then
    (self.effect0):Die()
    self.effect0 = nil
  end
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopAudio)
    self.loopAudio = nil
  end
end

bs_202003.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  LuaSkillCtrl:CanclePreSetPos(self.caster)
  ;
  (base.OnCasterDie)(self)
  if self.targetrole ~= nil then
    LuaSkillCtrl:DispelBuff(self.targetrole, (self.config).buffId_278, 0)
  end
  if self.loophit ~= nil then
    (self.loophit):Die()
    self.loophit = nil
  end
  if self.effect0 ~= nil then
    (self.effect0):Die()
    self.effect0 = nil
  end
  if self.loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopAudio)
    self.loopAudio = nil
  end
end

bs_202003.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.loophit = nil
  self.targetrole = nil
  self.dispelEffect = nil
  self.loopAudio = nil
end

return bs_202003

