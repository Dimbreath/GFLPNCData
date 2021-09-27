local UINDungeonStageItemBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonStageItemBase")
local UIHeroChapterItem = class("UIHeroChapterItem", UINDungeonStageItemBase)
local base = UINDungeonStageItemBase
UIHeroChapterItem.OnDelete = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroChapterItem

