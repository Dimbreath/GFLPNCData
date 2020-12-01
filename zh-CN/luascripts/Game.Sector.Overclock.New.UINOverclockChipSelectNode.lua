-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOverclockChipSelectNode = class("UINOverclockChipSelectNode", UIBaseNode)
local base = UIBaseNode
local ChipData = require("Game.PlayerData.Item.ChipData")
local UINOverclockChipItem = require("Game.Sector.Overclock.New.UINOverclockChipItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
UINOverclockChipSelectNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, false)
  ;
  ((self.ui).obj_sortLabelItem):SetActive(false)
  self.chipDetailPanel = (UINChipDetailPanel.New)()
  ;
  (self.chipDetailPanel):Init((self.ui).uINChipItemDetail)
  ;
  (self.chipDetailPanel):ShowHeroHeadOrTacticActive(false)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onInstantiateItem = BindCallback(self, self.__OnListInstantiateItem)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onChangeItem = BindCallback(self, self.__OnChipListChangedItem)
  self.__onChipItemClick = BindCallback(self, self.__OnChipItemClick)
  self:Hide()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnClickCancel)
  self.chipItemDic = {}
end

UINOverclockChipSelectNode.InitChipSelectNode = function(self, overclockId, overclockNode, resLoader)
  -- function num : 0_1
  self.overclockId = overclockId
  self.overclockNode = overclockNode
  self.resLoader = resLoader
  self.selectedIndex = 1
  self.chipDataList = {}
  self:__InitChipsData((self.OverclockCtrl).chipDic)
  self:RefreshSelectItemDetail()
end

UINOverclockChipSelectNode.__InitChipsData = function(self, chipDic)
  -- function num : 0_2
  self.chipDataList = self:__SortChipList(chipDic)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).chipList).totalCount = #self.chipDataList
  ;
  ((self.ui).chipList):RefillCells()
end

UINOverclockChipSelectNode.__SortChipList = function(self, chipDic)
  -- function num : 0_3 , upvalues : _ENV, ChipData
  local tab = {}
  for chipId,_ in pairs(chipDic) do
    local chipData = (ChipData.New)(chipId)
    local isUnlock = (self.OverclockCtrl):IsChipUnlock(chipId)
    chipData.isUnlock = isUnlock
    ;
    (table.insert)(tab, chipData)
  end
  ;
  (table.sort)(tab, function(chip1, chip2)
    -- function num : 0_3_0
    local unlock1 = chip1.isUnlock
    local unlock2 = chip2.isUnlock
    local quality1 = chip1:GetQuality()
    local quality2 = chip2:GetQuality()
    local id1 = chip1.dataId
    local id2 = chip2.dataId
    if quality1 == quality2 then
      if id1 >= id2 then
        do return unlock1 ~= unlock2 end
        do return quality2 < quality1 end
        do return unlock1 end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
      end
    end
  end
)
  return tab
end

UINOverclockChipSelectNode.__OnListInstantiateItem = function(self, go)
  -- function num : 0_4 , upvalues : UINOverclockChipItem
  local chipItem = (UINOverclockChipItem.New)()
  chipItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.chipItemDic)[go] = chipItem
end

UINOverclockChipSelectNode.__OnChipListChangedItem = function(self, go, index)
  -- function num : 0_5 , upvalues : _ENV
  local chipItem = (self.chipItemDic)[go]
  if chipItem == nil then
    error("Can\'t find chipItem by gameObject")
    return 
  end
  index = index + 1
  local chipData = (self.chipDataList)[index]
  if chipData == nil then
    error("Can\'t find chipData by index:" .. tonumber(index))
  end
  chipItem:InitOverclockChipItem(index, chipData, self.__onChipItemClick)
  chipItem:SetSelectUI(index == self.selectedIndex)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINOverclockChipSelectNode.__OnChipItemClick = function(self, chipItem)
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
  self:RefreshSelectItemDetail()
end

UINOverclockChipSelectNode.RefreshSelectItemDetail = function(self)
  -- function num : 0_7
  local index = self.selectedIndex or 1
  local chipData = (self.chipDataList)[index]
  if chipData == nil then
    (self.chipDetailPanel):Hide()
    return 
  end
  ;
  (self.chipDetailPanel):Show()
  ;
  (self.chipDetailPanel):InitChipDetailPanel(self.selectedIndex, chipData, nil, self.resloader, nil)
end

UINOverclockChipSelectNode.__GetItemByIndex = function(self, index)
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

UINOverclockChipSelectNode.OnClickConfirm = function(self)
  -- function num : 0_9
  if self.selectedIndex ~= nil then
    local chipData = (self.chipDataList)[self.selectedIndex]
    ;
    (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId, chipData.dataId)
  else
    do
      ;
      (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId, nil)
      self:Hide()
    end
  end
end

UINOverclockChipSelectNode.OnClickCancel = function(self)
  -- function num : 0_10
  local chipId = (self.OverclockCtrl):GetChip2OverClockOption(self.overclockId)
  if chipId ~= nil then
    (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId, chipId)
  else
    ;
    (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId, nil)
  end
  self:Hide()
end

UINOverclockChipSelectNode.SetTitleCallback = function(self, titleCallback)
  -- function num : 0_11
  self.titleCallback = titleCallback
end

UINOverclockChipSelectNode.OnHide = function(self)
  -- function num : 0_12 , upvalues : base
  if self.titleCallback ~= nil then
    (self.titleCallback)()
  end
  if self.overclockNode ~= nil then
    (self.overclockNode):Show()
  end
  ;
  (base.OnHide)(self)
end

UINOverclockChipSelectNode.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  if self.chipItemDic ~= nil then
    for go,item in pairs(self.chipItemDic) do
      item:Delete()
    end
    self.chipItemDic = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINOverclockChipSelectNode

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOverclockChipSelectNode = class("UINOverclockChipSelectNode",
                                         UIBaseNode)
local base = UIBaseNode
local ChipData = require("Game.PlayerData.Item.ChipData")
local UINOverclockChipItem = require(
                                 "Game.Sector.Overclock.New.UINOverclockChipItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
UINOverclockChipSelectNode.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.OverclockCtrl = ControllerManager:GetController(
                             ControllerTypeId.Overclock, false);
    ((self.ui).obj_sortLabelItem):SetActive(false)
    self.chipDetailPanel = (UINChipDetailPanel.New)();
    (self.chipDetailPanel):Init((self.ui).uINChipItemDetail);
    (self.chipDetailPanel):ShowHeroHeadOrTacticActive(false) -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).chipList).onInstantiateItem =
        BindCallback(self, self.__OnListInstantiateItem) -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).chipList).onChangeItem = BindCallback(self,
                                                     self.__OnChipListChangedItem)
    self.__onChipItemClick = BindCallback(self, self.__OnChipItemClick)
    self:Hide();
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm);
    (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnClickCancel)
    self.chipItemDic = {}
end

UINOverclockChipSelectNode.InitChipSelectNode =
    function(self, overclockId, overclockNode, resLoader)
        -- function num : 0_1
        self.overclockId = overclockId
        self.overclockNode = overclockNode
        self.resLoader = resLoader
        self.selectedIndex = 1
        self.chipDataList = {}
        self:__InitChipsData((self.OverclockCtrl).chipDic)
        self:RefreshSelectItemDetail()
    end

UINOverclockChipSelectNode.__InitChipsData =
    function(self, chipDic)
        -- function num : 0_2
        self.chipDataList = self:__SortChipList(chipDic) -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).chipList).totalCount = #self.chipDataList;
        ((self.ui).chipList):RefillCells()
    end

UINOverclockChipSelectNode.__SortChipList =
    function(self, chipDic)
        -- function num : 0_3 , upvalues : _ENV, ChipData
        local tab = {}
        for chipId, _ in pairs(chipDic) do
            local chipData = (ChipData.New)(chipId)
            local isUnlock = (self.OverclockCtrl):IsChipUnlock(chipId)
            chipData.isUnlock = isUnlock;
            (table.insert)(tab, chipData)
        end
        (table.sort)(tab, function(chip1, chip2)
            -- function num : 0_3_0
            local unlock1 = chip1.isUnlock
            local unlock2 = chip2.isUnlock
            local quality1 = chip1:GetQuality()
            local quality2 = chip2:GetQuality()
            local id1 = chip1.dataId
            local id2 = chip2.dataId
            if quality1 == quality2 then
                if id1 >= id2 then
                    do return unlock1 ~= unlock2 end
                    do return quality2 < quality1 end
                    do return unlock1 end
                    -- DECOMPILER ERROR: 5 unprocessed JMP targets
                end
            end
        end)
        return tab
    end

UINOverclockChipSelectNode.__OnListInstantiateItem =
    function(self, go)
        -- function num : 0_4 , upvalues : UINOverclockChipItem
        local chipItem = (UINOverclockChipItem.New)()
        chipItem:Init(go) -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.chipItemDic)[go] = chipItem
    end

UINOverclockChipSelectNode.__OnChipListChangedItem =
    function(self, go, index)
        -- function num : 0_5 , upvalues : _ENV
        local chipItem = (self.chipItemDic)[go]
        if chipItem == nil then
            error("Can\'t find chipItem by gameObject")
            return
        end
        index = index + 1
        local chipData = (self.chipDataList)[index]
        if chipData == nil then
            error("Can\'t find chipData by index:" .. tonumber(index))
        end
        chipItem:InitOverclockChipItem(index, chipData, self.__onChipItemClick)
        chipItem:SetSelectUI(index == self.selectedIndex)
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end

UINOverclockChipSelectNode.__OnChipItemClick =
    function(self, chipItem)
        -- function num : 0_6
        if chipItem == nil then return end
        if self.selectedIndex == chipItem.index then return end
        local lastItem = self:__GetItemByIndex(self.selectedIndex)
        if lastItem ~= nil then lastItem:SetSelectUI(false) end
        self.selectedIndex = chipItem.index
        chipItem:SetSelectUI(true)
        self:RefreshSelectItemDetail()
    end

UINOverclockChipSelectNode.RefreshSelectItemDetail =
    function(self)
        -- function num : 0_7
        local index = self.selectedIndex or 1
        local chipData = (self.chipDataList)[index]
        if chipData == nil then
            (self.chipDetailPanel):Hide()
            return
        end
        (self.chipDetailPanel):Show();
        (self.chipDetailPanel):InitChipDetailPanel(self.selectedIndex, chipData,
                                                   nil, self.resloader, nil)
    end

UINOverclockChipSelectNode.__GetItemByIndex =
    function(self, index)
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

UINOverclockChipSelectNode.OnClickConfirm =
    function(self)
        -- function num : 0_9
        if self.selectedIndex ~= nil then
            local chipData = (self.chipDataList)[self.selectedIndex];
            (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId,
                                                         chipData.dataId)
        else
            do

                (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId,
                                                             nil)
                self:Hide()
            end
        end
    end

UINOverclockChipSelectNode.OnClickCancel =
    function(self)
        -- function num : 0_10
        local chipId = (self.OverclockCtrl):GetChip2OverClockOption(
                           self.overclockId)
        if chipId ~= nil then
            (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId,
                                                         chipId)
        else

            (self.OverclockCtrl):SetChip2OverClockOption(self.overclockId, nil)
        end
        self:Hide()
    end

UINOverclockChipSelectNode.SetTitleCallback =
    function(self, titleCallback)
        -- function num : 0_11
        self.titleCallback = titleCallback
    end

UINOverclockChipSelectNode.OnHide = function(self)
    -- function num : 0_12 , upvalues : base
    if self.titleCallback ~= nil then (self.titleCallback)() end
    if self.overclockNode ~= nil then (self.overclockNode):Show() end
    (base.OnHide)(self)
end

UINOverclockChipSelectNode.OnDelete = function(self)
    -- function num : 0_13 , upvalues : _ENV, base
    if self.chipItemDic ~= nil then
        for go, item in pairs(self.chipItemDic) do item:Delete() end
        self.chipItemDic = nil
    end
    (base.OnDelete)(self)
end

return UINOverclockChipSelectNode

