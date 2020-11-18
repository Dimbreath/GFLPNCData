-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthFliterKindItem = class("UIAthFliterKindItem", UIBaseNode)
local base = UIBaseNode
UIAthFliterKindItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).kind_Item, self, self.onClick)
  self.isSelected = false
end

UIAthFliterKindItem.Initkind = function(self, name, clickEvent)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_Condition).text = name
  self.name = name
  self.clickEvent = {}
  self.clickEvent = clickEvent
end

UIAthFliterKindItem.AddOrangeEvent = function(self, clickEvent)
  -- function num : 0_2
  self.orangeEvent = clickEvent
end

UIAthFliterKindItem.RemoveOrangeEvent = function(self)
  -- function num : 0_3
  self.orangeEvent = nil
end

UIAthFliterKindItem.onClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.isSelected = not self.isSelected
  ;
  (((self.ui).img_OnClick).gameObject):SetActive(self.isSelected)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  if not self.isSelected or not (self.ui).kind_highlight then
    ((self.ui).img_Kind).color = Color.white
    if self.clickEvent ~= nil then
      (self.clickEvent)(self.isSelected)
    end
    if self.orangeEvent ~= nil then
      (self.orangeEvent)(self.isSelected)
    end
  end
end

return UIAthFliterKindItem

