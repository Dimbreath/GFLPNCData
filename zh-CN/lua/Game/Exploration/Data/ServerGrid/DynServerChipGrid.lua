local DynServerChipGrid = class("DynServerChipGrid")
local ChipBattleData = require("Game.PlayerData.Item.ChipBattleData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local GridChipLevel = 1
DynServerChipGrid.ctor = function(self)
  -- function num : 0_0
end

DynServerChipGrid.InitChipGrid = function(self, effector)
  -- function num : 0_1 , upvalues : _ENV, ChipBattleData, GridChipLevel
  self.__gridId = effector.gridId
  self.__times = effector.times
  self.__chipId = effector.p1
  self.__heroId = effector.p2
  local chipCfg = (ConfigData.chip)[self.__chipId]
  if chipCfg == nil then
    error("Can\'t find chip cfg, id = " .. tostring(self.__chipId))
    return 
  end
  self.chipBattleData = (ChipBattleData.New)(chipCfg, GridChipLevel, eBattleSkillLogicType.TempChip)
end

DynServerChipGrid.ExecuteGridChip = function(self, heroDic)
  -- function num : 0_2
  if heroDic == nil then
    return 
  end
  local dynHero = heroDic[self.__heroId]
  if dynHero == nil then
    return 
  end
  ;
  (self.chipBattleData):ExecuteChipBattle(dynHero)
end

DynServerChipGrid.RollbackGridChip = function(self, heroDic)
  -- function num : 0_3
  if heroDic == nil then
    return 
  end
  local dynHero = heroDic[self.__heroId]
  if dynHero == nil then
    return 
  end
  ;
  (self.chipBattleData):RollbackChipBattle(dynHero)
end

DynServerChipGrid.GetGridTimes = function(self)
  -- function num : 0_4
  return self.__times
end

DynServerChipGrid.GetGridHeroId = function(self)
  -- function num : 0_5
  return self.__heroId
end

DynServerChipGrid.GetGridCfg = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local gridCfg = (ConfigData.battle_grid)[self.__gridId]
  if gridCfg == nil then
    error("battle grid cfg is null,id:" .. tostring(self.__gridId))
    return nil
  end
  return gridCfg
end

DynServerChipGrid.GetGridIconSprite = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local gridCfg = self:GetGridCfg()
  if gridCfg == nil then
    return nil
  end
  return CRH:GetSprite(gridCfg.icon, CommonAtlasType.ExplorationIcon)
end

DynServerChipGrid.GetGridNameAndDesc = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local gridCfg = self:GetGridCfg()
  if gridCfg == nil then
    return nil, nil
  end
  return (LanguageUtil.GetLocaleText)(gridCfg.name), (LanguageUtil.GetLocaleText)(gridCfg.effect_info)
end

return DynServerChipGrid

