-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthSlotUpgradeSuccess = class("UIAthSlotUpgradeSuccess", UIBaseWindow)
local base = UIBaseWindow
local attrItem = require("Game.Arithmetic.SlotUpgrade.UIAthSlotUpgradeSuccessAttr")
UIAthSlotUpgradeSuccess.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, attrItem
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnDelete)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Completed, self, self.OnDelete)
  self.attrPool = (UIItemPool.New)(attrItem, (self.ui).attriItem)
  ;
  ((self.ui).attriItem):SetActive(false)
end

UIAthSlotUpgradeSuccess.InitInfo = function(self, oldLevel, newLevel, AttrCangeList)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_OldLevel):SetIndex(0, tostring(oldLevel))
  ;
  ((self.ui).tex_NewLevel):SetIndex(0, tostring(newLevel))
  for key,value in ipairs(AttrCangeList) do
    local attr = (self.attrPool):GetOne(true)
    attr:InitInfo(value.name, tostring(value.oldNum), tostring(value.newNum))
  end
end

UIAthSlotUpgradeSuccess.OnDelete = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self.attrPool):HideAll()
  UIManager:HideWindow(UIWindowTypeID.AthSlotUpgradeInfo)
end

return UIAthSlotUpgradeSuccess

