-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormShop = class("UIDormShop", UIBaseWindow)
local base = UIBaseWindow
local UIDormSortList = require("Game.Dorm.UI.SortList.UIDormSortList")
UIDormShop.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UIDormSortList
    (UIUtil.AddButtonListener)((self.ui).btn_Return, self,
                               self.OnBtnReturnClicked)
    self.sortListNode = (UIDormSortList.New)();
    (self.sortListNode):Init((self.ui).dormSortList)
end

UIDormShop.InitDormShop = function(self, itemType, shopData)
    -- function num : 0_1 , upvalues : _ENV
    self.itemType = itemType
    local index = 0
    if itemType == eItemType.DormRoom then
        index = 1
    else
        if itemType == eItemType.DormFurniture then index = 0 end
    end
    ((self.ui).tex_Name):SetIndex(index);
    ((self.ui).tex_EnName):SetIndex(index);
    ((self.ui).tex_ShopName):SetIndex(index);
    ((self.ui).tex_EnShopName):SetIndex(index);
    (self.sortListNode):SetItemType(itemType, true);
    (self.sortListNode):SetItemClickAction(
        BindCallback(self, self.OnDormShopItemClicked))
    local data = nil
    if shopData == nil or shopData.data == nil then
        data = {}
    else
        data = shopData.data
    end
    (self.sortListNode):RefreshDormItemList(data)
end

UIDormShop.OnDormShopItemClicked = function(self, item)
    -- function num : 0_2 , upvalues : _ENV
    if item.isSellOut then return end
    if (item.itemCfg).type == eItemType.DormRoom then
        UIManager:ShowWindowAsync(UIWindowTypeID.DormRoomDetail,
                                  function(window)
            -- function num : 0_2_0 , upvalues : item
            window:InitRoomDetail(item, true)
        end)
    else
        if (item.itemCfg).type == eItemType.DormFurniture then
            UIManager:ShowWindowAsync(UIWindowTypeID.DormFntDetail,
                                      function(window)
                -- function num : 0_2_1 , upvalues : item
                window:InitFntDetail(item, true)
            end)
        end
    end
end

UIDormShop.OnBtnReturnClicked = function(self)
    -- function num : 0_3
    self:Delete()
end

UIDormShop.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    if self.sortListNode ~= nil then
        (self.sortListNode):Delete()
        self.sortListNode = nil
    end
    (base.OnDelete)(self)
end

return UIDormShop

