local UINAvgChooseItem = class("UINAvgChooseItem", UIBaseNode)
local base = UIBaseNode
UINAvgChooseItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickRootBtn)
end

UINAvgChooseItem.InitAvgChooseItem = function(self, index, content, clickEvent, couldNotSelect)
  -- function num : 0_1 , upvalues : _ENV
  self.index = index
  self.clickEvent = clickEvent
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).rootBtn).interactable = not couldNotSelect
  ;
  ((self.ui).tex_Tile):SetIndex(0, tostring(index))
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ChooseText).text = content
end

UINAvgChooseItem.OnClickRootBtn = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.index)
  end
end

UINAvgChooseItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINAvgChooseItem

