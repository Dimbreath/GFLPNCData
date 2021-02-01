-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40019 = class("bs_40019", LuaSkillBase)
local base = LuaSkillBase
bs_40019.config = {selectTargetId = 9, effectId = 10085, damageFormular = 10016, action_start = 1008, action_end = 1009, pre_action_end_time = 6, pre_action_start_time = 15, audioId1 = 51, audioId2 = 52, effectId1 = 10084}
bs_40019.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_40019.PlaySkill = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.NotMove) then
    return 
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectTargetId, 20)
  if targetlist == nil or targetlist.Count <= 0 then
    return 
  end
  local role, emptyGrid = self:CheckAndGetEmptyRole(targetlist)
  if role == nil or emptyGrid == nil then
    return 
  end
  if LuaSkillCtrl:IsRoleAdjacent(self.caster, role) then
    self:CallCasterWait((self.config).pre_action_end_time + 5)
    self:PlayActionAndDamage(role)
  else
    LuaSkillCtrl:PreSetRolePos(emptyGrid, self.caster)
    local moveAttackTrigger = BindCallback(self, self.PhaseMoveHandle, role, emptyGrid)
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (role.recordTable).isPhaseSelect = true
    local waitSecond = (self.config).pre_action_start_time + 15 + (self.config).pre_action_end_time
    LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, waitSecond + 1)
    self:CallCasterWait(waitSecond)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).action_start, 1, 15, moveAttackTrigger)
  end
end

bs_40019.PhaseMoveHandle = function(self, targetRole, emptyGrid)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CanclePreSetPos(self.caster)
  LuaSkillCtrl:CallPhaseMove(self, self.caster, emptyGrid.x, emptyGrid.y, 6, 69)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
  LuaSkillCtrl:StartTimer(nil, 7, BindCallback(self, self.PlayActionAndDamage, targetRole))
end

bs_40019.CheckAndGetEmptyRole = function(self, roleList)
  -- function num : 0_3 , upvalues : _ENV
  local result, emptyGrid = nil, nil
  for i = 0, roleList.Count - 1 do
    local targetRole = (roleList[i]).targetRole
    if targetRole ~= nil and ((targetRole.recordTable).isPhaseSelect == nil or not (targetRole.recordTable).isPhaseSelect) then
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

bs_40019.PlayActionAndDamage = function(self, targetRole)
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
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).action_end, 1, (self.config).pre_action_end_time + 3, attackEndTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

bs_40019.DamageAndEffect = function(self, targetRole)
  -- function num : 0_5 , upvalues : _ENV
  local damageNum = targetRole.maxHp * (self.arglist)[1] // 1000
  local damageNum2 = (self.caster).maxHp * (self.arglist)[1] // 1000
  LuaSkillCtrl:RemoveLife(damageNum, self, targetRole, true)
  LuaSkillCtrl:RemoveLife(damageNum2, self, self.caster, true)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc)
end

bs_40019.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40019

