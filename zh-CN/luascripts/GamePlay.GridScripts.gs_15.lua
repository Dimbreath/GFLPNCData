-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_15 = class("gs_15", LuaGridBase)
gs_15.config = {effectId = 10482, effectId1 = 10484, buffId = 1126, buffTier = 1, duration = 45}
gs_15.ctor = function(self)
  -- function num : 0_0
end

gs_15.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  self:AddTrigger()
end

gs_15.OnArriveAction = function(self, x, y)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallCreateEfcGrid(x, y, 15)
end

gs_15.AddTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if not (self.cskill):ContainTrigger(eSkillTriggerType.BeforeBattleEnd) then
    local bindFunc1 = BindCallback(self, self.BeforeEndBattle)
    LuaSkillCtrl:AddSkillTrigger(eSkillTriggerType.BeforeBattleEnd, self.cskill, "gs_15_1", 1, bindFunc1, false)
    local callBack = BindCallback(self, self.OnFindEmptyGridAndSetEfc)
    self.timer = LuaSkillCtrl:StartTimer(nil, (self.config).duration, callBack, nil, 20, (self.config).duration)
  end
end

gs_15.BeforeEndBattle = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local grids = LuaSkillCtrl:CallGetTotalEfcGrid()
  local count = grids.Count
  for i = count - 1, 0, -1 do
    if (grids[i]).dataId == 15 then
      (grids[i]):GridLoseEffect()
    end
  end
end

gs_15.OnFindEmptyGridAndSetEfc = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local grids = LuaSkillCtrl:CallGetTotalEfcGrid()
  local count = grids.Count
  if count >= 33 and self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  for i = 0, count - 1 do
    if (grids[i]).dataId == 15 then
      local grid = LuaSkillCtrl:FindEmptyGridWithoutEfcGridAroundGrid((grids[i]).x, (grids[i]).y)
      if grid ~= nil then
        self:OnArriveAction(grid.x, grid.y)
      end
    end
  end
end

gs_15.OnGridEnterRole = function(self, role)
  -- function num : 0_6 , upvalues : _ENV
  local buffTier = role:GetBuffTier(1126)
  if buffTier > 0 then
    return 
  end
  LuaSkillCtrl:CallBuff(self, role, 1126, 1, nil, true)
  local buffTier = role:GetBuffTier(1126)
end

gs_15.OnGridExitRole = function(self, role)
  -- function num : 0_7 , upvalues : _ENV
  local buffTier = role:GetBuffTier((self.config).buffId)
  if buffTier == 0 then
    return 
  end
  LuaSkillCtrl:DispelBuff(role, (self.config).buffId, 0)
end

gs_15.OnGridRoleDead = function(self, role)
  -- function num : 0_8
end

return gs_15

