-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormWarehouse = class("UIDormWarehouse", UIBaseWindow)
local base = UIBaseWindow
local UIDormSortList = require("Game.Dorm.UI.SortList.UIDormSortList")
UIDormWarehouse.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIDormSortList
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickRenturn)
  self.sortListNode = (UIDormSortList.New)()
  ;
  (self.sortListNode):Init((self.ui).dormSortList)
end

UIDormWarehouse.InitDormWareHouse = function(self, itemType, origineDataList, funcSift, funcSort, itemClickEvent, itemInstallEvent)
  -- function num : 0_1
  self.itemType = itemType
  ;
  (self.sortListNode):SetItemType(itemType, false)
  ;
  (self.sortListNode):SetItemClickAction(itemClickEvent)
  ;
  (self.sortListNode):SetItemInstallEvent(itemInstallEvent)
  ;
  (self.sortListNode):RefreshDormItemList(origineDataList, funcSift, funcSort)
end

UIDormWarehouse.OnClickRenturn = function(self)
  -- function num : 0_2
  self:Delete()
end

UIDormWarehouse.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  if self.sortListNode ~= nil then
    (self.sortListNode):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIDormWarehouse

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormWarehouse = class("UIDormWarehouse", UIBaseWindow)
local base = UIBaseWindow
local UIDormSortList = require("Game.Dorm.UI.SortList.UIDormSortList")
UIDormWarehouse.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UIDormSortList
    (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickRenturn)
    self.sortListNode = (UIDormSortList.New)();
    (self.sortListNode):Init((self.ui).dormSortList)
end

UIDormWarehouse.InitDormWareHouse = function(self, itemType, origineDataList,
                                             funcSift, funcSort, itemClickEvent,
                                             itemInstallEvent)
    -- function num : 0_1
    self.itemType = itemType;
    (self.sortListNode):SetItemType(itemType, false);
    (self.sortListNode):SetItemClickAction(itemClickEvent);
    (self.sortListNode):SetItemInstallEvent(itemInstallEvent);
    (self.sortListNode):RefreshDormItemList(origineDataList, funcSift, funcSort)
end

UIDormWarehouse.OnClickRenturn = function(self)
    -- function num : 0_2
    self:Delete()
end

UIDormWarehouse.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    if self.sortListNode ~= nil then (self.sortListNode):Delete() end
    (base.OnDelete)(self)
end

return UIDormWarehouse

