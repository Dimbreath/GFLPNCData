local gs_4 = class("gs_4", LuaGridBase)
gs_4.config = {effectId = 10261, buffId = 1032, buffTier = 1}
gs_4.ctor = function(self)
  -- function num : 0_0
end

gs_4.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_4.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.roleDataId == 1008 then
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
    self:GridLoseEffect()
    return 
  end
  if role.attackRange > 1 then
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
    local targetlist = LuaSkillCtrl:CallTargetSelectWithCskill(self.cskill, 21, 10, role)
    if targetlist.Count < 1 then
      return 
    end
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (role.recordTable).lastAttackRole = (targetlist[0]).targetRole
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier)
    self:GridLoseEffect()
  else
    do
      self:GridLoseEffect()
    end
  end
end

gs_4.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_4.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_4

