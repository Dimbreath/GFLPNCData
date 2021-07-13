-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthEfccQuickSelectItem = class("UINAthEfccQuickSelectItem", UIBaseNode)
local base = UIBaseNode
UINAthEfccQuickSelectItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Root, self, self.__OnValueChage)
end

UINAthEfccQuickSelectItem.InitAthEfccQuickSelectItem = function(self, index, selectedFunc)
  -- function num : 0_1
  ((self.ui).tex_KindName):SetIndex(index - 1)
  self.index = index
  self.selectedFunc = selectedFunc
end

UINAthEfccQuickSelectItem.__OnValueChage = function(self, isOn)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if not isOn or not Color.black then
    (((self.ui).tex_KindName).text).color = Color.white
    if self.selectedFunc ~= nil then
      (self.selectedFunc)(isOn)
    end
  end
end

UINAthEfccQuickSelectItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthEfccQuickSelectItem

