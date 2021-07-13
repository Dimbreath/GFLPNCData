-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_105 = class("gs_105", LuaGridBase)
gs_105.config = {effectGridId = 10829}
gs_105.ctor = function(self)
  -- function num : 0_0
end

gs_105.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_105.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = (LuaSkillCtrl.cluaSkillCtrl):CallTargetSelect(self.cSkill, role, 6, 200)
  if targetlist.Count < 1 then
    self:GridLoseEffect()
    return 
  end
  for i = 1, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    local rolePow = role.pow * 16 // 100
    targetRole:AddRoleProperty(eHeroAttr.pow, rolePow, eHeroAttrType.Extra)
  end
  LuaSkillCtrl:CallEffect(role, (self.config).effectGridId, self)
  self:GridLoseEffect()
end

gs_105.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_105.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_105

