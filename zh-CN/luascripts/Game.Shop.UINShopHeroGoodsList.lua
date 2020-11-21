-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopHeroGoodsList = class("UINShopHeroGoodsList", UIBaseNode)
local base = UIBaseNode
local UINShopHeroGoodsItem = require("Game.Shop.UINShopHeroGoodsItem")
UINShopHeroGoodsList.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.ItemDic = {}
    self.dataList = {};
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui) -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).heroItemList).onInstantiateItem =
        BindCallback(self, self.__OnNewItem) -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).heroItemList).onChangeItem =
        BindCallback(self, self.__OnChangeItem)
end

UINShopHeroGoodsList.InitList = function(self, resloader)
    -- function num : 0_1
    self.resloader = resloader
end

UINShopHeroGoodsList.RefreshShelfItems =
    function(self, shopGoodsDic)
        -- function num : 0_2 , upvalues : _ENV
        self.dataList = {}
        for shelfId, goodData in pairs(shopGoodsDic) do
            (table.insert)(self.dataList, goodData)
        end
        local num = #self.dataList -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).heroItemList).totalCount = num;
        ((self.ui).heroItemList):RefillCells()
    end

UINShopHeroGoodsList.__OnNewItem = function(self, go)
    -- function num : 0_3 , upvalues : UINShopHeroGoodsItem
    local goodItem = (UINShopHeroGoodsItem.New)()
    goodItem:Init(go)
    goodItem:InitItem(self.resloader) -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.ItemDic)[go] = goodItem
end

UINShopHeroGoodsList.__OnChangeItem = function(self, go, index)
    -- function num : 0_4 , upvalues : _ENV
    local goodItem = (self.ItemDic)[go]
    if goodItem == nil then
        error("Can\'t find goodItem by gameObject")
        return
    end
    local goodData = (self.dataList)[index + 1]
    if goodData == nil then
        error("Can\'t find goodData by index, index = " .. tostring(index))
    end
    goodItem:InitNormalGoodsItem(goodData)
end

UINShopHeroGoodsList.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINShopHeroGoodsList

