-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSortListAll = class("UINAthSortListAll", UIBaseNode)
local base = UIBaseNode
local UINAthListItem = require("Game.Arithmetic.AthSortList.UINAthListItem")
local UINAthSortListAllGroup = require("Game.Arithmetic.AthSortList.UINAthSortListAllGroup")
local UINAthHasSuitItem = require("Game.Arithmetic.AthSortList.UINAthHasSuitItem")
local UINAthMatUpgrade = require("Game.Arithmetic.AthSortList.UINAthMatUpgrade")
local AthTableUtil = require("Game.Arithmetic.AthMain.Table.AthTableUtil")
local CS_EventSystem = ((CS.UnityEngine).EventSystems).EventSystem
local CS_LayoutRebuilder = ((CS.UnityEngine).UI).LayoutRebuilder
local spaceIdDic = {[1] = 1, [2] = 2, [4] = 3, [8] = 4}
local groupXMax = 4
local groupYMax = 4
local groupMaxCount = groupXMax * groupYMax
UINAthSortListAll.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthListItem, UINAthHasSuitItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__onReturnAthItem = BindCallback(self, self.ReturnAthItem)
  self.__onReturnAthMatNode = BindCallback(self, self.ReturnAthMatNode)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).OnDragStartHorizontal = BindCallback(self, self.__OnDragStartHorizontal)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onReturnItem = BindCallback(self, self.__OnReturnItem)
  ;
  ((self.ui).obj_HasSuit):SetActive(false)
  self.athItemPoolList = {}
  for k,go in ipairs((self.ui).athSpaceItemList) do
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

    (self.athItemPoolList)[k] = (UIItemPool.New)(UINAthListItem, go)
  end
  self.athItemGoDic = {}
  self.athGroupItemDic = {}
  self.athHasSuitPool = (UIItemPool.New)(UINAthHasSuitItem, (self.ui).obj_HasSuit)
  self.__onAthItemClick = BindCallback(self, self.OnAthItemClick)
end

UINAthSortListAll.InitAthSortListAll = function(self, areaId, quality, clickItemFunc, itemStartDragFunc, resLoader, withMat)
  -- function num : 0_1 , upvalues : UINAthMatUpgrade
  self.resLoader = resLoader
  self.areaId = areaId
  self.quality = quality
  self.clickItemFunc = clickItemFunc
  self.itemStartDragFunc = itemStartDragFunc
  self.withMat = withMat
  if withMat then
    self.athMatUpNode = (UINAthMatUpgrade.New)()
    ;
    (self.athMatUpNode):Init((self.ui).athUpgradeItemList)
  end
  self:RefreshAthSortListData()
end

UINAthSortListAll.SetNewAthItemFunc = function(self, newItemFunc)
  -- function num : 0_2
  self.newItemFunc = newItemFunc
end

UINAthSortListAll.RefreshAthSortListData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local ignoreInstalled = self.withMat
  self.oriAthDataList = nil
  if self.areaId == nil then
    self.oriAthDataList = (PlayerDataCenter.allAthData):GetAllAthList(nil, ignoreInstalled, self.quality)
  else
    self.oriAthDataList = (PlayerDataCenter.allAthData):GetAllAthSlotList(self.areaId, nil, ignoreInstalled)
  end
end

UINAthSortListAll.RefillAthSortListAll = function(self, funcSift, funcSort, athSuitDic, useLastPos, curFreeSpace)
  -- function num : 0_4 , upvalues : _ENV
  if funcSift ~= nil then
    self.funcSift = funcSift
  end
  if funcSort ~= nil then
    self.funcSort = funcSort
  end
  self.curAthSuitDic = athSuitDic
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
    if not freeSpaceNewLine and curFreeSpace ~= nil and curFreeSpace < size then
      if #tempGroup ~= 0 then
        forceNewLine = true
      end
      freeSpaceNewLine = true
    end
    if forceNewLine or not self:__Insert2TempGroup(tempGroupIdList, tempGroup, athData) then
      tempGroup = {allSize = 0}
      tempGroupIdList = {}
      ;
      (table.insert)(self.curAthDataGroupList, tempGroup)
      self:__Insert2TempGroup(tempGroupIdList, tempGroup, athData)
    end
  end
  self:__RefillList(useLastPos)
end

UINAthSortListAll.__Insert2TempGroup = function(self, tempGroupIdList, tempGroup, athData)
  -- function num : 0_5 , upvalues : groupMaxCount, AthTableUtil, groupXMax, _ENV
  local athSize = athData:GetAthSize()
  for i = 1, groupMaxCount do
    if (athSize ~= 4 and athSize ~= 8) or i % 2 == 1 then
      local gridIdList = (AthTableUtil.GetAthGridIdList)(athData, i, groupXMax)
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
            (table.insert)(tempGroup, {gridId = i, athData = athData})
            return true
          end
          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return false
end

UINAthSortListAll.__RefillList = function(self, useLastPos)
  -- function num : 0_6
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
  if useLastPos then
    ((self.ui).scrollRect):RefreshCells()
  else
    ;
    ((self.ui).scrollRect):RefillCells()
  end
  ;
  ((self.ui).obj_empty):SetActive(((self.ui).scrollRect).totalCount == 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINAthSortListAll.SetAthListMultSeletedUidDic = function(self, dic)
  -- function num : 0_7
  self.athMultSeletedUidDic = dic
end

UINAthSortListAll.__OnDragStartHorizontal = function(self)
  -- function num : 0_8 , upvalues : CS_EventSystem
  local curGo = (CS_EventSystem.current).currentSelectedGameObject
  local item = (self.athItemGoDic)[curGo]
  if item == nil then
    return 
  end
  item:OnAthItemBeginDrag()
end

UINAthSortListAll.GetSortListAthMatUpNode = function(self)
  -- function num : 0_9
  return self.athMatUpNode
end

UINAthSortListAll.__OnNewItem = function(self, go)
  -- function num : 0_10 , upvalues : UINAthSortListAllGroup
  local item = (UINAthSortListAllGroup.New)()
  item:Init(go)
  item:InitAthSortListAllGroup(self.__onReturnAthItem, self.__onReturnAthMatNode)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.athGroupItemDic)[go] = item
end

UINAthSortListAll.__OnChangeItem = function(self, go, index)
  -- function num : 0_11 , upvalues : _ENV, groupMaxCount, spaceIdDic
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
  if groupData.allSize < groupMaxCount then
    (table.sort)(groupData, function(a, b)
    -- function num : 0_11_0
    local sizeA = (a.athData):GetAthSize()
    local sizeB = (b.athData):GetAthSize()
    if (a.athData).uid >= (b.athData).uid then
      do return sizeA ~= sizeB end
      do return sizeB < sizeA end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
    local tempGroup = {allSize = 0}
    local tempGroupIdList = {}
    for k,v in ipairs(groupData) do
      self:__Insert2TempGroup(tempGroupIdList, tempGroup, v.athData)
    end
    groupData = tempGroup
  end
  do
    for k,v in ipairs(groupData) do
      local athSize = (v.athData):GetAthSize()
      local itemPool = (self.athItemPoolList)[spaceIdDic[athSize]]
      local athItem = itemPool:GetOne()
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (athItem.gameObject).name = tostring(R15_PC71)
      if self.newItemFunc ~= nil then
        (self.newItemFunc)(athItem)
      end
      if self.itemStartDragFunc ~= nil then
        athItem:SetAthItemDragFunc(R15_PC71)
      end
      -- DECOMPILER ERROR at PC86: Overwrote pending register: R15 in 'AssignReg'

      -- DECOMPILER ERROR at PC87: Overwrote pending register: R15 in 'AssignReg'

      athItem:SetAthItemRootScrollRectRoot(R15_PC71)
      -- DECOMPILER ERROR at PC90: Overwrote pending register: R15 in 'AssignReg'

      athItem:InitAthListItem(R15_PC71, self.__onAthItemClick, self.resLoader)
      local selected = self.athMultSeletedUidDic ~= nil and (self.athMultSeletedUidDic)[(v.athData).uid] ~= nil
      -- DECOMPILER ERROR at PC105: Overwrote pending register: R15 in 'AssignReg'

      athItem:SetAthItemSelect(selected, true)
      -- DECOMPILER ERROR at PC110: Overwrote pending register: R15 in 'AssignReg'

      local suitId = (v.athData):GetAthSuit()
      -- DECOMPILER ERROR at PC112: Overwrote pending register: R15 in 'AssignReg'

      -- DECOMPILER ERROR at PC115: Overwrote pending register: R15 in 'AssignReg'

      -- DECOMPILER ERROR at PC116: Overwrote pending register: R15 in 'AssignReg'

      -- DECOMPILER ERROR at PC119: Overwrote pending register: R15 in 'AssignReg'

      -- DECOMPILER ERROR at PC120: Overwrote pending register: R15 in 'AssignReg'

      if R15_PC71 ~= nil and R15_PC71 then
        R15_PC71 = R15_PC71(R15_PC71)
        local hasSuitItem = nil
        hasSuitItem:InitAthHasSuitItem(athItem.transform, (self.ui).hasSuitHolder)
        athItem:SetAthItemSuit(hasSuitItem)
      end
      -- DECOMPILER ERROR at PC132: Confused about usage of register: R15 in 'UnsetPending'

      ;
      (self.athItemGoDic)[athItem.gameObject] = athItem
      item:AddAthItem2Group(athItem, v.gridId)
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

UINAthSortListAll.__OnReturnItem = function(self, go)
  -- function num : 0_12
  local groupItem = (self.athGroupItemDic)[go]
  groupItem:ClealAllAthItem()
end

UINAthSortListAll.ReturnAthItem = function(self, athItem)
  -- function num : 0_13 , upvalues : spaceIdDic
  local athSize = (athItem:GetAthItemData()):GetAthSize()
  athItem:TryReturnAthItemSuit(function(hasSuitItem)
    -- function num : 0_13_0 , upvalues : self
    (self.athHasSuitPool):HideOne(hasSuitItem)
  end
)
  local itemPool = (self.athItemPoolList)[spaceIdDic[athSize]]
  ;
  (athItem.transform):SetParent((self.ui).prefabHolder)
  itemPool:HideOne(athItem)
end

UINAthSortListAll.ReturnAthMatNode = function(self)
  -- function num : 0_14
  if self.athMatUpNode ~= nil then
    ((self.athMatUpNode).transform):SetParent((self.ui).prefabHolder)
  end
end

UINAthSortListAll.GetAthItemFromListAll = function(self, uid)
  -- function num : 0_15
  local index = self:__GetAthDataGroupIndexByUid(uid)
  local go = ((self.ui).scrollRect):GetCellByIndex(index - 1)
  if go == nil then
    return nil
  end
  local groupItem = (self.athGroupItemDic)[go]
  return groupItem:GetAthItemFromAllGroup(uid)
end

UINAthSortListAll.__GetAthDataGroupIndexByUid = function(self, uid)
  -- function num : 0_16 , upvalues : _ENV
  for index,v in ipairs(self.curAthDataGroupList) do
    for k,v2 in ipairs(v) do
      if (v2.athData).uid == uid then
        return index
      end
    end
  end
end

UINAthSortListAll.OnAthItemClick = function(self, athItem)
  -- function num : 0_17
  local uid = (athItem:GetAthItemData()):GenAthDataUID()
  local rollIndex = self:__GetAthDataGroupIndexByUid(uid)
  if not self.withMat then
    rollIndex = rollIndex - 1
  end
  ;
  ((self.ui).scrollRect):SrollToCell(rollIndex, 1500, function()
    -- function num : 0_17_0 , upvalues : self, athItem
    if self.clickItemFunc ~= nil then
      (self.clickItemFunc)(athItem)
    end
  end
)
end

UINAthSortListAll.OnDelete = function(self)
  -- function num : 0_18 , upvalues : _ENV, base
  for k,pool in ipairs(self.athItemPoolList) do
    pool:DeleteAll()
  end
  if self.athMatUpNode ~= nil then
    (self.athMatUpNode):Delete()
  end
  ;
  (self.athHasSuitPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthSortListAll

