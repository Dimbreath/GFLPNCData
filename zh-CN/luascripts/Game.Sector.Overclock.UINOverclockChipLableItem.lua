-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOverclockChipLableItem = class("UINOverclockChipLableItem", UIBaseNode)
local base = UIBaseNode
local UINOverclockChipItem = require(
                                 "Game.Sector.Overclock.UINOverclockChipItem")
UINOverclockChipLableItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINOverclockChipItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.chipItemPool = (UIItemPool.New)(UINOverclockChipItem,
                                         (self.ui).obj_sortChipKindItem);
    ((self.ui).obj_sortChipKindItem):SetActive(false)
end

UINOverclockChipLableItem.InitLable = function(self, quality, chipList,
                                               selectedChipItem)
    -- function num : 0_1 , upvalues : _ENV
    ((self.ui).tex_Type):SetIndex(quality);
    (self.chipItemPool):HideAll()
    local chipItemDic = {}
    for _, data in pairs(chipList) do
        local chipItem = (self.chipItemPool):GetOne(true)
        chipItem:InitChipItem(data, selectedChipItem)
        chipItemDic[(chipItem.data).dataId] = chipItem
    end
    return chipItemDic
end

UINOverclockChipLableItem.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINOverclockChipLableItem

