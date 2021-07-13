-- params : ...
-- function num : 0 , upvalues : _ENV
local DynEffectGrid = class("DynEffectGrid")
DynEffectGrid.ctor = function(self, coord, id)
  -- function num : 0_0 , upvalues : _ENV
  self.coord = coord
  self.x = (BattleUtil.Pos2XYCoord)(coord)
  self.id = id
  local gridCfg = (ConfigData.battle_grid)[id]
  if gridCfg == nil then
    error("battle grid cfg is null,id:" .. tostring(id))
    return 
  end
  self.gridCfg = gridCfg
end

DynEffectGrid.GetGridName = function(self)
  -- function num : 0_1 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.gridCfg).name)
end

DynEffectGrid.GetGridInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return (LanguageUtil.GetLocaleText)((self.gridCfg).info)
end

DynEffectGrid.GetGridType = function(self)
  -- function num : 0_3
  return (self.gridCfg).type
end

DynEffectGrid.GetGridSrcName = function(self)
  -- function num : 0_4
  return (self.gridCfg).src_name
end

DynEffectGrid.GetGridSkillScript = function(self)
  -- function num : 0_5
  return (self.gridCfg).grid_skill
end

DynEffectGrid.GetGridIconSprite = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return CRH:GetSprite((self.gridCfg).icon, CommonAtlasType.ExplorationIcon)
end

return DynEffectGrid

