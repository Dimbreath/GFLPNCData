local UINSortButtonItem = class("UINSortButtonGroup", UIBaseNode)
local base = UIBaseNode
UINSortButtonItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SortItem, self, self.OnButtonClick)
  self:SetAllStateUI(false)
end

UINSortButtonItem.InitSortButtonItem = function(self, sortType, isAscend, clickAction)
  -- function num : 0_1
  self.sortType = sortType
  self.clickAction = clickAction
  self.isAscend = isAscend
  ;
  ((self.ui).tex_SortName):SetIndex(sortType)
end

UINSortButtonItem.OnButtonClick = function(self)
  -- function num : 0_2
  if self.clickAction ~= nil then
    (self.clickAction)(self.sortType)
  end
end

UINSortButtonItem.ReversalAscend = function(self)
  -- function num : 0_3
  self.isAscend = not self.isAscend
  self:RefeshSortStateUI()
end

UINSortButtonItem.SetAllStateUI = function(self, active)
  -- function num : 0_4
  ((self.ui).obj_Ascend):SetActive(active)
  ;
  ((self.ui).obj_Descend):SetActive(active)
end

UINSortButtonItem.RefeshSortStateUI = function(self)
  -- function num : 0_5
  ((self.ui).obj_Ascend):SetActive(self.isAscend)
  ;
  ((self.ui).obj_Descend):SetActive(not self.isAscend)
end

UINSortButtonItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINSortButtonItem

