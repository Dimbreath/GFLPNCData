-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Arithmetic.Common.UIAthSlotItemBase")
local UIAthSlotItemSwitch = class("UIAthSlotItemSwitch", base)
UIAthSlotItemSwitch.OnInit = function(self)
    -- function num : 0_0 , upvalues : base, _ENV
    (base.OnInit)(self);
    (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickSlot)
end

UIAthSlotItemSwitch.InitAthSlotItem = function(self, slotId, space, heroId)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitAthSlotItem)(self, slotId, space, heroId)
    local slotLevel = (PlayerDataCenter.allAthData):GetHeroAthSlotLevel(heroId,
                                                                        slotId)
    local efficiency = (PlayerDataCenter.allAthData):GetAthEfficiency(slotLevel);
    ((self.ui).tex_ATHBarRatio):SetIndex(0, tostring(FormatNum(efficiency / 10)))
end

UIAthSlotItemSwitch.SetClickEvent = function(self, clickEvent)
    -- function num : 0_2
    self.clickEvent = clickEvent
end

UIAthSlotItemSwitch.OnClickSlot = function(self)
    -- function num : 0_3
    if self.clickEvent ~= nil then (self.clickEvent)(self.slotId) end
end

UIAthSlotItemSwitch.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UIAthSlotItemSwitch

