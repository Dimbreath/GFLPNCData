-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonItemList = class("UIDungeonItemList", UIBaseNode)
local base = UIBaseNode
UIDungeonItemList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIDungeonItemList.InjectItemInitEvent = function(self, initItemEvent)
  -- function num : 0_1
  self.initItemEvent = initItemEvent
end

UIDungeonItemList.InjectItemUpdateEvent = function(self, updateItemEvent)
  -- function num : 0_2
  self.updateItemEvent = updateItemEvent
end

UIDungeonItemList.LoadItemList = function(self, itemIndex)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).loopList).onChangeItem = BindCallback(self, self.__onChangeItem)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).loopList).onInstantiateItem = BindCallback(self, self.__onInstantiateItem)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).loopList).totalCount = self.itemCount
  ;
  ((self.ui).loopList):RefillCells()
  if itemIndex ~= nil then
    local needScrollIndex = (math.max)(itemIndex - 1, 0)
    ;
    ((self.ui).loopList):SrollToCell(needScrollIndex, 999999)
  end
end

UIDungeonItemList.__onChangeItem = function(self, go, index)
  -- function num : 0_4
  if self.updateItemEvent ~= nil then
    (self.updateItemEvent)(go, index)
  end
end

UIDungeonItemList.__onInstantiateItem = function(self, go)
  -- function num : 0_5
  if self.initItemEvent ~= nil then
    (self.initItemEvent)(go)
  end
end

UIDungeonItemList.InjectDataAndFilterEvent = function(self, dungeonDataList)
  -- function num : 0_6
  self.dungeonDataList = dungeonDataList
  self.itemCount = #dungeonDataList
end

UIDungeonItemList.ExecuteFilter = function(self, itemCount)
  -- function num : 0_7
  self:__updateListItem(itemCount)
end

UIDungeonItemList.__updateListItem = function(self, itemCount)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).loopList).totalCount = itemCount
  ;
  ((self.ui).loopList):RefillCells()
end

UIDungeonItemList.Roll2Index = function(self, index, callback)
  -- function num : 0_9
  ((self.ui).loopList):SrollToCell(index, 10000, callback)
end

UIDungeonItemList.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnDelete)(self)
end

return UIDungeonItemList

