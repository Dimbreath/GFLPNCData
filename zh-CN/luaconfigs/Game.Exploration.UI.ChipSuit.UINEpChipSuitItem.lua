-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpChipSuitItem = class("UINEpChipSuitItem", UIBaseNode)
local SuitGridSize = 16
UINEpChipSuitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Select, self, self.OnBtnSuitSelect)
end

UINEpChipSuitItem.InitEpChipSuitItem = function(self, chipsuit, clickEvent)
  -- function num : 0_1 , upvalues : _ENV, SuitGridSize
  self.__chipSuit = chipsuit
  self.__clickEvent = clickEvent
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = chipsuit:GetChipSuitIconSprite()
  ;
  ((self.ui).tex_Count):SetIndex(0, tostring(chipsuit:GetChipSuitCount()), tostring(chipsuit:GetChipSuitMaxCount()))
  local sizeDelta = ((self.ui).img_MaxCount).sizeDelta
  sizeDelta.x = chipsuit:GetChipSuitMaxCount() * SuitGridSize
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_MaxCount).sizeDelta = sizeDelta
  sizeDelta = ((self.ui).img_Count).sizeDelta
  sizeDelta.x = chipsuit:GetChipSuitCount() * SuitGridSize
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Count).sizeDelta = sizeDelta
end

UINEpChipSuitItem.GetDynChipSuit = function(self)
  -- function num : 0_2
  return self.__chipSuit
end

UINEpChipSuitItem.OnBtnSuitSelect = function(self)
  -- function num : 0_3
  if self.__clickEvent ~= nil then
    (self.__clickEvent)(self)
  end
end

return UINEpChipSuitItem

