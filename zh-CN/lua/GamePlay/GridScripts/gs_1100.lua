local gs_1100 = class("gs_1100", LuaGridBase)
gs_1100.ctor = function(self)
  -- function num : 0_0
end

gs_1100.OnGridBattleStart = function(self, role)
  -- function num : 0_1
end

gs_1100.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if role ~= nil then
    local AddPower = LuaSkillCtrl:StartTimer(nil, 75, function()
    -- function num : 0_2_0 , upvalues : _ENV
    LuaSkillCtrl:AddPlayerTowerMp(1)
  end
, -1, 75)
  end
end

gs_1100.OnGridExitRole = function(self, role)
  -- function num : 0_3
  if self.AddPower ~= nil then
    (self.AddPower):Die()
    self.Addpower = nil
  end
end

gs_1100.OnGridRoleDead = function(self, role)
  -- function num : 0_4
  if self.AddPower ~= nil then
    (self.AddPower):Die()
    self.Addpower = nil
  end
end

return gs_1100

