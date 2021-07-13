-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINMonsterLevelPreviewItem = class("UINMonsterLevelPreviewItem", base)
UINMonsterLevelPreviewItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnInit)(self)
end

UINMonsterLevelPreviewItem.InitMonsterLevelPreviewRowItem = function(self, level, isCurLevel, logicList)
  -- function num : 0_1 , upvalues : _ENV
  (self.attrPool):HideAll()
  for k,v in ipairs(logicList) do
    local attrItem = (self.attrPool):GetOne()
    attrItem:InitAttrItem(v, isCurLevel)
  end
end

UINMonsterLevelPreviewItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINMonsterLevelPreviewItem

