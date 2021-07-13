-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_1 = class("gs_1", LuaGridBase)
gs_1.config = {effectId = 10173, effectId2 = 10174}
gs_1.ctor = function(self)
  -- function num : 0_0
end

gs_1.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  if role == nil then
    self:GridLoseEffect()
  end
end

gs_1.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  local skills = role:GetBattleSkillList()
  if skills ~= nil then
    local skillCount = skills.Count
    if skillCount > 0 then
      for j = 0, skillCount - 1 do
        local curTotalCd = (skills[j]).totalCDTime
        LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
      end
    end
  end
  do
    self:GridLoseEffect()
  end
end

gs_1.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_1.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_1

