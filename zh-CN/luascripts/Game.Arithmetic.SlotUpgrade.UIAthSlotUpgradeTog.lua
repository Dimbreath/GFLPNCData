-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthSlotUpgradeTog = class("UIAthSlotUpgradeTog", UIBaseNode)
local base = UIBaseNode
UIAthSlotUpgradeTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_ATHBarAreaItem, self, self.OnTogClick)
end

UIAthSlotUpgradeTog.SetTitle = function(self, heroName, slotId)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_AreaName):SetIndex(0, heroName, tostring(slotId))
end

UIAthSlotUpgradeTog.OnTogClick = function(self, value)
  -- function num : 0_2
  if self.ClickEvent ~= nil and value then
    (self.ClickEvent)()
  end
end

UIAthSlotUpgradeTog.SetClikEvent = function(self, event)
  -- function num : 0_3
  self.ClickEvent = event
end

return UIAthSlotUpgradeTog

