local gs_1 = class("gs_1", LuaGridBase)
gs_1.config = {effectId = 10173, effectId2 = 10174, buffId = 1209, buffTier = 1}
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
  self.curCd = role:GetMainSkillCurCd()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (role.recordTable).gs_1_CDGrid = self.curCd
  LuaSkillCtrl:CallReFillMainSkillCdForRole(role)
  LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.config).buffTier, 15, true)
  LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
  self:GridLoseEffect()
end

gs_1.OnGridExitRole = function(self, role)
  -- function num : 0_3
end

gs_1.OnGridRoleDead = function(self, role)
  -- function num : 0_4
end

return gs_1

