-- params : ...
-- function num : 0 , upvalues : _ENV
local DynEpBuffChip = class("DynEpBuffChip")
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynEpBuffChip.ctor = function(self, dataId, num)
  -- function num : 0_0 , upvalues : _ENV, ChipBattleData, ExplorationEnum
  self.dataId = dataId
  self.count = num
  local chipCfg = (ConfigData.chip)[self.dataId]
  if chipCfg == nil then
    error("Can\'t find chip cfg, id = " .. tostring(self.dataId))
    return 
  end
  self.chipCfg = chipCfg
  self.chipBattleData = (ChipBattleData.New)(self.chipCfg, self.count, (ExplorationEnum.eBattleSkillType).TempChip)
end

DynEpBuffChip.GetCount = function(self)
  -- function num : 0_1
  return self.count
end

DynEpBuffChip.SetCount = function(self, count)
  -- function num : 0_2
  self.count = count
  if self.chipBattleData ~= nil then
    (self.chipBattleData):UpdateChipBattleLevel(self:GetCount())
  end
end

DynEpBuffChip.ExecuteBuffChip = function(self, chipHolder)
  -- function num : 0_3
  (self.chipBattleData):ExecuteChipBattle(chipHolder)
end

DynEpBuffChip.RollbackBuffChip = function(self, chipHolder)
  -- function num : 0_4
  (self.chipBattleData):RollbackChipBattle(chipHolder)
end

DynEpBuffChip.IsValidDynPlayer = function(self)
  -- function num : 0_5
  return (self.chipBattleData):IsValidDynPlayer()
end

DynEpBuffChip.GetValidRoleList = function(self, dynBattleRoleList, belong)
  -- function num : 0_6
  return (self.chipBattleData):GetValidRoleList(dynBattleRoleList, belong)
end

return DynEpBuffChip

