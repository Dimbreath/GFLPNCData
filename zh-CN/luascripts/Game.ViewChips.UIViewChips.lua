-- params : ...
-- function num : 0 , upvalues : _ENV
local UIViewChips = class("UIViewChips", UIBaseWindow)
local base = UIBaseWindow
local UIViewChipsItem = require("Game.ViewChips.UIViewChipsItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
local ChipData = require("Game.PlayerData.Item.ChipData")
UIViewChips.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).mask_Close, self, self.__OnClickClose)
  ;
  ((self.ui).obj_chipItem):SetActive(false)
  self.chipDetailPanel = (UINChipDetailPanel.New)()
  ;
  (self.chipDetailPanel):Init((self.ui).chipItemDetail)
  ;
  (self.chipDetailPanel):SetChipEffectHeroNodeActive(false)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onInstantiateItem = BindCallback(self, self.__LevelChipListInitItem)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipList).onChangeItem = BindCallback(self, self.__LevelChipListItemChanged)
  self.__onLevelItemClick = BindCallback(self, self.__OnLevelItemClick)
  self.__OnChipSetUpdate = BindCallback(self, self.OnChipSetUpdate)
  MsgCenter:AddListener(eMsgEventId.SectorChipSet, self.__OnChipSetUpdate)
  self.levelChipItemDic = {}
  self.chipSetTab = {}
end

UIViewChips.InitLevelChip = function(self, sectorStageCfg, resLoader)
  -- function num : 0_1 , upvalues : _ENV, ChipData
  self.resLoader = resLoader
  self.selectedIndex = 1
  self.networkContrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  ;
  (self.networkContrl):SendChipSet()
  local chip_dic = {}
  for k,v in pairs(sectorStageCfg.function_extra) do
    chip_dic[v] = true
  end
  local chip_pool_dic = {}
  for _,epId in pairs(sectorStageCfg.exploration_list) do
    local epCfg = (ConfigData.exploration)[epId]
    if epCfg ~= nil then
      for _,poolId in pairs(epCfg.chip_pool) do
        chip_pool_dic[poolId] = true
        local funcPoolCfg = (ConfigData.ep_function_pool)[poolId]
        if funcPoolCfg ~= nil then
          for _,chipId in pairs(funcPoolCfg.function_pool) do
            chip_dic[chipId] = true
          end
        end
      end
    end
  end
  self.chipDataList = {}
  local chipData = nil
  for itemId,_ in pairs(chip_dic) do
    chipData = (ChipData.New)(itemId)
    chipData.isLock = false
    ;
    (table.insert)(self.chipDataList, chipData)
  end
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).chipList).totalCount = #self.chipDataList
  self:__ChipListUpdateInternal()
end

UIViewChips.InitChips = function(self, chipDataList, resLoader, needShowLock)
  -- function num : 0_2 , upvalues : _ENV
  self.resLoader = resLoader
  self.selectedIndex = 1
  self.needShowLock = needShowLock or false
  self.chipDataList = {}
  for index,value in ipairs(chipDataList) do
    (table.insert)(self.chipDataList, value)
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).chipList).totalCount = #self.chipDataList
  self:__ChipListUpdateInternal()
end

UIViewChips.OnChipSetUpdate = function(self, chipSetTab)
  -- function num : 0_3 , upvalues : _ENV
  for _,chipData in ipairs(self.chipDataList) do
    if chipSetTab[chipData.dataId] ~= nil then
      chipData.isLock = true
    end
  end
  self:__ChipListUpdateInternal()
end

UIViewChips.__ChipListUpdateInternal = function(self)
  -- function num : 0_4
  self:__SortList()
  ;
  ((self.ui).chipList):RefillCells()
end

UIViewChips.__SortList = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (table.sort)(self.chipDataList, function(chip1, chip2)
    -- function num : 0_5_0
    local unlock1 = chip1.isLock
    local unlock2 = chip2.isLock
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
  ;
  ((self.ui).chipList):RefillCells()
end

UIViewChips.__LevelChipListInitItem = function(self, go)
  -- function num : 0_6 , upvalues : UIViewChipsItem
  local levelChipItem = (UIViewChipsItem.New)()
  levelChipItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.levelChipItemDic)[go] = levelChipItem
end

UIViewChips.__LevelChipListItemChanged = function(self, go, index)
  -- function num : 0_7 , upvalues : _ENV
  local levelChipItem = (self.levelChipItemDic)[go]
  if levelChipItem == nil then
    error("Can\'t find levelChipItem by gameObject")
    return 
  end
  index = index + 1
  local ChipData = (self.chipDataList)[index]
  if ChipData == nil then
    error("Can\'t find ChipData by index:" .. tonumber(index))
  end
  if self.needShowLock then
    levelChipItem:InitLevelChipItem(index, ChipData, ChipData.isLock)
  else
    levelChipItem:InitLevelChipItem(index, ChipData, true)
  end
  levelChipItem:SetLevelChipItemSelect(index == self.selectedIndex)
  levelChipItem:SetClickEvent(self.__onLevelItemClick)
  self:RefreshSelectItemDetail()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIViewChips.__OnLevelItemClick = function(self, levelChipItem)
  -- function num : 0_8
  if levelChipItem == nil then
    return 
  end
  if self.selectedIndex == levelChipItem:GetIndex() then
    return 
  end
  local lastStoreItem = self:__GetItemByIndex(self.selectedIndex)
  if lastStoreItem ~= nil then
    lastStoreItem:SetLevelChipItemSelect(false)
  end
  self.selectedIndex = levelChipItem:GetIndex()
  levelChipItem:SetLevelChipItemSelect(true)
  self:RefreshSelectItemDetail()
end

UIViewChips.RefreshSelectItemDetail = function(self)
  -- function num : 0_9
  local chipData = (self.chipDataList)[self.selectedIndex]
  if chipData == nil then
    (self.chipDetailPanel):Hide()
    return 
  end
  ;
  (self.chipDetailPanel):Show()
  ;
  (self.chipDetailPanel):InitChipDetailPanel(self.selectedIndex, chipData, nil, self.resloader, nil)
end

UIViewChips.__GetItemByIndex = function(self, index)
  -- function num : 0_10 , upvalues : _ENV
  local go = ((self.ui).chipList):GetCellByIndex(index - 1)
  do
    if not IsNull(go) then
      local storeItem = (self.levelChipItemDic)[go]
      return storeItem
    end
    return nil
  end
end

UIViewChips.__OnClickClose = function(self)
  -- function num : 0_11
  self:Hide()
end

UIViewChips.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.SectorChipSet, self.__OnChipSetUpdate)
  ;
  (base.OnDelete)(self)
end

return UIViewChips

