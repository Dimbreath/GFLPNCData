-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonItemBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonItemBase")
local UIATHDungeonItem = class("UIATHDungeonItem", UINDungeonItemBase)
local base = UINDungeonItemBase
UIATHDungeonItem.OnDelete = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnDelete)(self)
end

UIATHDungeonItem.InitDungeonItem = function(self, dungeonData, resLoader, clickEvent)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitDungeonItem)(self, dungeonData, resLoader, clickEvent)
  local dungeonCfg = dungeonData:GetDungeonCfg()
  self.index = (tonumber(dungeonCfg.item_icon) or 1) - 1
  ;
  ((self.ui).img_SelectBG):SetIndex(self.index)
  ;
  ((self.ui).tex_Level):SetIndex(self.index)
  local path = PathConsts:GetMaterailDungeonPicPath(dungeonCfg.dungeon_img)
  if not (string.IsNullOrEmpty)(path) then
    self.bannerTexture = resLoader:LoadABAsset(path)
  end
end

return UIATHDungeonItem

