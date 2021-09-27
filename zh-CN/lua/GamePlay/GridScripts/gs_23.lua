local gs_23 = class("gs_23", LuaGridBase)
gs_23.config = {duration = 30}
gs_23.ctor = function(self)
  -- function num : 0_0
end

gs_23.OnGridBattleStart = function(self, role)
  -- function num : 0_1
end

gs_23.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local callBack = BindCallback(self, self.CallBack, role)
  self.timer = LuaSkillCtrl:StartTimer(nil, (self.config).duration, callBack, nil, -1)
end

gs_23.CallBack = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  local hurt = role.maxHp * 150 // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, role, true, nil, true, true, eHurtType.RealDmg)
end

gs_23.OnGridExitRole = function(self, role)
  -- function num : 0_4
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

gs_23.OnGridRoleDead = function(self, role)
  -- function num : 0_5
end

return gs_23

