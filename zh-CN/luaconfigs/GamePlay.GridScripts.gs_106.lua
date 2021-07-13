-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_106 = class("gs_106", LuaGridBase)
gs_106.config = {effectGridId = 10830, effectHitId = 10846}
gs_106.ctor = function(self)
  -- function num : 0_0
end

gs_106.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_106.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = (LuaSkillCtrl.cluaSkillCtrl):CallTargetSelect(self.cSkill, role, 7, 10)
  if targetlist.Count < 1 then
    self:GridLoseEffect()
    return 
  end
  if targetlist.Count ~= 0 then
    local targetRole = (targetlist[0]).targetRole
    if targetRole ~= nil then
      local hp = role.hp * 500 // 1000
      role:SubHp(hp)
      local dmg = hp
      if role.career == 1 then
        dmg = dmg * 130 // 100
      end
      LuaSkillCtrl:RemoveLife(dmg, self, targetRole, true, true)
      LuaSkillCtrl:CallEffect(targetRole, (self.config).effectHitId, self)
    end
    do
      do
        LuaSkillCtrl:CallEffect(role, (self.config).effectGridId, self)
        self:GridLoseEffect()
      end
    end
  end
end

gs_106.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_106.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_106

