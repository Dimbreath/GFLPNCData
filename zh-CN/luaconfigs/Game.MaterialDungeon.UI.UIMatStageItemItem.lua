-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonStageItemBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonStageItemBase")
local UIMatStageItemItem = class("UIMatStageItemItem", UINDungeonStageItemBase)
local base = UINDungeonStageItemBase
UIMatStageItemItem.OnDelete = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnDelete)(self)
end

return UIMatStageItemItem

