-- params : ...
-- function num : 0 , upvalues : _ENV
local UIViewItems = class("UIViewItems", UIBaseWindow)
local base = UIBaseWindow
local UIViewItemsGroup = require("Game.ViewItems.UIViewItemsGroup")
UIViewItems.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.itemGroupDataList = nil
    self.ItemDic = {};
    (UIUtil.AddButtonListener)((self.ui).btn_mask_Close, self, self.Hide) -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).loop_itemTypeList).onInstantiateItem =
        BindCallback(self, self.__LevelChipListInitItem) -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).loop_itemTypeList).onChangeItem =
        BindCallback(self, self.__LevelChipListItemChanged)
end

UIViewItems.InitItems = function(self, itemList, resloader)
    -- function num : 0_1 , upvalues : _ENV
    local itemGroupDataDic = {}
    for index, itemData in ipairs(itemList) do
        local drop_type = (itemData.itemCfg).drop_type
        if itemGroupDataDic[drop_type] == nil then
            itemGroupDataDic[drop_type] = {}
        end
        (table.insert)(itemGroupDataDic[drop_type], itemData)
    end
    self.itemGroupDataList = {}
    for typeId, itemList in pairs(itemGroupDataDic) do
        (table.insert)(self.itemGroupDataList,
                       {typeId = typeId, itemList = itemList})
    end -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'
    
    ((self.ui).loop_itemTypeList).totalCount = #self.itemGroupDataList;
    ((self.ui).loop_itemTypeList):RefillCells()
end

UIViewItems.__LevelChipListInitItem = function(self, go)
    -- function num : 0_2 , upvalues : UIViewItemsGroup
    local ItemGroupItem = (UIViewItemsGroup.New)()
    ItemGroupItem:Init(go) -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.ItemDic)[go] = ItemGroupItem
end

UIViewItems.__LevelChipListItemChanged =
    function(self, go, index)
        -- function num : 0_3 , upvalues : _ENV
        local ItemGroupItem = (self.ItemDic)[go]
        if ItemGroupItem == nil then
            error("Can\'t find ItemGroupItem by gameObject")
            return
        end
        index = index + 1
        local itemGroupData = (self.itemGroupDataList)[index]
        if itemGroupData == nil then
            error("Can\'t find itemGroupData by index:" .. tonumber(index))
        end
        ItemGroupItem:InitGroup(itemGroupData)
    end

UIViewItems.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UIViewItems

