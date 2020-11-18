-- params : ...
-- function num : 0 , upvalues : _ENV
local DynEpBuffChip = class("DynEpBuffChip")
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
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
    (self.chipBattleData):UpdateSkillLevel(self:GetCount())
  end
end

DynEpBuffChip.ExecuteChipHero = function(self, role)
  -- function num : 0_3 , upvalues : ChipEnum, _ENV
  if role == nil then
    return (ChipEnum.ePropActionResult).Skip
  end
  if role:ContainTempChip(self) then
    error("该全局芯片已经生效:" .. tostring(self.dataId))
    return (ChipEnum.ePropActionResult).Fail
  else
    ;
    (self.chipBattleData):ExecutePropHero(role, self:GetCount())
    role:AddTempChip(self)
  end
  return (ChipEnum.ePropActionResult).Success
end

DynEpBuffChip.RollbackChipHero = function(self, role)
  -- function num : 0_4 , upvalues : ChipEnum
  if role == nil or not role:ContainTempChip(self) then
    return (ChipEnum.ePropActionResult).Skip
  end
  ;
  (self.chipBattleData):RollbackHero(role, self:GetCount())
  role:RemoveTempChip(self)
  return (ChipEnum.ePropActionResult).Success
end

DynEpBuffChip.GetValidRoleList = function(self, dynBattleRoleList, belong)
  -- function num : 0_5
  return (self.chipBattleData):GetValidRoleList(dynBattleRoleList, belong)
end

return DynEpBuffChip

