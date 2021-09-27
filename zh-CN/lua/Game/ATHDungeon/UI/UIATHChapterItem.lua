local UINDungeonStageItemBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonStageItemBase")
local UIATHChapterItem = class("UIATHChapterItem", UINDungeonStageItemBase)
local base = UINDungeonStageItemBase
UIATHChapterItem.OnDelete = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnDelete)(self)
  self.clickEvent = nil
end

UIATHChapterItem.SetAthStageClickEvent = function(self, func)
  -- function num : 0_1
  self.clickEvent = func
end

UIATHChapterItem.__onClick = function(self)
  -- function num : 0_2 , upvalues : base
  (base.__onClick)(self)
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

return UIATHChapterItem

