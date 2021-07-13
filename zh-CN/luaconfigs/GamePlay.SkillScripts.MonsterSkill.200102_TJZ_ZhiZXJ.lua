-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200102 = class("bs_200102", LuaSkillBase)
local base = LuaSkillBase
bs_200102.config = {selectTargetId = 9, select_range = 20, select_target_buff_stun = 278, select_target_buff_super = 198, effectId = 10085, damageFormular = 1047, action_start = 1008, action_end = 1009, start_time = 6, pre_action_start_time = 15, phase_move_duration = 6, audioId1 = 51, audioId2 = 52, buffId_196 = 196, effectId1 = 10084, effectId2 = 10864, effectId3 = 10867, phaseMoveBuffId_69 = 69}
bs_200102.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_200102.PlaySkill = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.NotMove) then
    return 
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectTargetId, (self.config).select_range)
  if targetlist == nil or targetlist.Count <= 0 then
    return 
  end
  local targetRole = (targetlist[0]).targetRole
  if LuaSkillCtrl:IsRoleAdjacent(self.caster, targetRole) then
    self:CallCasterWait((self.config).start_time + 5)
    self:PlayActionAndDamage(targetRole)
    return 
  end
  local role, emptyGrid = self:CheckAndGetEmptyRole(targetlist)
  if role == nil or emptyGrid == nil then
    return 
  end
  if LuaSkillCtrl:IsRoleAdjacent(self.caster, role) then
    self:CallCasterWait((self.config).start_time + 5)
    self:PlayActionAndDamage(role)
  else
    LuaSkillCtrl:PreSetRolePos(emptyGrid, self.caster)
    local moveAttackTrigger = BindCallback(self, self.PhaseMoveHandle, role, emptyGrid)
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (role.recordTable).isPhaseSelect = true
    local waitSecond = (self.config).pre_action_start_time + 15 + (self.config).start_time
    LuaSkillCtrl:CallBreakAllSkill(role)
    LuaSkillCtrl:CallBuff(self, role, (self.config).select_target_buff_stun, 1, waitSecond + 1, true)
    self.effect0 = LuaSkillCtrl:CallEffect(role, (self.config).effectId3, self)
    LuaSkillCtrl:StartTimer(nil, 23, function()
    -- function num : 0_1_0 , upvalues : self
    if self.effect0 ~= nil then
      (self.effect0):Die()
      self.effect0 = nil
    end
  end
)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_196, 1, waitSecond + 1)
    self:CallCasterWait(waitSecond)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).action_start, 1, 15, moveAttackTrigger)
  end
end

bs_200102.PhaseMoveHandle = function(self, targetRole, emptyGrid)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CanclePreSetPos(self.caster)
  LuaSkillCtrl:CallPhaseMove(self, self.caster, emptyGrid.x, emptyGrid.y, (self.config).phase_move_duration, (self.config).phaseMoveBuffId_69)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.PlayActionAndDamage, targetRole))
end

bs_200102.CheckAndGetEmptyRole = function(self, roleList)
  -- function num : 0_3 , upvalues : _ENV
  local result, emptyGrid = nil, nil
  for i = 0, roleList.Count - 1 do
    local targetRole = (roleList[i]).targetRole
    if targetRole.intensity > 0 and targetRole ~= nil and ((targetRole.recordTable).isPhaseSelect == nil or not (targetRole.recordTable).isPhaseSelect) then
      emptyGrid = LuaSkillCtrl:FindEmptyGridAroundRole(targetRole)
      if emptyGrid ~= nil then
        return targetRole, emptyGrid
      end
    end
  end
  for i = 0, roleList.Count - 1 do
    local targetRole = (roleList[i]).targetRole
    if targetRole ~= nil then
      emptyGrid = LuaSkillCtrl:FindEmptyGridAroundRole(targetRole)
      if emptyGrid ~= nil then
        return targetRole, emptyGrid
      end
    end
  end
  return result, emptyGrid
end

bs_200102.PlayActionAndDamage = function(self, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (targetRole.recordTable).isPhaseSelect = false
  local lookAtCallBack = BindCallback(self, function(table, caster, targetRole)
    -- function num : 0_4_0
    caster:LookAtTarget(targetRole)
  end
, self.caster, targetRole)
  LuaSkillCtrl:StartTimer(self, 3, lookAtCallBack)
  local attackEndTrigger = BindCallback(self, self.DamageAndEffect, targetRole)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).action_end, 1, (self.config).start_time + 3, attackEndTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.effect0 ~= nil then
    (self.effect0):Die()
    self.effect0 = nil
  end
end

bs_200102.DamageAndEffect = function(self, targetRole)
  -- function num : 0_5 , upvalues : _ENV
  local damageNum1 = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormular, self.caster, targetRole, self)
  local damageNum2 = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormular, targetRole, self.caster, self)
  LuaSkillCtrl:RemoveLife(damageNum2, self, targetRole, true)
  LuaSkillCtrl:RemoveLife(damageNum1, self, self.caster, true)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc)
end

bs_200102.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  LuaSkillCtrl:CanclePreSetPos(self.caster)
  ;
  (base.OnCasterDie)(self)
  if self.effect0 ~= nil then
    (self.effect0):Die()
    self.effect0 = nil
  end
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

bs_200102.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  (base.LuaDispose)(self)
  self.effect = nil
end

return bs_200102

