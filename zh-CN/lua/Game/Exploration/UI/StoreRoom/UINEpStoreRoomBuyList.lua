local UINEpStoreRoomBuyList = class("UINEpStoreRoomBuyList", UIBaseNode)
local base = UIBaseNode
local UIEpStoreRoomItem = require("Game.Exploration.UI.StoreRoom.UIEpStoreRoomItem")
local UINEpStoreBuffItem = require("Game.Exploration.UI.StoreRoom.UINEpStoreBuffItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
UINEpStoreRoomBuyList.ctor = function(self, storeRoomRoot)
  -- function num : 0_0
  self.storeRoomRoot = storeRoomRoot
end

UINEpStoreRoomBuyList.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UIEpStoreRoomItem, UINEpStoreBuffItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.chipItemPool = (UIItemPool.New)(UIEpStoreRoomItem, (self.ui).storeChipItem)
  ;
  ((self.ui).storeBuffItem):SetActive(false)
  self.buffItemPool = (UIItemPool.New)(UINEpStoreBuffItem, (self.ui).storeBuffItem)
  self._OnClickChipItemFunc = BindCallback(self, self._OnClickChipItem)
  self._OnClickBuffItemFunc = BindCallback(self, self._OnClickBuffItem)
end

UINEpStoreRoomBuyList.InitEpStoreRoomBuyList = function(self, storeItemDataList)
  -- function num : 0_2 , upvalues : _ENV, ChipEnum
  if #storeItemDataList > 20 then
    error("The num(chip + buff) greater than 20.")
    return 
  end
  self.itemIndexDic = {}
  local chipNum = 0
  local buffNum = 0
  local sortedStoreItemDataList = {}
  for k,v in ipairs(storeItemDataList) do
    (table.insert)(sortedStoreItemDataList, v)
    if v.chipData ~= nil then
      chipNum = chipNum + 1
    else
      if v.epBuffData ~= nil then
        buffNum = buffNum + 1
      end
    end
  end
  ;
  (table.sort)(sortedStoreItemDataList, function(a, b)
    -- function num : 0_2_0
    local aChip = a.chipData ~= nil
    local bChip = b.chipData ~= nil
    if aChip ~= bChip then
      return aChip
    end
    do return a.idx < b.idx end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
)
  self.selectIndex = nil
  for k,storeItemData in ipairs(sortedStoreItemDataList) do
    if not storeItemData.saled then
      self.selectIndex = storeItemData.idx
      break
    end
  end
  do
    if self.selectIndex == nil then
      self.selectIndex = 1
    end
    local hasChip = chipNum > 0
    ;
    ((self.ui).groupItem_Chip):SetActive(hasChip)
    local hasBuff = buffNum > 0
    ;
    ((self.ui).groupItem_Buff):SetActive(hasBuff)
    ;
    (self.chipItemPool):HideAll()
    ;
    (self.buffItemPool):HideAll()
    local buyPrice = nil
    for k,storeItemData in ipairs(sortedStoreItemDataList) do
      local isSelected = storeItemData.idx == self.selectIndex
      if storeItemData.chipData ~= nil then
        local chipItem = (self.chipItemPool):GetOne()
        ;
        (chipItem.transform):SetParent(((self.ui).groupItem_Chip).transform)
        ;
        (chipItem.transform):SetAsLastSibling()
        chipItem:InitStoreRoomItem((self.storeRoomRoot).roomId, storeItemData, (self.storeRoomRoot).MoneyIconId, self._OnClickChipItemFunc, nil, ((self.storeRoomRoot).storeCtrl).dynPlayer)
        chipItem:SetStoreItemSelect(isSelected)
        if isSelected then
          buyPrice = chipItem.price
        end
        local isHadChip = ((((self.storeRoomRoot).storeCtrl).dynPlayer).chipDic)[(storeItemData.chipData).dataId] ~= nil
        if not isHadChip or not (ChipEnum.eChipShowState).UpState then
          local chipShowState = (ChipEnum.eChipShowState).NewState
        end
        chipItem:SetNewTagActive(true, chipShowState)
        -- DECOMPILER ERROR at PC147: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (self.itemIndexDic)[storeItemData.idx] = chipItem
      elseif storeItemData.epBuffData ~= nil then
        local buffItem = (self.buffItemPool):GetOne()
        ;
        (buffItem.transform):SetAsLastSibling()
        buffItem:SetStoreBuffItemSelect(isSelected)
        buffItem:InitEpStoreBuffItem(storeItemData, (self.storeRoomRoot).MoneyIconId, self._OnClickBuffItemFunc)
        if isSelected then
          buyPrice = buffItem.price
        end
        -- DECOMPILER ERROR at PC172: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (self.itemIndexDic)[storeItemData.idx] = buffItem
      end
    end
    ;
    (self.storeRoomRoot):RefreshBuySelectItemDetail(self.selectIndex, buyPrice)
    self.selectBuyPrice = buyPrice
    -- DECOMPILER ERROR: 10 unprocessed JMP targets
  end
end

UINEpStoreRoomBuyList._OnClickChipItem = function(self, chipItem)
  -- function num : 0_3
  local index = (chipItem.epStoreItemData).idx
  if self.selectIndex == index then
    return 
  end
  self.selectIndex = index
  self.selectBuyPrice = chipItem.price
  ;
  (self.storeRoomRoot):OnSelectStoreChipItem(chipItem)
end

UINEpStoreRoomBuyList._OnClickBuffItem = function(self, buffItem)
  -- function num : 0_4
  local index = (buffItem.epStoreItemData).idx
  if self.selectIndex == index then
    return 
  end
  self.selectIndex = index
  self.selectBuyPrice = buffItem.price
  ;
  (self.storeRoomRoot):OnSelectStoreBuffItem(buffItem)
end

UINEpStoreRoomBuyList.GetEpStoreBuyData = function(self)
  -- function num : 0_5
  local selectItem = (self.itemIndexDic)[self.selectIndex]
  return self.selectIndex, self.selectBuyPrice, selectItem
end

UINEpStoreRoomBuyList.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.chipItemPool):DeleteAll()
  ;
  (self.buffItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINEpStoreRoomBuyList

