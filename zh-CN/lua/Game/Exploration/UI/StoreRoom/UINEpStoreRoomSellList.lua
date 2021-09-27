local UINEpStoreRoomSellList = class("UINEpStoreRoomSellList", UIBaseNode)
local base = UIBaseNode
local UIEpStoreRoomItem = require("Game.Exploration.UI.StoreRoom.UIEpStoreRoomItem")
UINEpStoreRoomSellList.ctor = function(self, storeRoomRoot)
  -- function num : 0_0
  self.storeRoomRoot = storeRoomRoot
end

UINEpStoreRoomSellList.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self._OnClickChipItemFunc = BindCallback(self, self._OnClickChipItem)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).storeList).onInstantiateItem = BindCallback(self, self.__StoreListInitItem)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).storeList).onChangeItem = BindCallback(self, self.__ChipListItemChanged)
  self.storeItemDic = {}
end

UINEpStoreRoomSellList.InitEpStoreRoomSell = function(self, chipList)
  -- function num : 0_2
  self.chipList = chipList
  self.selectedIndex = 1
  ;
  (self.storeRoomRoot):RefreshSelectItemDetailSoldOut(self.selectedIndex)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).storeList).totalCount = #chipList
  ;
  ((self.ui).storeList):RefreshCells()
end

UINEpStoreRoomSellList.__StoreListInitItem = function(self, go)
  -- function num : 0_3 , upvalues : UIEpStoreRoomItem
  local storeItem = (UIEpStoreRoomItem.New)()
  storeItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.storeItemDic)[go] = storeItem
end

UINEpStoreRoomSellList.__ChipListItemChanged = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local storeItem = (self.storeItemDic)[go]
  if storeItem == nil then
    error("Can\'t find Item by gameObject")
    return 
  end
  index = index + 1
  local chipData = (self.chipList)[index]
  chipData.idx = index
  if chipData == nil then
    error("Can\'t find chipData by index, index = " .. tonumber(index))
  end
  storeItem:InitStoreRoomItem((self.storeRoomRoot).roomId, chipData, (self.storeRoomRoot).MoneyIconId, self._OnClickChipItemFunc, true, ((self.storeRoomRoot).storeCtrl).dynPlayer)
  storeItem:SetStoreItemSelect(index == self.selectedIndex)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINEpStoreRoomSellList.GetEpStoreRoomSellByIndex = function(self, index)
  -- function num : 0_5 , upvalues : _ENV
  local go = ((self.ui).storeList):GetCellByIndex(index - 1)
  do
    if not IsNull(go) then
      local storeItem = (self.storeItemDic)[go]
      return storeItem
    end
    return nil
  end
end

UINEpStoreRoomSellList.GetCurEpStoreRoomSell = function(self)
  -- function num : 0_6
  return self:GetEpStoreRoomSellByIndex(self.selectedIndex)
end

UINEpStoreRoomSellList._OnClickChipItem = function(self, chipItem)
  -- function num : 0_7
  if self.selectedIndex == chipItem.index then
    return 
  end
  self.selectedIndex = chipItem.index
  ;
  (self.storeRoomRoot):OnSelectStoreChipItem(chipItem)
end

UINEpStoreRoomSellList.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpStoreRoomSellList

