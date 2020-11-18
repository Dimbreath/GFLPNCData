-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40019 = class("bs_40019", LuaSkillBase)
local base = LuaSkillBase
bs_40019.config = {effectId = 10085, buffId = 1010, buffTier = 1, buffDuration = 45, attackdelay = 3, damageFormular = 10006, startAnimID = 1008, endAnimID = 1009, audioId1 = 51, audioId2 = 52}
bs_40019.ctor = function(self)
  -- function num : 0_0
end

bs_40019.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40019_1", 1, self.OnAfterBattleStart)
end

bs_40019.OnAfterBattleStart = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.caster).recordTable)["40019_restart"] = 5
  self:CallBack()
end

bs_40019.CallBack = function(self)
  -- function num : 0_3
  self:FindPosAndMove()
end

bs_40019.FindPosAndMove = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 19, 10)
  if targetlist.Count <= 0 then
    return 
  end
  local role = (targetlist[0]).targetRole
  if ((self.caster).recordTable).lastAttackRole == role and LuaSkillCtrl:IsRoleAdjacent(role, self.caster) then
    self:CallCasterWait(35)
    local standAttackTrigger = BindCallback(self, self.OnStandAttackTrigger, role, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, 1, 15, standAttackTrigger)
  else
    do
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.caster).recordTable).lastAttackRole = role
      local grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
      if grid ~= nil then
        if ((self.caster).recordTable)["40019_restart"] == 5 then
          local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, role, data, grid)
          self:CallCasterWait(16)
          LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, 1, 15, moveAttackTrigger)
        else
          do
            do
              local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, role, data, grid)
              moveAttackTrigger()
              -- DECOMPILER ERROR at PC100: Confused about usage of register: R4 in 'UnsetPending'

              if ((self.caster).recordTable)["40019_restart"] > 0 then
                ((self.caster).recordTable)["40019_restart"] = ((self.caster).recordTable)["40019_restart"] - 1
                self:FindPosAndMove()
              else
                targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
                if targetlist.Count > 0 then
                  local role = (targetlist[0]).targetRole
                  self:DamageAndEffect(role)
                end
              end
            end
          end
        end
      end
    end
  end
end

bs_40019.DamageAndEffect = function(self, target)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  local damageTarget = ((self.caster).recordTable).lastAttackRole
  if damageTarget == nil then
    return 
  end
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, damageTarget, 1) then
    (self.caster):LookAtTarget(damageTarget)
    local attackEndTrigger = BindCallback(self, self.OnAttackEndTrigger, damageTarget, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).endAnimID, 1, 4, attackEndTrigger)
    ;
    ((self.caster).auSource):PlayAudioById((self.config).audioId2)
  else
    do
      self:BreakSkill()
    end
  end
end

bs_40019.OnFinish = function(self, grid, role, x, y)
  -- function num : 0_6 , upvalues : _ENV
  if grid.x == x and grid.y == y then
    local target = ((self.caster).recordTable).lastAttackRole
    self:CallCasterWait(19)
    self:DamageAndEffect(target)
  else
    do
      if (self.caster):GetBuffTier((self.config).buffId) > 0 then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
      end
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

      if ((self.caster).recordTable)["40019_restart"] > 0 then
        ((self.caster).recordTable)["40019_restart"] = ((self.caster).recordTable)["40019_restart"] - 1
        self:FindPosAndMove()
      else
        local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
        -- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

        if targetlist.Count > 0 then
          ((self.caster).recordTable).lastAttackRole = (targetlist[0]).targetRole
          self:DamageAndEffect((targetlist[0]).targetRole)
        end
      end
    end
  end
end

bs_40019.OnMoveAttackTrigger = function(self, target, data, grid)
  -- function num : 0_7 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, (self.config).buffDuration)
  LuaSkillCtrl:MoveRoleToTarget(self, grid, self.caster, false, self.OnFinish)
end

bs_40019.OnStandAttackTrigger = function(self, target, data)
  -- function num : 0_8
  self:DamageAndEffect(target)
end

bs_40019.OnAttackEndTrigger = function(self, target, data)
  -- function num : 0_9 , upvalues : _ENV
  local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormular, self.caster, target, self)
  LuaSkillCtrl:RemoveLife(damageNum, self, target, true)
  LuaSkillCtrl:RemoveLife(damageNum, self, self.caster, true)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc)
end

bs_40019.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if (self.caster):GetBuffTier((self.config).buffId) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  end
end

return bs_40019

