-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSortListAll = class("UINAthSortListAll", UIBaseNode)
local base = UIBaseNode
local UINAthListItem = require("Game.Arithmetic.AthSortList.UINAthListItem")
local UINAthSortListAllGroup = require("Game.Arithmetic.AthSortList.UINAthSortListAllGroup")
local UINAthHasSuitItem = require("Game.Arithmetic.AthSortList.UINAthHasSuitItem")
local CS_EventSystem = ((CS.UnityEngine).EventSystems).EventSystem
local CS_LayoutRebuilder = ((CS.UnityEngine).UI).LayoutRebuilder
local spaceIdDic = {[1] = 1, [2] = 2, [4] = 3, [8] = 4}
UINAthSortListAll.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthListItem, UINAthSortListAllGroup, UINAthHasSuitItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).OnDragStartHorizontal = BindCallback(self, self.__OnDragStartHorizontal)
  ;
  ((self.ui).obj_HasSuit):SetActive(false)
  self.athItemPoolList = {}
  for k,go in ipairs((self.ui).athSpaceItemList) do
    (go.transform):SetParent((self.ui).prefabHolder)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.athItemPoolList)[k] = (UIItemPool.New)(UINAthListItem, go)
  end
  self.athGroupPoolList = {}
  for k,go in ipairs((self.ui).athSpaceGroupList) do
    (go.transform):SetParent((self.ui).prefabHolder)
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.athGroupPoolList)[k] = (UIItemPool.New)(UINAthSortListAllGroup, go)
  end
  self.athHasSuitPool = (UIItemPool.New)(UINAthHasSuitItem, (self.ui).obj_HasSuit)
end

UINAthSortListAll.InitAthSortListAll = function(self, areaId, clickItemFunc, resLoader, ignoreInstalled)
  -- function num : 0_1
  self.resLoader = resLoader
  self.areaId = areaId
  self.clickItemFunc = clickItemFunc
  self.ignoreInstalled = ignoreInstalled
  self:RefreshAthSortListData()
end

UINAthSortListAll.SetNewAthItemFunc = function(self, newItemFunc)
  -- function num : 0_2
  self.newItemFunc = newItemFunc
end

UINAthSortListAll.RefreshAthSortListData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.oriAthDataList = nil
  if self.areaId == nil then
    self.oriAthDataList = (PlayerDataCenter.allAthData):GetAllAthList(nil, self.ignoreInstalled)
  else
    self.oriAthDataList = (PlayerDataCenter.allAthData):GetAllAthSlotList(self.areaId, nil, self.ignoreInstalled)
  end
end

UINAthSortListAll.RefillAthSortListAll = function(self, funcSift, funcSort, athSuitDic)
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
  local curSpace, curGroup = nil, nil
  for k,athData in ipairs(self.curAthDataList) do
    local athSize = athData:GetAthSize()
    if athSize ~= curSpace then
      curSpace = athSize
      curGroup = {}
      ;
      (table.insert)(self.curAthDataGroupList, curGroup)
    end
    ;
    (table.insert)(curGroup, athData)
  end
  self:__RefillList()
end

UINAthSortListAll.__RefillList = function(self)
  -- function num : 0_5 , upvalues : _ENV, spaceIdDic, CS_LayoutRebuilder
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).scrollRect).verticalNormalizedPosition = 1
  ;
  (self.athHasSuitPool):HideAll()
  for k,pool in ipairs(self.athItemPoolList) do
    pool:HideAll()
  end
  for k,pool in ipairs(self.athGroupPoolList) do
    pool:HideAll()
  end
  self.athItemGoDic = {}
  for k1,dataGroup in ipairs(self.curAthDataGroupList) do
    local size = (dataGroup[1]):GetAthSize()
    local spaceId = spaceIdDic[size]
    local pool = (self.athGroupPoolList)[spaceId]
    local groupItem = pool:GetOne()
    ;
    (groupItem.transform):SetParent(((self.ui).scrollRect).content)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (groupItem.gameObject).name = tostring(k1)
    for k2,athData in ipairs(dataGroup) do
      local itemPool = (self.athItemPoolList)[spaceId]
      local athItem = itemPool:GetOne()
      ;
      (athItem.transform):SetParent(groupItem.transform)
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R17 in 'UnsetPending'

      ;
      (athItem.gameObject).name = tostring(k2)
      if self.newItemFunc ~= nil then
        (self.newItemFunc)(athItem)
      end
      athItem:SetAthItemRootScrollRectRoot((self.ui).scrollRect)
      athItem:InitAthListItem(athData, self.clickItemFunc, self.resLoader)
      if self.athMultSeletedUidDic ~= nil and (self.athMultSeletedUidDic)[athData.uid] ~= nil then
        athItem:SetAthItemSelect(true, true)
      end
      local suitId = athData:GetAthSuit()
      do
        do
          if self.curAthSuitDic ~= nil and (self.curAthSuitDic)[suitId] then
            local hasSuitItem = (self.athHasSuitPool):GetOne()
            hasSuitItem:InitAthHasSuitItem(athItem.transform, (self.ui).hasSuitHolder)
          end
          -- DECOMPILER ERROR at PC110: Confused about usage of register: R18 in 'UnsetPending'

          ;
          (self.athItemGoDic)[athItem.gameObject] = athItem
          -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  ;
  (CS_LayoutRebuilder.ForceRebuildLayoutImmediate)(((self.ui).scrollRect).content)
end

UINAthSortListAll.SetAthListMultSeletedUidDic = function(self, dic)
  -- function num : 0_6
  self.athMultSeletedUidDic = dic
end

UINAthSortListAll.__OnDragStartHorizontal = function(self)
  -- function num : 0_7 , upvalues : CS_EventSystem
  local curGo = (CS_EventSystem.current).currentSelectedGameObject
  local item = (self.athItemGoDic)[curGo]
  if item == nil then
    return 
  end
  item:OnAthItemBeginDrag()
end

UINAthSortListAll.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  for k,pool in ipairs(self.athItemPoolList) do
    pool:DeleteAll()
  end
  for k,pool in ipairs(self.athGroupPoolList) do
    pool:DeleteAll()
  end
  ;
  (self.athHasSuitPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthSortListAll

