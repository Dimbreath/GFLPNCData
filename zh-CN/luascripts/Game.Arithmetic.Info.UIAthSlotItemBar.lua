-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Arithmetic.Common.UIAthSlotItemBase")
local UIAthSlotItemBar = class("UIAthSlotItemBar", base)
UIAthSlotItemBar.OnInit = function(self)
    -- function num : 0_0 , upvalues : base, _ENV
    (base.OnInit)(self);
    (base.InitAthItemPool)(self, require("Game.Arithmetic.Info.UIAthItemBar"));
    (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickSlot)
end

UIAthSlotItemBar.InitAthSlotItem = function(self, slotId, space, heroId)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitAthSlotItem)(self, slotId, space, heroId)
    local slotLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotLevel(heroId,
                                                                        slotId)
    local efficiency = (PlayerDataCenter.allAthData):GetAthEfficiency(slotLevel);
    ((self.ui).tex_ATHBarRatio):SetIndex(0, tostring(FormatNum(efficiency / 10)))
end

UIAthSlotItemBar.SetClickEvent = function(self, clickEvent)
    -- function num : 0_2
    self.clickEvent = clickEvent
end

UIAthSlotItemBar.OnClickSlot = function(self)
    -- function num : 0_3
    if self.clickEvent ~= nil then (self.clickEvent)(self.slotId) end
end

UIAthSlotItemBar.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UIAthSlotItemBar

