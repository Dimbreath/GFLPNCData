local gs_25 = class("gs_25", LuaGridBase)
gs_25.config = {buff285 = 285}
gs_25.OnGridEnterRole = function(self, role)
  -- function num : 0_0 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buff285, 1, nil, true)
end

return gs_25

