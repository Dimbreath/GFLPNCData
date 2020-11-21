-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormSortList = class("UIDormSortList", UIBaseNode)
local base = UIBaseNode
local UIDormSortListItemFnt = require(
                                  "Game.Dorm.UI.SortList.UIDormSortListItemFnt")
local UIDormSortListItemRoom = require(
                                   "Game.Dorm.UI.SortList.UIDormSortListItemRoom")
UIDormSortList.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui) -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).scrollView).onInstantiateItem =
        BindCallback(self, self.OnInstantiateItem) -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).scrollView).onChangeItem = BindCallback(self, self.OnItemChange)
    self.itemDic = {}
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

    if ((self.ui).scrollView).horizontal then
        ((self.ui).scrollView).horizontalNormalizedPosition = 1
    end
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

    if ((self.ui).scrollView).vertical then
        ((self.ui).scrollView).verticalNormalizedPosition = 1
    end
end

UIDormSortList.SetItemType = function(self, itemType, isShop)
    -- function num : 0_1 , upvalues : _ENV
    self.itemType = itemType
    self.isShop = isShop or false
    if itemType == eItemType.DormRoom then
        ((self.ui).scrollView):SetPrefab((self.ui).dormRoomItem);
        ((self.ui).dormFntItem):SetActive(false);
        ((self.ui).dormSortConditionNode):SetActive(false)
    else
        if itemType == eItemType.DormFurniture then
            ((self.ui).scrollView):SetPrefab((self.ui).dormFntItem);
            ((self.ui).dormRoomItem):SetActive(false)
        else
            error("itemType error, type = " .. tostring(itemType))
        end
    end
    (((self.ui).scrollView).gameObject):SetActive(true)
end

UIDormSortList.SetItemClickAction = function(self, clickAction)
    -- function num : 0_2
    self.__onDormItemClick = clickAction
end

UIDormSortList.SetItemInstallEvent = function(self, installEvent)
    -- function num : 0_3
    self.__onItemClickInstallEvent = installEvent
end

UIDormSortList.RefreshDormItemList = function(self, origineDataList, funcSift,
                                              funcSort)
    -- function num : 0_4 , upvalues : _ENV
    if origineDataList == nil then
        error("UIDormSortList has error:The origineList is nil")
        return
    end
    self.curDataList = {}
    for index, dormData in ipairs(origineDataList) do
        if funcSift == nil or funcSift(dormData) == true then
            (table.insert)(self.curDataList, dormData)
        end
    end
    if funcSort ~= nil then (table.sort)(self.curDataList, funcSort) end -- DECOMPILER ERROR at PC37: Confused about usage of register: R4 in 'UnsetPending'
    
    ((self.ui).scrollView).totalCount = #self.curDataList;
    ((self.ui).scrollView):RefillCells()
    return self.curDataList
end

UIDormSortList.OnInstantiateItem = function(self, go)
    -- function num : 0_5 , upvalues : _ENV, UIDormSortListItemRoom, UIDormSortListItemFnt
    local dormItem = nil
    if self.itemType == eItemType.DormRoom then
        dormItem = (UIDormSortListItemRoom.New)()
    else
        if self.itemType == eItemType.DormFurniture then
            dormItem = (UIDormSortListItemFnt.New)()
        end
    end
    dormItem:Init(go) -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.itemDic)[go] = dormItem
end

UIDormSortList.OnItemChange = function(self, go, index)
    -- function num : 0_6 , upvalues : _ENV
    local dormData = (self.curDataList)[index + 1]
    local dormItem = (self.itemDic)[go]
    if dormItem == nil then
        error("UIDormSortList error:Can\'t find dormItem")
    end
    if dormData == nil then
        error("UIDormSortList error:Can\'t find dormData")
    end
    if self.itemType == eItemType.DormRoom then
        dormItem:InitSortListItemRoom(dormData, self.isShop,
                                      self.__onDormItemClick)
    else
        if self.itemType == eItemType.DormFurniture then
            dormItem:InitSortListItemFnt(dormData, self.isShop,
                                         self.__onDormItemClick,
                                         self.__onItemClickInstallEvent)
        end
    end
end

UIDormSortList.OnDelete = function(self)
    -- function num : 0_7 , upvalues : _ENV, base
    if self.itemDic ~= nil then
        for go, item in pairs(self.itemDic) do item:OnDelete() end
        self.itemDic = nil
    end
    if self.curDataList ~= nil and #self.curDataList > 0 then
        self.curDataList = nil
    end
    (base.OnDelete)(self)
end

return UIDormSortList

