-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthListArea = class("UINAthListArea", UIBaseNode)
local base = UIBaseNode
local UINAthItem = require("Game.Arithmetic.AthList.Area.UINAthItem")
local UINAthListGroup = require("Game.Arithmetic.AthList.Area.UINAthListGroup")
local UINAthListAreaTog = require("Game.Arithmetic.AthList.Area.UINAthListAreaTog")
local AthTableUtil = require("Game.Arithmetic.AthMain.Table.AthTableUtil")
local UINAthMatUpgrade = require("Game.Arithmetic.AthList.Area.MatUpgrade.UINAthMatUpgrade")
local CS_EventSystem = ((CS.UnityEngine).EventSystems).EventSystem
local CS_LayoutRebuilder = ((CS.UnityEngine).UI).LayoutRebuilder
local spaceIdDic = {[1] = 1, [2] = 2, [4] = 3, [8] = 4}
local groupXMax = 6
local groupYMax = 2
local groupMaxCount = groupXMax * groupYMax
local sizeGroupPosIdList = {
[1] = {1, 7, 2, 8, 3, 9, 4, 10, 5, 11, 6, 12}
, 
[2] = {1, 2, 3, 4, 5, 6}
, 
[4] = {1, 2, 3, 4, 5}
}
UINAthListArea.ctor = function(self, athListRoot)
  -- function num : 0_0
  self.athListRoot = athListRoot
end

UINAthListArea.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINAthItem, UINAthListAreaTog
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__onAthItemClick = BindCallback(self, self.OnAthItemClick)
  self.__onReturnAthItem = BindCallback(self, self.ReturnAthItem)
  self.__onReturnAthMatNode = BindCallback(self, self.ReturnAthMatNode)
  self.__onAthListAreaSelect = BindCallback(self, self.__OnAreaSelect)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).OnDragStartHorizontal = BindCallback(self, self.__OnDragStartHorizontal)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.athItemPoolList = {}
  for k,go in ipairs((self.ui).athSpaceItemList) do
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R6 in 'UnsetPending'

    (self.athItemPoolList)[k] = (UIItemPool.New)(UINAthItem, go)
  end
  ;
  ((self.ui).tog_AreaItem):SetActive(false)
  self.areaTogList = (UIItemPool.New)(UINAthListAreaTog, (self.ui).tog_AreaItem)
  for i = 0, (ConfigData.game_config).athSlotCount do
    local togItem = (self.areaTogList):GetOne()
    togItem:InitAthListAreaTog(i, self.__onAthListAreaSelect)
  end
  self.athItemGoDic = {}
  self.athGroupItemDic = {}
  ;
  ((self.ui).selectCount):SetActive(false)
end

UINAthListArea.InitAthListArea = function(self, heroData, areaId, quality, clickItemFunc, itemStartDragFunc, resLoader, withMat, changeAreaFunc, ignoreInstalled)
  -- function num : 0_2 , upvalues : UINAthMatUpgrade
  self.heroData = heroData
  self.resLoader = resLoader
  self.areaId = areaId
  self.quality = quality
  self.clickItemFunc = clickItemFunc
  self.itemStartDragFunc = itemStartDragFunc
  self.withMat = withMat
  if not ignoreInstalled then
    self.ignoreInstalled = self.withMat
    self.changeAreaFunc = changeAreaFunc
    if withMat and self.athMatUpNode == nil then
      self.athMatUpNode = (UINAthMatUpgrade.New)()
      ;
      (self.athMatUpNode):Init((self.ui).athUpgradeItemList)
    end
    local selecteTogItem = ((self.areaTogList).listItem)[(areaId or 0) + 1]
    ;
    ((self.ui).areaTogGroup):SetAllTogglesOff()
    selecteTogItem:SetAthListAreaTogIsOn()
  end
end

UINAthListArea.RefreshAthAreaListData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local ignoreInstalled = self.ignoreInstalled
  self.oriAthDataList = nil
  if self.areaId == nil then
    self.oriAthDataList = (PlayerDataCenter.allAthData):GetAllAthList(nil, ignoreInstalled, self.quality)
  else
    self.oriAthDataList = (PlayerDataCenter.allAthData):GetAllAthSlotList(self.areaId, nil, ignoreInstalled)
  end
end

UINAthListArea.SetAthListAreaSortFunc = function(self, funcSort)
  -- function num : 0_4
  self.funcSort = funcSort
end

UINAthListArea.RefillAthListArea = function(self, funcSift, funcSort, useLastPos)
  -- function num : 0_5 , upvalues : _ENV
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
end

UINAthListArea.__Insert2TempGroup = function(self, tempGroupIdList, tempGroup, athData)
  -- function num : 0_6 , upvalues : sizeGroupPosIdList, _ENV, AthTableUtil, groupXMax, groupMaxCount
  local athSize = athData:GetAthSize()
  local posIdList = sizeGroupPosIdList[athSize]
  for k,posId in ipairs(posIdList) do
    if tempGroupIdList[posId] == nil then
      local gridIdList = (AthTableUtil.GetAthGridIdList)(athData, posId, groupXMax)
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
          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return false
end

UINAthListArea.__RefillList = function(self, useLastPos)
  -- function num : 0_7 , upvalues : _ENV
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

UINAthListArea.SetAthListAreaMultSeletedUidDic = function(self, dic)
  -- function num : 0_8 , upvalues : _ENV
  self.athMultSeletedUidDic = dic
  ;
  ((self.ui).selectCount):SetActive(true)
  ;
  ((self.ui).tex_SelectCount):SetIndex(0, tostring((table.count)(self.athMultSeletedUidDic)))
end

UINAthListArea.__OnDragStartHorizontal = function(self)
  -- function num : 0_9 , upvalues : CS_EventSystem
  local curGo = (CS_EventSystem.current).currentSelectedGameObject
  local item = (self.athItemGoDic)[curGo]
  if item == nil then
    return 
  end
  item:OnAthItemBeginDrag()
end

UINAthListArea.__OnNewItem = function(self, go)
  -- function num : 0_10 , upvalues : UINAthListGroup
  local item = (UINAthListGroup.New)()
  item:Init(go)
  item:InitAthListGroup(self.__onReturnAthItem, self.__onReturnAthMatNode)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.athGroupItemDic)[go] = item
end

UINAthListArea.__OnChangeItem = function(self, go, index)
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
    if a.gridId >= b.gridId then
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

      athItem:InitAthItem(R15_PC71, self.__onAthItemClick, self.resLoader)
      local selected = self.athMultSeletedUidDic ~= nil and (self.athMultSeletedUidDic)[(v.athData).uid] ~= nil
      -- DECOMPILER ERROR at PC105: Overwrote pending register: R15 in 'AssignReg'

      athItem:SetAthItemSelect(selected, true)
      -- DECOMPILER ERROR at PC110: Overwrote pending register: R15 in 'AssignReg'

      local suitId = (v.athData):GetAthSuit()
      -- DECOMPILER ERROR at PC112: Overwrote pending register: R15 in 'AssignReg'

      -- DECOMPILER ERROR at PC115: Overwrote pending register: R15 in 'AssignReg'

      -- DECOMPILER ERROR at PC116: Overwrote pending register: R15 in 'AssignReg'

      -- DECOMPILER ERROR at PC119: Overwrote pending register: R15 in 'AssignReg'

      if R15_PC71 == nil or R15_PC71 then
        do
          R15_PC71[athItem.gameObject] = athItem
          -- DECOMPILER ERROR at PC122: Overwrote pending register: R15 in 'AssignReg'

          R15_PC71(item, athItem, v.gridId)
          -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

UINAthListArea.__OnReturnItem = function(self, go)
  -- function num : 0_12
  local groupItem = (self.athGroupItemDic)[go]
  groupItem:ClealAllAthItem()
end

UINAthListArea.ReturnAthItem = function(self, athItem)
  -- function num : 0_13 , upvalues : spaceIdDic
  local athSize = (athItem:GetAthItemData()):GetAthSize()
  athItem:TryReturnAthItemSuit(function(hasSuitItem)
    -- function num : 0_13_0
  end
)
  local itemPool = (self.athItemPoolList)[spaceIdDic[athSize]]
  ;
  (athItem.transform):SetParent((self.ui).prefabHolder)
  itemPool:HideOne(athItem)
end

UINAthListArea.ReturnAthMatNode = function(self)
  -- function num : 0_14
  if self.athMatUpNode ~= nil then
    ((self.athMatUpNode).transform):SetParent((self.ui).prefabHolder)
  end
end

UINAthListArea.GetAthItemFromListAll = function(self, uid)
  -- function num : 0_15
  local index = self:__GetAthDataGroupIndexByUid(uid)
  local go = ((self.ui).scrollRect):GetCellByIndex(index - 1)
  if go == nil then
    return nil
  end
  local groupItem = (self.athGroupItemDic)[go]
  return groupItem:GetAthItemFromAllGroup(uid)
end

UINAthListArea.__GetAthDataGroupIndexByUid = function(self, uid)
  -- function num : 0_16 , upvalues : _ENV
  for index,v in ipairs(self.curAthDataGroupList) do
    for k,v2 in ipairs(v) do
      if (v2.athData).uid == uid then
        return index
      end
    end
  end
end

UINAthListArea.OnAthItemClick = function(self, athItem)
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

UINAthListArea.__OnAreaSelect = function(self, areaId)
  -- function num : 0_18
  if areaId == 0 then
    areaId = nil
  end
  self:ChangeAthListArea(areaId)
  if self.changeAreaFunc ~= nil then
    (self.changeAreaFunc)(areaId)
  end
end

UINAthListArea.ChangeAthListArea = function(self, areaId)
  -- function num : 0_19
  self.areaId = areaId
  self:RefreshAthAreaListData()
  self:RefillAthListArea()
end

UINAthListArea.GetAthListAreaMatUpNode = function(self)
  -- function num : 0_20
  return self.athMatUpNode
end

UINAthListArea.GetAthListAreaCurAthList = function(self)
  -- function num : 0_21
  return self.curAthDataList
end

UINAthListArea.OnDelete = function(self)
  -- function num : 0_22 , upvalues : _ENV, base
  for k,pool in ipairs(self.athItemPoolList) do
    pool:DeleteAll()
  end
  ;
  (self.areaTogList):DeleteAll()
  if self.athMatUpNode ~= nil then
    (self.athMatUpNode):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINAthListArea

