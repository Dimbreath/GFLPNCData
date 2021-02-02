-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthScrollList = class("UINAthScrollList", UIBaseNode)
local base = UIBaseNode
local UINAthItem = require("Game.Arithmetic.AthList.Area.UINAthItem")
local UINAthListGroup = require("Game.Arithmetic.AthList.Area.UINAthListGroup")
local AthTableUtil = require("Game.Arithmetic.AthMain.Table.AthTableUtil")
local UINAthMatUpgrade = require("Game.Arithmetic.AthList.Area.MatUpgrade.UINAthMatUpgrade")
local CS_EventSystem = ((CS.UnityEngine).EventSystems).EventSystem
local spaceIdDic = {[1] = 1, [2] = 2, [4] = 3, [8] = 4}
local groupXMax = 6
local groupYMax = 2
local sizeGroupPosIdList = {
[1] = {1, 7, 2, 8, 3, 9, 4, 10, 5, 11, 6, 12}
, 
[2] = {1, 2, 3, 4, 5, 6}
, 
[4] = {1, 2, 3, 4, 5}
}
UINAthScrollList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, groupXMax, groupYMax, UINAthItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self:SetAthScrollListGroupGridSize((Vector2.New)(groupXMax, groupYMax))
  self.__onAthItemClick = BindCallback(self, self.OnAthItemClick)
  self.__onReturnAthItem = BindCallback(self, self._ReturnAthItem)
  self.__onReturnAthMatNode = BindCallback(self, self._ReturnAthMatNode)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).OnDragStartHorizontal = BindCallback(self, self.__OnDragStartHorizontal)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.athItemPoolList = {}
  for k,go in ipairs((self.ui).athSpaceItemList) do
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R6 in 'UnsetPending'

    (self.athItemPoolList)[k] = (UIItemPool.New)(UINAthItem, go)
  end
  self.athItemGoDic = {}
  self.athGroupItemDic = {}
  self._clickItemWithScroll = true
end

UINAthScrollList.SetAthScrollListGroupGridSize = function(self, groupGridSize)
  -- function num : 0_1
  self.groupGridSize = groupGridSize
end

UINAthScrollList.SetAthScrollListClickItemWithScroll = function(self, clickItemWithScroll)
  -- function num : 0_2
  self._clickItemWithScroll = clickItemWithScroll
end

UINAthScrollList.InitAthScrollList = function(self, heroData, areaId, quality, clickItemFunc, itemStartDragFunc, resLoader, withMat, ignoreInstalled)
  -- function num : 0_3 , upvalues : UINAthMatUpgrade
  self.heroData = heroData
  self.resLoader = resLoader
  self.areaId = areaId
  self.quality = quality
  self.clickItemFunc = clickItemFunc
  self.itemStartDragFunc = itemStartDragFunc
  self.withMat = withMat
  if not ignoreInstalled then
    self.ignoreInstalled = self.withMat
    if withMat and self.athMatUpNode == nil then
      self.athMatUpNode = (UINAthMatUpgrade.New)()
      ;
      (self.athMatUpNode):Init((self.ui).athUpgradeItemList)
    end
  end
end

UINAthScrollList.SetAthScrollListArea = function(self, areaId)
  -- function num : 0_4
  self.areaId = areaId
end

UINAthScrollList.RefreshAthScrollListData = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local ignoreInstalled = self.ignoreInstalled
  self.oriAthDataList = nil
  if self.areaId == nil then
    self.oriAthDataList = (PlayerDataCenter.allAthData):GetAllAthList(nil, ignoreInstalled, self.quality)
  else
    self.oriAthDataList = (PlayerDataCenter.allAthData):GetAllAthSlotList(self.areaId, nil, ignoreInstalled)
  end
end

UINAthScrollList.SetAthScrollListRefillFunc = function(self, refillFunc)
  -- function num : 0_6
  self.refillFunc = refillFunc
end

UINAthScrollList.SetAthScrollListSortFunc = function(self, funcSort)
  -- function num : 0_7
  self.funcSort = funcSort
end

UINAthScrollList.SetAthScrollListSiftFunc = function(self, funcSift)
  -- function num : 0_8
  self.funcSift = funcSift
end

UINAthScrollList.RefillAthScrollList = function(self, funcSift, funcSort, useLastPos)
  -- function num : 0_9 , upvalues : _ENV
  if funcSift ~= nil then
    self.funcSift = funcSift
  end
  if funcSort ~= nil then
    self.funcSort = funcSort
  end
  self.curAthSuitDic = {}
  if self.heroData ~= nil then
    self.curAthSuitDic = (PlayerDataCenter.allAthData):GetHeroAthSuitIdDic((self.heroData).dataId, self.areaId)
  end
  self.curAthDataList = {}
  for index,athData in ipairs(self.oriAthDataList) do
    if self.funcSift == nil or (self.funcSift)(athData) then
      (table.insert)(self.curAthDataList, athData)
    end
  end
  if self.funcSort ~= nil then
    (table.sort)(self.curAthDataList, self.funcSort)
  end
  self.curAthDataGroupList = {}
  local tempGroup, tempGroupIdList = nil, nil
  local freeSpaceNewLine = false
  for k,athData in ipairs(self.curAthDataList) do
    if tempGroup == nil then
      tempGroup = {allSize = 0}
      tempGroupIdList = {}
      ;
      (table.insert)(self.curAthDataGroupList, tempGroup)
    end
    local size = athData:GetAthSize()
    local forceNewLine = false
    -- DECOMPILER ERROR at PC76: Unhandled construct in 'MakeBoolean' P1

    if not freeSpaceNewLine and #tempGroup ~= 0 then
      forceNewLine = true
    end
    freeSpaceNewLine = true
    if forceNewLine or not self:__Insert2TempGroup(tempGroupIdList, tempGroup, athData) then
      tempGroup = {allSize = 0}
      tempGroupIdList = {}
      ;
      (table.insert)(self.curAthDataGroupList, tempGroup)
      self:__Insert2TempGroup(tempGroupIdList, tempGroup, athData)
    end
  end
  self:__RefillList(useLastPos)
  if self.refillFunc ~= nil then
    (self.refillFunc)()
  end
end

UINAthScrollList.__Insert2TempGroup = function(self, tempGroupIdList, tempGroup, athData)
  -- function num : 0_10 , upvalues : sizeGroupPosIdList, _ENV, AthTableUtil
  local athSize = athData:GetAthSize()
  local posIdList = sizeGroupPosIdList[athSize]
  local groupMaxCount = (self.groupGridSize).x * (self.groupGridSize).y
  for k,posId in ipairs(posIdList) do
    if tempGroupIdList[posId] == nil then
      local gridIdList = (AthTableUtil.GetAthGridIdList)(athData, posId, (self.groupGridSize).x)
      local canInsert = true
      for k,gridId in ipairs(gridIdList) do
        if groupMaxCount < gridId or tempGroupIdList[gridId] == true then
          canInsert = false
          break
        end
      end
      do
        do
          if canInsert then
            for k,gridId in ipairs(gridIdList) do
              tempGroupIdList[gridId] = true
            end
            tempGroup.allSize = tempGroup.allSize + athSize
            ;
            (table.insert)(tempGroup, {gridId = posId, athData = athData})
            return true
          end
          -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC56: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return false
end

UINAthScrollList.__RefillList = function(self, useLastPos)
  -- function num : 0_11 , upvalues : _ENV
  local totalCount = #self.curAthDataGroupList
  if self.withMat then
    totalCount = totalCount + 1
  end
  if ((self.ui).scrollRect).totalCount == 0 then
    useLastPos = false
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).totalCount = totalCount
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  if useLastPos then
    ((self.ui).scrollRect).velocity = (Vector2.New)(0, 0.001)
    ;
    ((self.ui).scrollRect):RefreshCells()
  else
    ;
    ((self.ui).scrollRect):RefillCells()
  end
end

UINAthScrollList.SetAthScrollListMultSeletedUidDic = function(self, dic)
  -- function num : 0_12
  self.athMultSeletedUidDic = dic
end

UINAthScrollList.__OnDragStartHorizontal = function(self)
  -- function num : 0_13 , upvalues : CS_EventSystem
  local curGo = (CS_EventSystem.current).currentSelectedGameObject
  local item = (self.athItemGoDic)[curGo]
  if item == nil then
    return 
  end
  item:OnAthItemBeginDrag()
end

UINAthScrollList.__OnNewItem = function(self, go)
  -- function num : 0_14 , upvalues : UINAthListGroup
  local item = (UINAthListGroup.New)()
  item:Init(go)
  item:InitAthListGroup(self.__onReturnAthItem, self.__onReturnAthMatNode, self.groupGridSize)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.athGroupItemDic)[go] = item
end

UINAthScrollList.__OnChangeItem = function(self, go, index)
  -- function num : 0_15 , upvalues : _ENV, spaceIdDic
  local item = (self.athGroupItemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  item:ClealAllAthItem()
  -- DECOMPILER ERROR at PC17: Unhandled construct in 'MakeBoolean' P1

  if self.withMat and index == 0 then
    item:AddMatNode2Group(self.athMatUpNode)
    return 
  end
  index = index + 1
  local groupData = (self.curAthDataGroupList)[index]
  if groupData == nil then
    error("Can\'t find ath groupData by index, index = " .. tonumber(index))
  end
  for k,v in ipairs(groupData) do
    local athSize = (v.athData):GetAthSize()
    local itemPool = (self.athItemPoolList)[spaceIdDic[athSize]]
    local athItem = itemPool:GetOne()
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (athItem.gameObject).name = tostring(k)
    if self.newItemFunc ~= nil then
      (self.newItemFunc)(athItem)
    end
    if self.itemStartDragFunc ~= nil then
      athItem:SetAthItemDragFunc(self.itemStartDragFunc)
    end
    athItem:SetAthItemRootScrollRectRoot((self.ui).scrollRect)
    athItem:InitAthItem(v.athData, self.__onAthItemClick, self.resLoader)
    local selected = self.athMultSeletedUidDic ~= nil and (self.athMultSeletedUidDic)[(v.athData).uid] ~= nil
    athItem:SetAthItemSelect(selected, true)
    local suitId = (v.athData):GetAthSuit()
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R15 in 'UnsetPending'

    if self.curAthSuitDic == nil or (self.curAthSuitDic)[suitId] then
      do
        (self.athItemGoDic)[athItem.gameObject] = athItem
        item:AddAthItem2Group(athItem, v.gridId)
        -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINAthScrollList.__OnReturnItem = function(self, go)
  -- function num : 0_16
  local groupItem = (self.athGroupItemDic)[go]
  groupItem:ClealAllAthItem()
end

UINAthScrollList._ReturnAthItem = function(self, athItem)
  -- function num : 0_17 , upvalues : spaceIdDic
  local athSize = (athItem:GetAthItemData()):GetAthSize()
  athItem:TryReturnAthItemSuit(function(hasSuitItem)
    -- function num : 0_17_0
  end
)
  local itemPool = (self.athItemPoolList)[spaceIdDic[athSize]]
  ;
  (athItem.transform):SetParent((self.ui).prefabHolder)
  itemPool:HideOne(athItem)
end

UINAthScrollList._ReturnAthMatNode = function(self)
  -- function num : 0_18
  if self.athMatUpNode ~= nil then
    ((self.athMatUpNode).transform):SetParent((self.ui).prefabHolder)
  end
end

UINAthScrollList.GetAthItemFromListAll = function(self, uid)
  -- function num : 0_19
  local index = self:__GetAthDataGroupIndexByUid(uid)
  local go = ((self.ui).scrollRect):GetCellByIndex(index - 1)
  if go == nil then
    return nil
  end
  local groupItem = (self.athGroupItemDic)[go]
  return groupItem:GetAthItemFromAllGroup(uid)
end

UINAthScrollList.OnAthItemClick = function(self, athItem)
  -- function num : 0_20
  local uid = (athItem:GetAthItemData()):GenAthDataUID()
  local rollIndex = self:__GetAthDataGroupIndexByUid(uid)
  if not self.withMat then
    rollIndex = rollIndex - 1
  end
  local clickItemFunc = function()
    -- function num : 0_20_0 , upvalues : self, athItem
    if self.clickItemFunc ~= nil then
      (self.clickItemFunc)(athItem)
    end
  end

  if self._clickItemWithScroll then
    ((self.ui).scrollRect):SrollToCell(rollIndex, 1500, clickItemFunc)
  else
    clickItemFunc()
  end
end

UINAthScrollList.__GetAthDataGroupIndexByUid = function(self, uid)
  -- function num : 0_21 , upvalues : _ENV
  for index,v in ipairs(self.curAthDataGroupList) do
    for k,v2 in ipairs(v) do
      if (v2.athData).uid == uid then
        return index
      end
    end
  end
end

UINAthScrollList.GetAthScrollListMatUpNode = function(self)
  -- function num : 0_22
  return self.athMatUpNode
end

UINAthScrollList.GetAthScrollListCurAthList = function(self)
  -- function num : 0_23
  return self.curAthDataList
end

UINAthScrollList.OnDelete = function(self)
  -- function num : 0_24 , upvalues : _ENV, base
  for k,pool in ipairs(self.athItemPoolList) do
    pool:DeleteAll()
  end
  if self.athMatUpNode ~= nil then
    (self.athMatUpNode):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINAthScrollList

