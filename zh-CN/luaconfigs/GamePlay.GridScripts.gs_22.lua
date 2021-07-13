-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_22 = class("gs_22", LuaGridBase)
gs_22.config = {duration = 30}
gs_22.ctor = function(self)
  -- function num : 0_0
end

gs_22.OnGridBattleStart = function(self, role)
  -- function num : 0_1
end

gs_22.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local callBack = BindCallback(self, self.CallBack, role)
  self.timer = LuaSkillCtrl:StartTimer(nil, (self.config).duration, callBack, nil, -1)
end

gs_22.CallBack = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  local hurt = role.maxHp * 100 // 1000
  LuaSkillCtrl:RemoveLife(hurt, self, role, true, true)
end

gs_22.OnGridExitRole = function(self, role)
  -- function num : 0_4
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

gs_22.OnGridRoleDead = function(self, role)
  -- function num : 0_5
end

return gs_22

