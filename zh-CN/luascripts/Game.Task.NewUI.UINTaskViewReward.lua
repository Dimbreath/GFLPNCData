-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTaskViewReward = class("UINTaskViewReward", UIBaseWindow)
local base = UIBaseWindow
local UINFloatUINode = require("Game.CommonUI.FloatWin.UINFloatUINode")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINTaskViewReward.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount, UINFloatUINode
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.Hide)
    self.rewardPool = (UIItemPool.New)(UINBaseItemWithCount,
                                       (self.ui).rewardItem);
    ((self.ui).rewardItem):SetActive(false)
    self.floatNode = (UINFloatUINode.New)();
    (self.floatNode):Init((self.ui).frame)
    self:Hide()
end

UINTaskViewReward.FloatTo = function(self, transform, horizontalAlign,
                                     verticalAlign, shiftX, shiftY)
    -- function num : 0_1
    (self.floatNode):FloatTo(transform, horizontalAlign, verticalAlign, shiftX,
                             shiftY)
end

UINTaskViewReward.RefreshItems = function(self, ids, nums, callback)
    -- function num : 0_2 , upvalues : _ENV
    self.callback = callback;
    (self.rewardPool):HideAll()
    for index, id in ipairs(ids) do
        local itemCfg = (ConfigData.item)[id]
        local num = nums[index]
        local item = (self.rewardPool):GetOne()
        item:InitItemWithCount(itemCfg, num, nil)
    end
end

UINTaskViewReward.OnHide = function(self)
    -- function num : 0_3
    if self.callback ~= nil then (self.callback)() end
end

UINTaskViewReward.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINTaskViewReward

