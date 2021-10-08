local gs_1104 = class("gs_1104", LuaGridBase)
local csRoleState = CS.eBattleRoleState
gs_1104.config = {effectId = 10477, effectId1 = 10478, buffId_1000 = 1000}
gs_1104.ctor = function(self)
  -- function num : 0_0
end

gs_1104.OnGridBattleStart = function(self, role)
  -- function num : 0_1
end

gs_1104.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local grid = LuaSkillCtrl:GetNearestEmptyEfcGrid(role, 1105)
  if grid ~= nil then
    LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
    LuaSkillCtrl:CallBreakAllSkill(role)
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_1000, 1, 30, true)
    role:AddSkillWaitBuff(10)
    ;
    (LuaSkillCtrl.cluaSkillCtrl):SetPosForce(grid, role)
    LuaSkillCtrl:CallEffect(role, (self.config).effectId1, self)
  end
end

gs_1104.TryResetMoveState = function(self, role)
  -- function num : 0_3 , upvalues : csRoleState
  if role == nil or role.hp <= 0 then
    return 
  end
  if role.eState == csRoleState.Moving then
    role:SetRoleState(csRoleState.Normal)
  end
end

gs_1104.OnGridExitRole = function(self, role)
  -- function num : 0_4
end

gs_1104.OnGridRoleDead = function(self, role)
  -- function num : 0_5
end

return gs_1104

