-- params : ...
-- function num : 0 , upvalues : _ENV
local UIViewItemsGroup = class("UIViewItemsGroup", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UIViewItemsGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).baseItemWithCountItem):SetActive(false)
  self.itemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).baseItemWithCountItem)
end

UIViewItemsGroup.InitGroup = function(self, itemGroupData)
  -- function num : 0_1 , upvalues : _ENV
  self.typeId = itemGroupData.typeId
  self.itemList = itemGroupData.itemList
  ;
  ((self.ui).tex_Tile):SetIndex(self.typeId - 1)
  ;
  (self.itemPool):HideAll()
  for index,itemData in ipairs(self.itemList) do
    do
      local item = (self.itemPool):GetOne()
      if itemData.isAth then
        item:InitItemWithCount(itemData.itemCfg, itemData.num, function()
    -- function num : 0_1_0 , upvalues : _ENV, itemData
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_1_0_0 , upvalues : itemData
      if win ~= nil then
        win:InitAthDetail(itemData.itemCfg, itemData.athData)
      end
    end
)
  end
)
      else
        item:InitItemWithCount(itemData.itemCfg, itemData.num, nil)
      end
    end
  end
end

UIViewItemsGroup.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIViewItemsGroup

