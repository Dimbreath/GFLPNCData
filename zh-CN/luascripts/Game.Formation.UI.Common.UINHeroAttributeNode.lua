-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroAttributeNode = class("UINHeroAttributeNode", UIBaseNode)
local base = UIBaseNode
local UINHeroAttrItem = require("Game.Formation.UI.Common.UINHeroAttrItem")
UINHeroAttributeNode.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINHeroAttrItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).attriItem):SetActive(false)
    self.attrPool = (UIItemPool.New)(UINHeroAttrItem, (self.ui).attriItem)
end

UINHeroAttributeNode.InitHeroAttrNode = function(self, attrDataList)
    -- function num : 0_1 , upvalues : _ENV
    (self.attrPool):HideAll()
    for k, v in ipairs(attrDataList) do
        local attrItem = (self.attrPool):GetOne()
        attrItem:InitHeroAttrItem(v.attrId, v.attrValue)
    end
end

UINHeroAttributeNode.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINHeroAttributeNode

