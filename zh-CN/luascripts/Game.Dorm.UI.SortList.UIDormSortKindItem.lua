-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormSortKindItem = class("UIDormSortKindItem", UIBaseNode)
local base = UIBaseNode
local eSortKindType, eSortKindTypeMax = (table.unpack)(require("Game.Dorm.UI.SortList.DormSortKindHelper"))
UIDormSortKindItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).kind_Item, self, self.OnBtnKindClicked)
  ;
  ((self.ui).kind_Item):SetActive(false)
end

UIDormSortKindItem.InitDormSortKindItem = function(self, type, index, onClickAction)
  -- function num : 0_1 , upvalues : eSortKindType, _ENV
  self.index = index
  self.type = type
  self.onClickAction = onClickAction
  self:OnItemSelect(false)
  ;
  ((self.ui).tex_Condition):SetIndex(type + index - 1)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

  if type == eSortKindType.Star then
    ((self.ui).img_Pic).sprite = CRH:GetSprite("star_" .. tostring(index), CommonAtlasType.CareerCamp)
  else
    ;
    (((self.ui).img_Pic).gameObject):SetActive(false)
  end
end

UIDormSortKindItem.OnBtnKindClicked = function(self)
  -- function num : 0_2
  self:OnItemSelect(not self.isSelect)
  if self.onClickAction ~= nil then
    (self.onClickAction)(self)
  end
end

UIDormSortKindItem.OnItemSelect = function(self, active)
  -- function num : 0_3 , upvalues : _ENV
  self.isSelect = active
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if not active or not (self.ui).kind_highlight then
    ((self.ui).img_Kind).color = Color.white
  end
end

UIDormSortKindItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormSortKindItem

