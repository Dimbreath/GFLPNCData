-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_101 = class("gs_101", LuaGridBase)
gs_101.config = {effectGridId = 10825}
gs_101.ctor = function(self)
  -- function num : 0_0
end

gs_101.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_101.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = (LuaSkillCtrl.cluaSkillCtrl):CallTargetSelect(self.cSkill, role, 6, 200)
  if targetlist.Count < 1 then
    self:GridLoseEffect()
    return 
  end
  for i = 1, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    local roleIntensity = role.skill_intensity * 16 // 100
    targetRole:AddRoleProperty(eHeroAttr.skill_intensity, roleIntensity, eHeroAttrType.Extra)
  end
  LuaSkillCtrl:CallEffect(role, (self.config).effectGridId, self)
  self:GridLoseEffect()
end

gs_101.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_101.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_101

