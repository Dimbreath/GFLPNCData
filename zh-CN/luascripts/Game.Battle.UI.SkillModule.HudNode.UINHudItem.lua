-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHudItem = class("UINHudItem", UIBaseNode)
local base = UIBaseNode
local UINHudTextItem = require(
                           "Game.Battle.UI.SkillModule.HudNode.UINHudTextItem")
UINHudItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINHudTextItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).hUDTextItem):SetActive(false)
    self.textItemPool = (UIItemPool.New)(UINHudTextItem, (self.ui).hUDTextItem)
    for i = 1, (self.ui).itemCount do
        local textItem = (self.textItemPool):GetOne();
        (textItem.transform):SetAsFirstSibling()
    end
end

UINHudItem.RefreshHudItem = function(self, startNum)
    -- function num : 0_1 , upvalues : _ENV
    for k, textItem in ipairs((self.textItemPool).listItem) do
        local num = startNum + (k - 1) * 5
        textItem:RefreshHudTextItem(num)
    end
end

UINHudItem.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINHudItem

