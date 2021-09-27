local gs_3 = class("gs_3", LuaGridBase)
gs_3.config = {effectId = 10358, buffId = 1033, buffTier = 1, buffDuration = 15, 
heal_config = {baseheal_formula = 10052, heal_number = 0, correct_formula = 9990}
}
gs_3.ctor = function(self)
  -- function num : 0_0
end

gs_3.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_3.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.attackRange <= 1 then
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier, (self.config).buffDuration)
    if role.belongNum == 2 then
      LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
      self:OnArriveAction(role)
    else
      local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
      LuaSkillCtrl:StartTimer(nil, (self.config).buffDuration, arriveCallBack)
      local arriveCallBack1 = BindCallback(self, self.OnArriveAction1, role)
      LuaSkillCtrl:StartTimer(nil, (self.config).buffDuration - 1, arriveCallBack1)
    end
  else
    do
      self:GridLoseEffect()
    end
  end
end

gs_3.OnArriveAction1 = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
end

gs_3.OnArriveAction = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 48, 10, role, true)
  if targetlist.Count > 0 then
    local target = (targetlist[0]).targetRole
    local maxRange = 3
    local grid = nil
    for tempRange = 1, maxRange do
      for i = 0, targetlist.Count - 1 do
        target = (targetlist[i]).targetRole
        if target.belongNum ~= 0 then
          grid = LuaSkillCtrl:FindEmptyGridWithinRange(target, tempRange)
          if grid ~= nil then
            LuaSkillCtrl:CallEffect(role, 10263, self)
            LuaSkillCtrl:SetRolePos(grid, role)
            LuaSkillCtrl:CallEffect(role, 10264, self)
            break
          end
        end
      end
    end
    do
      do
        if grid ~= nil or grid == nil then
          error("cant find empty grid")
          self:GridLoseEffect()
          return 
        end
        -- DECOMPILER ERROR at PC68: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (role.recordTable).lastAttackRole = target
        self:GridLoseEffect()
      end
    end
  end
end

gs_3.OnGridExitRole = function(self, role)
  -- function num : 0_5
end

gs_3.OnGridRoleDead = function(self, role)
  -- function num : 0_6
end

return gs_3

