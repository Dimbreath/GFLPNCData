local UINEpOverclockChipSelect = class("UINEpOverclockChipSelect", UIBaseNode)
local base = UIBaseNode
local ChipData = require("Game.PlayerData.Item.ChipData")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
local UINEpOverclockChipItem = require("Game.Exploration.UI.Overclock.UINEpOverclockChipItem")
UINEpOverclockChipSelect.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self._onClickConfirm = BindCallback(self, self.OnClickConfirm)
  ;
  ((self.ui).obj_sortLabelItem):SetActive(false)
  self.chipDetailPanel = (UINChipDetailPanel.New)()
  ;
  (self.chipDetailPanel):Init((self.ui).uINChipItemDetail)
  ;
  (self.chipDetailPanel):ShowHeroHeadOrTacticActive(false)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onInstantiateItem = BindCallback(self, self.__OnListInstantiateItem)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onChangeItem = BindCallback(self, self.__OnChipListChangedItem)
  self.__onChipItemClick = BindCallback(self, self.__OnChipItemClick)
  self.chipItemDic = {}
  self:Hide()
end

UINEpOverclockChipSelect.InitClockChipSelectNode = function(self, dynplayer, chipDic, resLoader, selectComplete)
  -- function num : 0_1
  self:Show()
  self.__selectComplete = selectComplete
  self.__dynPlayer = dynplayer
  self.resLoader = resLoader
  self.selectedIndex = 1
  self:__InitChipsData(chipDic)
  self:RefreshClockSelectItemDetail()
end

UINEpOverclockChipSelect.__InitChipsData = function(self, chipDic)
  -- function num : 0_2
  self.__chipDataList = self:__SortChipList(chipDic)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).chipList).totalCount = #self.__chipDataList
  ;
  ((self.ui).chipList):RefillCells()
end

UINEpOverclockChipSelect.__SortChipList = function(self, chipDic)
  -- function num : 0_3 , upvalues : _ENV, ChipData
  local tab = {}
  for chipId,_ in pairs(chipDic) do
    local chipData = (ChipData.NewChipForLocal)(chipId)
    ;
    (table.insert)(tab, chipData)
  end
  ;
  (table.sort)(tab, function(chip1, chip2)
    -- function num : 0_3_0
    local quality1 = chip1:GetQuality()
    local quality2 = chip2:GetQuality()
    if quality2 >= quality1 then
      do return quality1 == quality2 end
      do return chip1.dataId < chip2.dataId end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  return tab
end

UINEpOverclockChipSelect.__OnListInstantiateItem = function(self, go)
  -- function num : 0_4 , upvalues : UINEpOverclockChipItem
  local chipItem = (UINEpOverclockChipItem.New)()
  chipItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.chipItemDic)[go] = chipItem
end

UINEpOverclockChipSelect.__OnChipListChangedItem = function(self, go, index)
  -- function num : 0_5 , upvalues : _ENV
  local chipItem = (self.chipItemDic)[go]
  if chipItem == nil then
    error("Can\'t find chipItem by gameObject")
    return 
  end
  index = index + 1
  local chipData = (self.__chipDataList)[index]
  if chipData == nil then
    error("Can\'t find chipData by index:" .. tonumber(index))
  end
  chipItem:InitOverclockChipItem(index, chipData, self.__onChipItemClick)
  chipItem:SetSelectUI(index == self.selectedIndex)
  if self.__dynPlayer ~= nil then
    (chipItem.chipItem):UpdateChipItem(self.__dynPlayer)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINEpOverclockChipSelect.__OnChipItemClick = function(self, chipItem)
  -- function num : 0_6
  if chipItem == nil then
    return 
  end
  if self.selectedIndex == chipItem.index then
    return 
  end
  local lastItem = self:__GetItemByIndex(self.selectedIndex)
  if lastItem ~= nil then
    lastItem:SetSelectUI(false)
  end
  self.selectedIndex = chipItem.index
  chipItem:SetSelectUI(true)
  ;
  (chipItem.chipItem):RefreshLevelTween()
  self:RefreshClockSelectItemDetail()
end

UINEpOverclockChipSelect.RefreshClockSelectItemDetail = function(self)
  -- function num : 0_7
  local index = self.selectedIndex or 1
  local chipData = (self.__chipDataList)[index]
  if chipData == nil then
    (self.chipDetailPanel):Hide()
    return 
  end
  ;
  (self.chipDetailPanel):Show()
  ;
  (self.chipDetailPanel):InitEpChipDetail(self.selectedIndex, chipData, self.__dynPlayer, self.resLoader)
  ;
  (self.chipDetailPanel):ShowEpChipDetailEff()
  ;
  ((self.chipDetailPanel):GetDetailButtonGroup()):InitBtnSelect(self._onClickConfirm)
end

UINEpOverclockChipSelect.__GetItemByIndex = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  local go = ((self.ui).chipList):GetCellByIndex(index - 1)
  do
    if not IsNull(go) then
      local storeItem = (self.chipItemDic)[go]
      return storeItem
    end
    return nil
  end
end

UINEpOverclockChipSelect.OnClickConfirm = function(self)
  -- function num : 0_9
  local chipData = (self.__chipDataList)[self.selectedIndex]
  if chipData == nil then
    return 
  end
  self:Hide()
  if self.__selectComplete ~= nil then
    (self.__selectComplete)(chipData)
    self.__selectComplete = nil
  end
end

UINEpOverclockChipSelect.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (self.chipDetailPanel):OnDelete()
  ;
  (base.OnDelete)(self)
end

return UINEpOverclockChipSelect

