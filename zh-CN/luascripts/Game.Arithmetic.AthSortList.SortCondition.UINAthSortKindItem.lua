-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSortKindItem = class("UINAthSortKindItem", UIBaseNode)
local base = UIBaseNode
local AthFilterEnum = require("Game.Arithmetic.AthSortList.AthFilterEnum")
UINAthSortKindItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_kindItem, self, self.__OnKindItemClick)
  self.select = false
  self:SetSelectUIActive()
end

UINAthSortKindItem.InitAthSortKindItem = function(self, kindType, index, onSelectFunc)
  -- function num : 0_1 , upvalues : AthFilterEnum, _ENV
  self.kindType = kindType
  self.index = index
  self.onSelectFunc = onSelectFunc
  if kindType == (AthFilterEnum.eKindType).Quality then
    ((self.ui).tex_KindName):SetIndex(index)
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

    if kindType == (AthFilterEnum.eKindType).Attribute then
      (((self.ui).tex_KindName).text).text = ConfigData:GetAttribute((AthFilterEnum.eAttribute)[index])
    end
  end
end

UINAthSortKindItem.__OnKindItemClick = function(self)
  -- function num : 0_2
  self.select = not self.select
  self:SetSelectUIActive()
  if self.onSelectFunc ~= nil then
    (self.onSelectFunc)(self.kindType, self.index, self.select)
  end
end

UINAthSortKindItem.SetSelectUIActive = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).obj_OnSelect):SetActive(self.select)
  if not self.select or not Color.black then
    local selColor = Color.white
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).tex_KindName).text).color = selColor
end

UINAthSortKindItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthSortKindItem

