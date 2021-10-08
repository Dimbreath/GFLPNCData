local gs_1101 = class("gs_1101", LuaGridBase)
gs_1101.config = {duration = 30}
gs_1101.ctor = function(self)
  -- function num : 0_0
end

gs_1101.OnGridBattleStart = function(self, role)
  -- function num : 0_1
end

gs_1101.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local callBack = BindCallback(self, self.CallBack, role)
  self.timer = LuaSkillCtrl:StartTimer(nil, (self.config).duration, callBack, nil, -1)
end

gs_1101.CallBack = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  local hurt = role.maxHp * 50 // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, role, true, nil, true, true, eHurtType.RealDmg)
end

gs_1101.OnGridExitRole = function(self, role)
  -- function num : 0_4
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

gs_1101.OnGridRoleDead = function(self, role)
  -- function num : 0_5
end

return gs_1101

