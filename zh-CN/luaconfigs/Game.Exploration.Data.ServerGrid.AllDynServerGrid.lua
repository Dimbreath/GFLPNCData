-- params : ...
-- function num : 0 , upvalues : _ENV
local AllDynServerGrid = class("AllDynServerGrid")
local DynServerChipGrid = require("Game.Exploration.Data.ServerGrid.DynServerChipGrid")
local GridLogicEnum = {Chip = 1}
AllDynServerGrid.ctor = function(self)
  -- function num : 0_0 , upvalues : GridLogicEnum
  self.__gridLogicGroup = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.__gridLogicGroup)[GridLogicEnum.Chip] = self.UpdateAllServerChipGrid
  self.__chipGridList = {}
end

AllDynServerGrid.UpdateAllServerGrid = function(self, epBattleGrid, dynPlayer)
  -- function num : 0_1 , upvalues : _ENV
  if epBattleGrid == nil then
    return 
  end
  for cat,grid in pairs(epBattleGrid.grids) do
    local logicFunc = (self.__gridLogicGroup)[cat]
    if logicFunc ~= nil then
      logicFunc(self, grid, dynPlayer)
    end
  end
end

AllDynServerGrid.UpdateAllServerChipGrid = function(self, grid, dynPlayer)
  -- function num : 0_2 , upvalues : _ENV, DynServerChipGrid
  do
    while #self.__chipGridList > 0 do
      local chipGrid = (table.remove)(self.__chipGridList)
      chipGrid:RollbackGridChip(dynPlayer.heroDic)
    end
    for k,effector in pairs(grid.eff) do
      local chipGrid = (DynServerChipGrid.New)()
      chipGrid:InitChipGrid(effector)
      chipGrid:ExecuteGridChip(dynPlayer.heroDic)
      ;
      (table.insert)(self.__chipGridList, chipGrid)
    end
  end
end

AllDynServerGrid.GetHeroServerGrid = function(self, heroId)
  -- function num : 0_3 , upvalues : _ENV
  local gridlist = nil
  for _,chipGrid in pairs(self.__chipGridList) do
    local gridheroid = chipGrid:GetGridHeroId()
    if heroId == gridheroid then
      if not gridlist then
        gridlist = {}
      end
      ;
      (table.insert)(gridlist, chipGrid)
    end
  end
  return gridlist
end

return AllDynServerGrid

