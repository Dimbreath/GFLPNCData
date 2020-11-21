-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthFliterItem = class("UIAthFliterItem", UIBaseNode)
local base = UIBaseNode
local UIAthkindItem = require("Game.Arithmetic.SlotUpgrade.UIAthFliterKindItem")
UIAthFliterItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UIAthkindItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).kind_Item):SetActive(false)
    self.kindItemPool = (UIItemPool.New)(UIAthkindItem, (self.ui).kind_Item)
    self.kindItemList = {}
end

UIAthFliterItem.InitName = function(self, name)
    -- function num : 0_1
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).tex_FliterName).text = name
end

UIAthFliterItem.InitKindOptions = function(self, options)
    -- function num : 0_2 , upvalues : _ENV
    for _, option in ipairs(options) do
        local e = (self.kindItemPool):GetOne(true)
        e:Initkind(option.optionName, option.callback);
        (table.insert)(self.kindItemList, e)
    end
end

UIAthFliterItem.CleanSelect = function(self)
    -- function num : 0_3 , upvalues : _ENV
    for index, value in ipairs(self.kindItemList) do
        if value.isSelected then value:onClick() end
    end
end

return UIAthFliterItem

