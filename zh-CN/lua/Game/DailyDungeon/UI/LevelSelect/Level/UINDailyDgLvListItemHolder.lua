local UINDailyDgLvListItemHolder = class("UINDailyDgLvListItemHolder", UIBaseNode)
local base = UIBaseNode
UINDailyDgLvListItemHolder.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINDailyDgLvListItemHolder.SetDailyDgLvListItem = function(self, lvItem)
  -- function num : 0_1
  self.lvItem = lvItem
end

UINDailyDgLvListItemHolder.InitDailyDgLvListItemHolder = function(self, lvIndex, bossId, isComplete, isLock, isCurrent, resloader, clickFunc)
  -- function num : 0_2
  self.isBoss = bossId ~= nil
  ;
  (self.lvItem):InitDailyDgLvListItem(lvIndex, isComplete, isLock, isCurrent, bossId, resloader, clickFunc)
  ;
  ((self.lvItem).transform):SetParent(self.transform)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINDailyDgLvListItemHolder.CheckNewReturnDailyDgLvListItem = function(self, isBoss)
  -- function num : 0_3
  local needCreatNewItem = self.lvItem == nil
  local needReturnItem = self.isBoss ~= isBoss
  local returnLvItem = nil
  if needReturnItem then
    returnLvItem = self:ReturnDailyDgLvListItem()
    needCreatNewItem = true
  end
  do return needCreatNewItem, returnLvItem end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINDailyDgLvListItemHolder.ReturnDailyDgLvListItem = function(self)
  -- function num : 0_4
  local lvItem = self.lvItem
  self.lvItem = nil
  return lvItem, self.isBoss
end

UINDailyDgLvListItemHolder.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINDailyDgLvListItemHolder

