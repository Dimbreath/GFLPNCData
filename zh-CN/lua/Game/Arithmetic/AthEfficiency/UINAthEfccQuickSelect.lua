local UINAthEfccQuickSelect = class("UINAthEfccQuickSelect", UIBaseNode)
local base = UIBaseNode
local UINAthEfccQuickSelectItem = require("Game.Arithmetic.AthEfficiency.UINAthEfccQuickSelectItem")
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")
UINAthEfccQuickSelect.ctor = function(self)
  -- function num : 0_0
end

UINAthEfccQuickSelect.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINAthEfccQuickSelectItem, AthEnum
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.__OnClickClose)
  self._OnSelectItemFunc = BindCallback(self, self._OnSelectItem)
  ;
  ((self.ui).sortKindItem):SetActive(false)
  self.selectItemPool = (UIItemPool.New)(UINAthEfccQuickSelectItem, (self.ui).sortKindItem)
  for index = 1, AthEnum.AthEfccQuickSelectEnumNum do
    local selectItem = (self.selectItemPool):GetOne()
    selectItem:InitAthEfccQuickSelectItem(index, self._OnSelectItemFunc)
  end
end

UINAthEfccQuickSelect.InitAthEfccQuickSelect = function(self, quickSelectFunc, withoutMat)
  -- function num : 0_2 , upvalues : AthEnum
  self.quickSelectFunc = quickSelectFunc
  if withoutMat then
    (((self.selectItemPool).listItem)[(AthEnum.AthEfccQuickSelectEnum).Material]):Hide()
  end
end

UINAthEfccQuickSelect.OnShow = function(self)
  -- function num : 0_3
  self._cancelSelect = false
end

UINAthEfccQuickSelect._OnSelectItem = function(self, isOn)
  -- function num : 0_4
  if isOn then
    self:__OnClickClose()
  else
    self._cancelSelect = true
  end
end

UINAthEfccQuickSelect.__OnClickClose = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local selectId = nil
  for k,item in ipairs((self.selectItemPool).listItem) do
    if ((item.ui).tog_Root).isOn then
      selectId = item.index
      break
    end
  end
  do
    if self.quickSelectFunc ~= nil and (selectId ~= nil or self._cancelSelect) then
      (self.quickSelectFunc)(selectId)
    end
    self:Hide()
  end
end

UINAthEfccQuickSelect.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.selectItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthEfccQuickSelect

