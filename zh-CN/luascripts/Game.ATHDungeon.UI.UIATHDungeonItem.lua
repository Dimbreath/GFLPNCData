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
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = (AtlasUtil.GetSpriteFromAtlas)("CommonDungeon", dungeonCfg.item_icon, resLoader)
  local path = PathConsts:GetMaterialDungeonBGIconPath(dungeonCfg.item_icon)
  if not (string.IsNullOrEmpty)(path) then
    self.iconTexture = resLoader:LoadABAsset(path)
  end
  path = PathConsts:GetMaterailDungeonPicPath(dungeonCfg.dungeon_img)
  if not (string.IsNullOrEmpty)(path) then
    self.bannerTexture = resLoader:LoadABAsset(path)
  end
end

return UIATHDungeonItem

