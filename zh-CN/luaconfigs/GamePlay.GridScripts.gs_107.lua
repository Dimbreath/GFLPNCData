-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_107 = class("gs_107", LuaGridBase)
gs_107.config = {effectGridId = 10822}
gs_107.ctor = function(self)
  -- function num : 0_0
end

gs_107.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_107.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = (LuaSkillCtrl.cluaSkillCtrl):CallTargetSelect(self.cSkill, role, 6, 200)
  if targetlist.Count < 1 then
    self:GridLoseEffect()
    return 
  end
  for i = 1, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    local roleDef = role.def * 16 // 100
    targetRole:AddRoleProperty(eHeroAttr.def, roleDef, eHeroAttrType.Extra)
  end
  LuaSkillCtrl:CallEffect(role, (self.config).effectGridId, self)
  self:GridLoseEffect()
end

gs_107.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_107.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_107

