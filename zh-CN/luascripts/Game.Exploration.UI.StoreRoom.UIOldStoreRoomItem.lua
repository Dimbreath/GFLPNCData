-- params : ...
-- function num : 0 , upvalues : _ENV
local UIStoreRoomItem = class("UIStoreRoomItem", UIBaseNode)
local base = UIBaseNode
local ChipItemWithName = require("Game.CommonUI.Item.UINChipItemWithName")
UIStoreRoomItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, ChipItemWithName
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnButtonClick)
    self.__onChipClickEvent = BindCallback(self, self.OnChipClickEvent)
    self.ChipItem = (ChipItemWithName.New)();
    (self.ChipItem):Init((self.ui).propItem)
end

UIStoreRoomItem.InitStoreItem = function(self, storeData, onClickAction,
                                         onChipItemClick)
    -- function num : 0_1
    self.chipData = storeData.chipData
    self.idx = storeData.idx
    self.price = ((storeData.chipData).itemCfg).price
    self.onClickAction = onClickAction
    self.onChipItemClick = onChipItemClick;
    (self.ChipItem):InitChipItem(storeData.chipData, 1, self.__onChipClickEvent);
    (self.ChipItem):UpdateChipItem()
    self:__ShowPrice(storeData.discount)
    self:__ShowSaledType(storeData.saled)
end

UIStoreRoomItem.OnChipClickEvent = function(self)
    -- function num : 0_2
    if self.onChipItemClick ~= nil then (self.onChipItemClick)(self) end
end

UIStoreRoomItem.__ShowPrice = function(self, discount)
    -- function num : 0_3 , upvalues : _ENV
    local hasDiscount = false
    if discount ~= nil and discount ~= 0 then
        if discount >= 100 then
            hasDiscount = false
        else
            hasDiscount = true
            self.price = self.price * (discount / 100)
        end
    end
    ((self.ui).disCountNode):SetActive(hasDiscount);
    ((self.ui).tex_disCount):SetIndex(0, tostring(100 - discount)) -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_Price).text = tostring(FormatNum(self.price))
end

UIStoreRoomItem.__ShowSaledType = function(self, isSaled)
    -- function num : 0_4
    if isSaled then
        (((self.ui).btn_Buy).gameObject):SetActive(false);
        ((self.ui).sellOutNode):SetActive(true)
    else

        (((self.ui).btn_Buy).gameObject):SetActive(true);
        ((self.ui).sellOutNode):SetActive(false)
    end
end

UIStoreRoomItem.OnButtonClick = function(self)
    -- function num : 0_5
    if self.onClickAction ~= nil then (self.onClickAction)(self) end
end

UIStoreRoomItem.GetStoreItemName = function(self)
    -- function num : 0_6
    return (self.chipData):GetName()
end

UIStoreRoomItem.OnDelete = function(self)
    -- function num : 0_7
end

return UIStoreRoomItem

