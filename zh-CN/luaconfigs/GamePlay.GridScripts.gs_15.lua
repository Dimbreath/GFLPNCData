-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_15 = class("gs_15", LuaGridBase)
local base = LuaGridBase
gs_15.config = {effectId = 10482, effectId1 = 10484, buffId = 1126, buffTier = 1, duration = 75}
gs_15.ctor = function(self)
  -- function num : 0_0
end

gs_15.OnGridBattleStart = function(self, role)
  -- function num : 0_1
  self:StartCreatGrid()
end

gs_15.OnArriveAction = function(self, x, y)
  -- function num : 0_2 , upvalues : _ENV
  return LuaSkillCtrl:CallCreateEfcGrid(x, y, 15)
end

gs_15.StartCreatGrid = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.growGrid = ((self.caster).recordTable).growGrid
  if self.growGrid == nil then
    self.growGrid = {}
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.caster).recordTable).growGrid = self.growGrid
    local callBack = BindCallback(self, self.OnFindEmptyGridAndSetEfc)
    self.timer = LuaSkillCtrl:StartTimer(nil, (self.config).duration, callBack, nil, 20, (self.config).duration)
  end
end

gs_15.OnFindEmptyGridAndSetEfc = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  local grids = LuaSkillCtrl:CallGetTotalEfcGrid()
  local count = grids.Count
  if count >= 35 and self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
    return 
  end
  self.stopFlag = true
  for i = 0, count - 1 do
    if (grids[i]).dataId == 15 then
      local curGrid = grids[i]
      if self.growGrid == nil or not (self.growGrid)[curGrid] then
        local emptyGrids = LuaSkillCtrl:FindGridsWithoutEfcGridAroundGrid((grids[i]).x, (grids[i]).y)
        if emptyGrids ~= nil and emptyGrids.Count > 0 then
          for j = 0, emptyGrids.Count - 1 do
            local role = LuaSkillCtrl:GetRoleWithPos((emptyGrids[j]).x, (emptyGrids[j]).y)
            -- DECOMPILER ERROR at PC93: Unhandled construct in 'MakeBoolean' P1

            if role ~= nil and role.belongNum == 0 and role.intensity == 0 and role.roleDataId ~= 1000 then
              if (role.roleDataId ~= 1004 or role ~= nil) and role.belongNum == 0 and role.intensity == 0 and (role.roleDataId == 1001 or role.roleDataId == 1005) then
                self.stopFlag = false
              else
                self:OnArriveAction((emptyGrids[j]).x, (emptyGrids[j]).y)
              end
            end
          end
        end
        do
          do
            -- DECOMPILER ERROR at PC110: Confused about usage of register: R9 in 'UnsetPending'

            if self.growGrid ~= nil and self.stopFlag then
              (self.growGrid)[grids[i]] = true
            end
            -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

gs_15.OnGridEnterRole = function(self, role)
  -- function num : 0_5 , upvalues : _ENV
  local buffTier = role:GetBuffTier((self.config).buffId)
  if buffTier > 0 then
    return 
  end
  LuaSkillCtrl:CallBuff(self, role, 1126, 1, nil, true)
  local buffTier = role:GetBuffTier((self.config).buffId)
end

gs_15.OnGridBattleEnd = function(self, role)
  -- function num : 0_6 , upvalues : base
  self.growGrid = nil
  ;
  (base.OnGridBattleEnd)(self, role)
end

return gs_15

