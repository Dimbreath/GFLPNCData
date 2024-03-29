local UINSortButtonGroup = class("UINSortButtonGroup", UIBaseNode)
local base = UIBaseNode
local UINSortButtonItem = require("Game.Hero.NewUI.SortList.UINSortButtonItem")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
UINSortButtonGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).obj_SortItem):SetActive(false)
  self.itemDic = {}
  self.__onItemClick = BindCallback(self, self.__OnItemClick)
end

UINSortButtonGroup.InitSortButtonGroup = function(self, SortMannerDefine, itemClickAction, fid)
  -- function num : 0_1 , upvalues : _ENV, UINSortButtonItem, HeroSortEnum
  self.fid = fid
  local SavedSortMannerType, savedIsAsceSort = (PlayerDataCenter.cacheSaveData):GetSpecificHeroListSort(fid)
  if SortMannerDefine == nil then
    return 
  end
  self.itemClickAction = itemClickAction
  self.sortMannerDefine = SortMannerDefine
  local sortItem = nil
  for type,sortData in ipairs(SortMannerDefine) do
    sortItem = (self.itemDic)[type]
    if sortItem == nil then
      sortItem = (UINSortButtonItem.New)()
      local go = ((self.ui).obj_SortItem):Instantiate()
      go:SetActive(true)
      sortItem:Init(go)
    end
    do
      do
        sortItem:InitSortButtonItem(type, false, self.__onItemClick)
        -- DECOMPILER ERROR at PC39: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.itemDic)[type] = sortItem
        -- DECOMPILER ERROR at PC44: Unhandled construct in 'MakeBoolean' P1

        if SavedSortMannerType ~= nil and type == SavedSortMannerType then
          self.selectItem = sortItem
          -- DECOMPILER ERROR at PC46: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (self.selectItem).isAscend = savedIsAsceSort
          ;
          (self.selectItem):RefeshSortStateUI()
        end
        if type == (HeroSortEnum.eSortMannerType).Level then
          self.selectItem = sortItem
        end
        -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self:__RefreshButtonGroupUI(self.selectItem)
  self:__GetSortFunc(self.selectItem)
end

UINSortButtonGroup.__RefreshButtonGroupUI = function(self, selectItem)
  -- function num : 0_2 , upvalues : _ENV
  for type,Item in pairs(self.itemDic) do
    if Item ~= selectItem then
      Item:SetAllStateUI(false)
    else
      selectItem:RefeshSortStateUI()
    end
  end
end

UINSortButtonGroup.__OnItemClick = function(self, sortType)
  -- function num : 0_3
  local sortItem = (self.itemDic)[sortType]
  if sortItem == nil then
    return 
  end
  if self.selectItem == sortItem then
    (self.selectItem):ReversalAscend()
  else
    self:__RefreshButtonGroupUI(sortItem)
    self.selectItem = sortItem
  end
  self:__GetSortFunc(self.selectItem)
end

UINSortButtonGroup.__GetSortFunc = function(self, selectItem)
  -- function num : 0_4 , upvalues : _ENV
  if selectItem == nil then
    return 
  end
  if selectItem.isAscend then
    self.sortFunc = ((self.sortMannerDefine)[selectItem.sortType]).asceSort
  else
    self.sortFunc = ((self.sortMannerDefine)[selectItem.sortType]).descSort
  end
  ;
  (PlayerDataCenter.cacheSaveData):SetSpecificHeroListSort(self.fid, selectItem.sortType, selectItem.isAscend)
  if self.itemClickAction ~= nil then
    (self.itemClickAction)(self.sortFunc)
  end
end

UINSortButtonGroup.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.itemDic ~= nil then
    for type,item in pairs(self.itemDic) do
      item:OnDelete()
    end
    self.itemDic = nil
  end
end

return UINSortButtonGroup

